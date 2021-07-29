import 'dart:typed_data';

import '../secp256k1/public_key.dart';
import '../crypto.dart';
import '../secp256k1/private_key.dart';
import '../../utils/transformations/transformations.dart';

class Xpub {
  Xpub(
      {required WitPublicKey publicKey,
      required Uint8List code,
      required int depth,
      required BigInt index,
      required Uint8List parent,
      String? path}) {
    if (path == null) {
      path = rootPath;
    }
  }

  @override
  String get rootPath => 'M';

  @override
  Uint8List get key => publicKey.encode();

  Uint8List? _id;
  Uint8List? code;
  int depth = 0;
  late BigInt index;
  Uint8List parent = Uint8List.fromList([0, 0, 0, 0]);
  String? path;
  late WitPublicKey publicKey;

  Uint8List get keyData => key;

  Uint8List get id {
    if (_id == null) {
      _id = hash160(data: keyData);
    }
    return _id!;
  }

  Uint8List get fingerPrint => publicKey.publicKeyHash;

  String get address => publicKey.address;

  Xpub child(BigInt index) {
    bool hardened = index >= BigInt.from(1 << 31);
    if (hardened)
      assert(hardened == false,
          'Cannot derive a hardened key from an extended public key');
    Uint8List I = hmacSHA512(
        key: code!, data: Uint8List.fromList(keyData + bigIntToBytes(index)));
    Uint8List IL = I.sublist(0, 32);
    Uint8List IR = I.sublist(32);
    final p = WitPrivateKey(bytes: IL).publicKey.point + publicKey.point;
    return Xpub(
        publicKey:
            WitPublicKey(X: p!.x!.toBigInteger()!, Y: p.y!.toBigInteger()!),
        code: IR,
        depth: depth + 1,
        index: index,
        parent: fingerPrint,
        path: path! + '/$index');
  }
}
