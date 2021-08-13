import 'dart:typed_data';

import 'public_key.dart';
import 'secp256k1.dart';
import '../number_theory.dart';

import 'package:witnet/utils.dart' show
  bigIntToBytes, bytesToBigInt, bytesToHex, concatBytes, hexToBytes;

class WitSignature {
  late BigInt R;
  late BigInt S;

  WitSignature(this.R, this.S) {
    if (S > secp256k1.n ~/ BigInt.two) {
      print('normalized s value');
      S = secp256k1.n - S;
    }
  }

  WitSignature.fromHexes(String r, s) {
    R = BigInt.parse(r, radix: 16);
    S = BigInt.parse(s, radix: 16);
  }

  /// verify the sign and the **hash** of message with the public key
  bool verify(WitPublicKey publicKey, String hexHash) {
    return _verify(
      secp256k1.n,
      secp256k1.p,
      secp256k1.a,
      secp256k1.G,
      [publicKey.X, publicKey.Y],
      [R, S],
      BigInt.parse(hexHash, radix: 16),
    );
  }

  List<BigInt> toBigInts() {
    return [R, S];
  }

  List<String> toHexes() {
    return [
      R.toRadixString(16).padLeft(64, '0'),
      S.toRadixString(16).padLeft(64, '0')
    ];
  }

  factory WitSignature.decode(String sig) {
    Uint8List data = hexToBytes(sig);
    int lead = data.first;
    data.removeAt(0);

    assert(lead == 30, 'Invalid leading byte');
    int sequenceLength = data.first;
    data.removeAt(0);
    assert(sequenceLength <= 70, 'Invalid Sequence length: $sequenceLength');
    lead = data.first;
    data.removeAt(0);
    assert(lead == 2, 'Invalid leading byte');
    int rLength = data.first;
    data.removeAt(0);
    assert(rLength <= 33, 'Invalid r length $rLength');
    BigInt r = bytesToBigInt(Uint8List.fromList(data.sublist(0, rLength)));
    data.removeRange(0, rLength);
    lead = data.first;
    data.removeAt(0);
    assert(lead == 2, 'Invalid leading byte');
    int sLength = data.first;
    data.removeAt(0);
    assert(sLength <= 33, 'Invalid r length $sLength');
    BigInt s = bytesToBigInt(Uint8List.fromList(data.sublist(0, sLength)));

    return WitSignature(r, s);
  }

  Uint8List encode() {
    Uint8List _r = bigIntToBytes(R);
    Uint8List _s = bigIntToBytes(S);
    if (_r[0] > 0x7f) {
      // append 0x00 to the beginning

      _r = concatBytes([hexToBytes('00'), _r]);
    }
    if (_s[0] > 0x7f) {
      _s = concatBytes([hexToBytes('00'), _s]);
    }
    Uint8List rLength = bigIntToBytes(BigInt.from(_r.length));
    Uint8List sLength = bigIntToBytes(BigInt.from(_s.length));
    Uint8List sigLength = bigIntToBytes(BigInt.from(_r.length + _s.length + 4));
    print(bytesToHex(sigLength));
    return concatBytes([
      hexToBytes('30'),
      sigLength,
      hexToBytes('02'),
      rLength,
      _r,
      hexToBytes('02'),
      sLength,
      _s,
    ]);
  }

  String toRawHex() {
    return R.toRadixString(16).padLeft(64, '0') +
        S.toRadixString(16).padLeft(64, '0');
  }

  @override
  String toString() {
    return toRawHex();
  }

  @override
  bool operator ==(other) {
    return other is WitSignature && (R == other.R && S == other.S);
  }
}

bool _verify(BigInt n, BigInt p, BigInt a, List<BigInt> pointG,
    List<BigInt> pointQ, List<BigInt> sign, BigInt bigHash) {
  var r = sign[0];
  var s = sign[1];

  if (r < BigInt.one || r >= n) return false;
  if (s < BigInt.one || s >= n) return false;

  // if (!(r > BigInt.one && r < n && s > BigInt.one && s < n)) {
  //   return false;
  // }

  var e = bigHash;
  var w = inverseMulti(s, n);
  var u1 = positiveMod((e * w), n);
  var u2 = positiveMod((r * w), n);
  var u1Point = getPointByBigInt(u1, p, a, pointG);
  var u2Point = getPointByBigInt(u2, p, a, pointQ);

  List<BigInt> pointR;
  if (u1Point[0] == u2Point[0] && u1Point[1] == u2Point[1]) {
    pointR = addSamePoint(u1Point[0], u1Point[1], p, a);
  } else {
    pointR = addDiffPoint(u1Point[0], u1Point[1], u2Point[0], u2Point[1], p);
  }
  if (pointR[0] == BigInt.zero && pointR[1] == BigInt.zero) {
    return false;
  }
  var v = positiveMod(pointR[0], n);
  if (v == r) {
    return true;
  }
  return false;
}
