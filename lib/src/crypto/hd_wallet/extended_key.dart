
import 'dart:ffi';
import 'dart:typed_data';
import '../crypto.dart';
import 'extended_private_key.dart';
import '../secp256k1/private_key.dart';
import '../../utils/transformations/transformations.dart';
import '../bip39/bip39.dart' show mnemonicToSeed;
import '../message.dart';

class ExtendedKey {

  ExtendedKey({
    String rootPath,
    Uint8List code,
    int depth,
    BigInt i,
    Uint8List parent,
    String path,
}) {
    this.rootPath = rootPath;
    this.parent = (parent != null) ? parent : Uint8List.fromList([0,0,0,0]);
    this.code = code;
    this.depth = depth;
    this.i = i;
    this.path = path;
    assert (255 >= depth && depth >= 0, 'Depth can only be 0-255');
    if (i != null){
     assert (BigInt.zero <= i && i < BigInt.from(1 << 32), 'Invalid i : $i');
   }
  }
  String rootPath;
  Uint8List key;
  Uint8List code;
  int depth = 0;
  BigInt i;
  Uint8List parent = Uint8List.fromList([0,0,0,0]);
  String path;

  factory ExtendedKey.deserialize(Uint8List bytes) {
    var net;
    var isPublic;
    var isPrivate;
    var depth;
    var fingerprint;

  }



  bool get isMaster {
    if (
    depth == 0 &&
    i == null &&
    parent == [0,0,0,0] &&
    path == rootPath) {
      return true;
    }
    return false;
  }

  // ignore: missing_return
  factory ExtendedKey.child({dynamic index}){
    UnimplementedError();
  }



}

Uint8List read(int start, int end, Uint8List bytes ) {
  return bytes.sublist(start, end);
}


