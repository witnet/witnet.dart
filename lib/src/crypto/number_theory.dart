
import 'dart:math';

final _bigFF = BigInt.from(0xff);

BigInt randomPrimeBigInt(int bits, {required Random random}) {
  random = Random.secure();

  while (true) {
    var next = randomBigInt(bits, random: random);
    if (next.isEven) next = next | BigInt.one;

    while (next.bitLength == bits) {
      if (next.isPrime()) {
        return next;
      }
      next += BigInt.two;
    }
  }
}

BigInt randomBigInt(int bits, {BigInt? max, Random? random}) {
  random ??= Random(DateTime.now().millisecondsSinceEpoch);

  if (max != null) {
    if (max.bitLength != bits) {
      throw Exception('limit must have bitLength of bits');
    }
  }

  final numBytes = (bits / 8).ceil();

  var ret = BigInt.zero;
  bool lessThanMax = max == null;

  for (int i = 0; i < numBytes; i++) {
    int next = random.nextInt(256);

    // For first byte, get rid of excess leading bits
    if (i == 0) {
      final unneededBits = (numBytes * 8) - bits;
      final neededBits = 8 - unneededBits;
      next &= (1 << neededBits) - 1;
      next |= 1 << neededBits - 1;
    }

    // Make sure generated number is less than [max]
    if (!lessThanMax) {
      final maxByte = ((max! >> ((numBytes - i - 1) * 8)) & _bigFF).toInt();
      if(next >= maxByte) {
        int mask = (next ^ maxByte) & next;
        int maskMask = 0x80;
        if(i == 0) {
          int safeBits = bits - (numBytes - 1) * 8;
          if(safeBits == 1) {
            maskMask = 0;
          } else {
            maskMask = 1 << (safeBits - 2);
          }
        }
        while (maskMask != 0) {
          final isBit = mask & maskMask;
          if (isBit != 0) {
            next &= ~maskMask;

            if (next < maxByte) {
              lessThanMax = true;
              break;
            }
          }

          if (maxByte & maskMask != 0) {
            next &= ~maskMask;

            if (next < maxByte) {
              lessThanMax = true;
              break;
            }
          }

          maskMask >>= 1;
        }
      } else {
        lessThanMax = true;
      }
    }

    ret <<= 8;
    ret |= BigInt.from(next);
  }

  return ret;
}
extension BigIntBit on BigInt {
  int get trailingZeroBits {
    if (this == BigInt.zero) return 0;

    int ret = 0;

    int numberInt;

    {
      var number = this;
      numberInt = (number & BigInt.from(0xffffffff)).toInt();
      while (numberInt == 0) {
        number >>= 32;
        ret += 32;
      }
    }

    if (numberInt.isOdd) return ret;

    if (numberInt & 0xffff == 0) {
      numberInt >>= 16;
      ret += 16;
    }

    if (numberInt.isOdd) return ret;

    if ((numberInt & 0xff) == 0) {
      numberInt >>= 8;
      ret += 8;
    }

    if (numberInt & 0xf == 0) {
      numberInt >>= 4;
      ret += 4;
    }

    if (numberInt & 0x3 == 0) {
      numberInt >>= 2;
      ret += 2;
    }

    if (numberInt & 1 == 0) ++ret;

    return ret;
  }
}

extension BigIntPrime on BigInt {
  bool isPrime({int millerRabinReps = 20}) {
    if (this == BigInt.two) return true;
    if (isEven) return false;

    if (this <= BigInt.from(smallPrimes.last)) {
      return smallPrimes.contains(toInt());
    }

    final mod = this % smallPrimesProduct;

    for (final prime in smallPrimes) {
      if (mod % BigInt.from(prime) == BigInt.zero) {
        return false;
      }
    }

    if (!probablyPrimeMillerRabin(millerRabinReps)) return false;
    // TODO if (!probablyPrimeLucas()) return false;

    return true;
  }

  bool probablyPrimeMillerRabin(int reps, {bool force2 = true}) {
    final nMinus1 = this - BigInt.one;
    final k = nMinus1.trailingZeroBits;
    final q = nMinus1 >> k;

    // Used to generate a, so that a is greater than 2
    final nMinus3 = this - BigInt.two;
    final nMinus3BitLength = nMinus3.bitLength;

    nextRep:
    for (int rep = 0; rep < reps; rep++) {
      var a = randomBigInt(nMinus3BitLength, max: nMinus3) + BigInt.two;
      var modulo = a.modPow(q, this);

      if (modulo == BigInt.one || modulo == nMinus1) continue nextRep;

      for (int j = 1; j < k; j++) {
        modulo *= modulo;
        modulo = modulo % this;

        if (modulo == nMinus1) {
          continue nextRep;
        }
        if (modulo == BigInt.one) {
          return false;
        }
      }

      return false;
    }

    return true;
  }
  static const smallPrimes = <int>[
    3,
    5,
    7,
    11,
    13,
    17,
    19,
    23,
    29,
    31,
    37,
    41,
    43,
    47,
    53,
    59,
    61
  ];

  static final smallPrimesProduct = BigInt.parse('58644190679703485491635');
}


BigInt positiveMod(BigInt n, BigInt modN) {
  return (n % modN + modN) % modN;
}

BigInt inverseMulti(BigInt x, BigInt modNum) {
  // x1 * x + x2 * y = x3
  var x1 = BigInt.one;
  var x2 = BigInt.zero;
  var x3 = modNum;

  // y1 * x + y2 * y = y3
  var y1 = BigInt.zero;
  var y2 = BigInt.one;
  var y3 = (x % modNum + modNum) % modNum;

  BigInt q;
  BigInt t1, t2, t3;
  while (true) {
    if (y3 == BigInt.zero) {
      throw ('multiplicative inverse modulo is no answer!');
    }
    if (y3 == BigInt.one) return y2;

    q = BigInt.from(x3 / y3);

    t1 = x1 - q * y1;
    t2 = x2 - q * y2;
    t3 = x3 - q * y3;

    x1 = y1;
    x2 = y2;
    x3 = y3;

    y1 = t1;
    y2 = t2;
    y3 = t3;
  }
}