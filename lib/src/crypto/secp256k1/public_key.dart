import "dart:typed_data" show Uint8List;

import 'package:witnet/src/crypto/secp256k1/signature.dart';
import 'package:witnet/utils.dart' show DotEnvUtil;

import 'secp256k1.dart'
    show
        Point,
        Secp256k1,
        hexToPoint,
        hexToPointFromCompress,
        pointToHexInCompress;
import 'private_key.dart' show WitPrivateKey;
import '../crypto.dart' show sha256;

import 'package:witnet/utils.dart'
    show bech32, bytesToBigInt, bytesToHex, hexToBytes;

class WitPublicKey {
  final Point point;

  WitPublicKey(this.point);

  factory WitPublicKey.decode(Uint8List bytes) {
    List<int> key = bytes.toList();
    if (key.first == 0x04) {
      // uncompressed key
      assert(key.length == 65, 'An uncompressed key must be 65 bytes long');
      final point = hexToPoint(bytesToHex(bytes));
      return WitPublicKey(point);
    } else {
      // compressed key
      assert(key.length == 33, 'A compressed public key must be 33 bytes');
      final point = hexToPointFromCompress(bytesToHex(bytes));
      return WitPublicKey(point);
    }
  }

  factory WitPublicKey.fromPrivate(WitPrivateKey privateKey) {
    return privateKey.publicKey;
  }

  factory WitPublicKey.recover(WitSignature signature, Uint8List message,
      [int? recoveryId = null]) {
    if (recoveryId != null) {
      if (recoveryId >= 0 && recoveryId <= 3) {
        return WitPublicKey(_recoverPublicKey(recoveryId, signature, message));
      } else {
        throw ArgumentError("invalid Recovery ID: 0-3... $recoveryId");
      }
    } else {
      for (int recId = 0; recId <= 3; recId++) {
        Point recoveredKey = _recoverPublicKey(recId, signature, message);
        WitPublicKey publicKey = WitPublicKey(recoveredKey);
        if (signature.verify(publicKey, bytesToHex(message))) {
          return publicKey;
        }
      }
      throw ArgumentError('Could not calculate recovery ID');
    }
  }

  Uint8List encode({bool compressed = true}) {
    return hexToBytes(pointToHexInCompress(point));
  }

  String get hex {
    return pointToHexInCompress(point);
  }

  Uint8List get publicKeyHash {
    return sha256(data: encode()).sublist(0, 20);
  }

  String get address => bech32.encodeAddress(
      DotEnvUtil().testnet ? 'twit' : 'wit', publicKeyHash);
}

Point _recoverPublicKey(
    int recoveryId, WitSignature signature, Uint8List message) {
  BigInt z = bytesToBigInt(message);
  if (signature.R >= Secp256k1.n || signature.S >= Secp256k1.n) {
    throw ArgumentError("Invalid Signature");
  }

  // calculate x coordinate of point R
  BigInt x = signature.R + BigInt.from(recoveryId / 2) * Secp256k1.n;
  if (x >= Secp256k1.p) {
    throw ArgumentError("invalid x-coordinate");
  }

  // decompress point R from the x coordinate
  Point r = _decompressKey(x, (recoveryId % 2) == 1);

  BigInt e = z % Secp256k1.n;
  BigInt eInv = (Secp256k1.n - e) % Secp256k1.n;
  BigInt rInv = signature.R.modInverse(Secp256k1.n);
  BigInt srInv = (signature.S * rInv) % Secp256k1.n;
  BigInt eInvrInv = (eInv * rInv) % Secp256k1.n;

  // Q = r^-1 (sR - eG)
  Point q = (r * srInv) + (Secp256k1.G * eInvrInv);

  return q;
}

_decompressKey(BigInt xBn, bool yBit) {
  var x = xBn;

  // y^2 = x^3 + ax + b (mod p)
  var alpha =
      (x.modPow(BigInt.from(3), Secp256k1.p) + BigInt.from(7) % Secp256k1.p);

  // y = sqrt(y^2) (mod p)
  var beta = (alpha.modPow((Secp256k1.p + BigInt.one) >> 2, Secp256k1.p));

  // select the correct y based on the yBit
  var y = beta;
  if ((beta.isEven ? 0 : 1) != (yBit ? 1 : 0)) {
    y = Secp256k1.p - y;
  }

  return Point(x, y);
}
