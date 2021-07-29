import "dart:typed_data";
import "package:pointycastle/digests/sha512.dart";
import "package:pointycastle/api.dart" show KeyParameter;
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import "package:pointycastle/macs/hmac.dart";
import "package:pointycastle/digests/ripemd160.dart";
import "package:pointycastle/digests/sha256.dart";

final sha256digest = SHA256Digest();
final ecParams = ECCurve_secp256k1();

Uint8List sha256({required Uint8List data}) => new SHA256Digest().process(data);

Uint8List sha512({required Uint8List data}) => new SHA512Digest().process(data);

Uint8List ripemod160({required Uint8List data}) =>
    new RIPEMD160Digest().process(data);

Uint8List hash160({required Uint8List data}) =>
    ripemod160(data: sha256(data: data));

Uint8List hash256({required Uint8List data}) =>
    sha256(data: sha256(data: data));

Uint8List hmacSHA512({required Uint8List key, required Uint8List data}) {
  final _tmp = new HMac(new SHA512Digest(), 128)..init(new KeyParameter(key));
  return _tmp.process(data);
}

Uint8List hmachSHA256({required Uint8List key, required Uint8List data}) {
  final mac = new HMac(new SHA256Digest(), 128)..init(new KeyParameter(key));
  return mac.process(data);
}
