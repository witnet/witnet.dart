import "dart:typed_data" show Uint8List;

import 'secp256k1.dart' show Point, hexToPoint, hexToPointFromCompress, pointToHexInCompress;
import 'private_key.dart' show WitPrivateKey;
import '../crypto.dart' show sha256;

import 'package:witnet/utils.dart' show bech32, bytesToHex, hexToBytes;

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

  Uint8List encode({bool compressed: true}) {
    return hexToBytes(pointToHexInCompress(point));
  }

  String get hex {
    return pointToHexInCompress(point);
  }

  Uint8List get publicKeyHash {
    return sha256(data: encode()).sublist(0, 20);
  }

  String get address {
    return bech32.encodeAddress('wit', publicKeyHash);
  }
}
