import "dart:typed_data" show Uint8List;
import "package:pointycastle/digests/sha512.dart" show SHA512Digest;
import "package:pointycastle/api.dart" show KeyParameter;
import 'package:pointycastle/ecc/curves/secp256k1.dart' show ECCurve_secp256k1;
import "package:pointycastle/macs/hmac.dart" show HMac;
import "package:pointycastle/digests/ripemd160.dart" show RIPEMD160Digest;
import "package:pointycastle/digests/sha256.dart" show SHA256Digest;

//final sha256digest = SHA256Digest();
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
