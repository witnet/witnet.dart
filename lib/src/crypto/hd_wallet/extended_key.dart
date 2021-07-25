
import 'dart:typed_data';

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


