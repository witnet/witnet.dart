import "dart:typed_data";
import '../crypto.dart';
import 'secp256k1.dart';
import '../../utils/bech32/codec.dart';
import '../../utils/transformations/transformations.dart';
import 'package:pointycastle/ecc/ecc_fp.dart' as ecc_fp;
import 'private_key.dart';

class WitPublicKey {
  late ecc_fp.ECPoint point;
  late BigInt X;
  late BigInt Y;

  WitPublicKey({required this.X, required this.Y});

  factory WitPublicKey.decode(Uint8List bytes) {
    List<int> key = bytes.toList();
    if (key.first == 0x04) {
      // uncompressed key
      assert(key.length == 65, 'An uncompressed key must be 65 bytes long');
      final point = hexToPoint(bytesToHex(bytes));

      return WitPublicKey(X: point[0], Y: point[1]);
    } else {
      // compressed key
      assert(key.length == 33, 'A compressed public key must be 33 bytes');
      final point = hexToPointFromCompress(bytesToHex(bytes));
      return WitPublicKey(X: point[0], Y: point[1]);
    }
  }

  factory WitPublicKey.fromPrivate(WitPrivateKey privateKey) {
    return privateKey.publicKey;
  }

  Uint8List encode({bool compressed: true}) {
    return hexToBytes(pointToHexInCompress([X, Y]));
  }

  String get hex {
    return bytesToHex(point.getEncoded());
  }

  Uint8List get publicKeyHash {
    return sha256(data: encode()).sublist(0, 20);
  }

  String get address {
    return bech32.encodeAddress('wit', publicKeyHash);
  }
}
