import 'dart:typed_data';

import 'package:witnet/utils.dart';

import '../number_theory.dart' show inverseMulti, positiveMod;

class Secp256k1 {
  static final BigInt p = BigInt.parse(
      'fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f',
      radix: 16);
  static final BigInt a = BigInt.parse('0', radix: 16);
  static final BigInt b = BigInt.parse('7', radix: 16);
  static final BigInt n = BigInt.parse(
      'fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141',
      radix: 16);
  static final BigInt h = BigInt.parse('1', radix: 16);
  static final Point G = Point(
    BigInt.parse(
        '79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798',
        radix: 16),
    BigInt.parse(
        '483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8',
        radix: 16),
  );
}

class CurveElement {
  final BigInt value;
  CurveElement(this.value);
}

class Point {
  Point(
    this.x,
    this.y,
  );
  final BigInt x;
  final BigInt y;

  Uint8List encode({bool compressed: true}) {
    return hexToBytes(pointToHexInCompress(this));
  }

  factory Point.fromHex(String data) {
    return hexToPointFromCompress(data);
  }

  Point addSame() {
    return addSamePoint(this, Secp256k1.n, Secp256k1.a);
  }

  Point operator +(Point other) {
    return addDiffPoint(this, other, Secp256k1.p);
  }
}

Point bigIntToPoint(BigInt n) {
  return hexToPoint(n.toRadixString(16));
}

Point hexToPoint(String hex) {
  final len = 130;
  if (hex.length != len) {
    throw ('point length must be $len!');
  }

  if (hex.substring(0, 2) != '04') {
    throw ('point prefix incorrect!');
  }

  return Point(
    BigInt.parse(hex.substring(2, 66), radix: 16),
    BigInt.parse(hex.substring(66, 130), radix: 16),
  );
}

Point addSamePoint(Point point, BigInt modNum, BigInt a) {
  var ru = positiveMod(
      (BigInt.from(3) * point.x.pow(2) + a) *
          inverseMulti(BigInt.two * point.y, modNum),
      modNum);
  var x3 = positiveMod(ru.pow(2) - (BigInt.two * point.x), modNum);
  var y3 = positiveMod(ru * (point.x - x3) - point.y, modNum);
  return Point(x3, y3);
}

Point addDiffPoint(Point point1, Point point2, BigInt modNum) {
  var ru = positiveMod(
      (point2.y - point1.y) * inverseMulti(point2.x - point1.x, modNum),
      modNum);
  var x3 = positiveMod(ru.pow(2) - point1.x - point2.x, modNum);
  var y3 = positiveMod(ru * (point1.x - x3) - point1.y, modNum);
  return Point(x3, y3);
}

Point getPointByBigInt(BigInt n, BigInt p, BigInt a, Point pointG) {
  var bin = n.toRadixString(2);
  var nextPoint = pointG;
  Point? nowPoint;
  for (var i = bin.length - 1; i >= 0; i--) {
    if (bin[i] == '1') {
      if (nowPoint == null) {
        nowPoint = nextPoint;
      } else {
        nowPoint = addDiffPoint(nowPoint, nextPoint, p);
      }
    }

    nextPoint = addSamePoint(nextPoint, p, a);
  }

  return nowPoint!;
}

Point hexToPointFromCompress(String hex) {
  final len = 66;
  if (hex.length != len) {
    throw ('point length must be $len!');
  }

  var firstByte = int.parse(hex.substring(0, 2), radix: 16);

  if ((firstByte & ~1) != 2) {
    throw ('point prefix incorrect!');
  }

  var x = BigInt.parse(hex.substring(2, 66), radix: 16);

  // The curve equation for secp256k1 is: y^2 = x^3 + 7.
  var ySqared =
      ((x.modPow(BigInt.from(3), Secp256k1.p)) + BigInt.from(7)) % Secp256k1.p;

  // power = (p+1) // 4
  var p1 = Secp256k1.p + BigInt.from(1); // p+1
  var power = (p1 - p1 % BigInt.from(4)) ~/ BigInt.from(4);
  var y = ySqared.modPow(power, Secp256k1.p);

  var sq = y.pow(2) % Secp256k1.p;
  if (sq != ySqared) {
    throw ('failed to retrieve y of public key from hex');
  }

  var firstBit = (y & BigInt.one).toInt();
  if (firstBit != (firstByte & 1)) {
    y = Secp256k1.p - y;
  }

  return Point(
    x,
    y,
  );
}

String pointToHexInCompress(Point point) {
  // var byteLen = 32; //(256 + 7) >> 3 //  => so len of str is (32+1) * 2 = 66;
  var firstBit = 2 + (point.y & BigInt.one).toInt();
  var prefix = firstBit.toRadixString(16).padLeft(2, '0');

  return prefix + point.x.toRadixString(16).padLeft(64, '0');
}
