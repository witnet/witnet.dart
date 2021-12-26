

import 'dart:typed_data';

class ExtendedKey {

  final String rootPath;
  final Uint8List key;
  final Uint8List code;
  final int depth;
  late BigInt? index;
  final Uint8List? parent;
  late String? path;

  ExtendedKey(
      {
    required this.rootPath,
    required this.code,
    required this.key,
    required this.depth,
    required this.index,
    required this.parent,
    required this.path,
  }){
    assert(0 <= depth && depth <= 255, 'Depth [$depth] can only be 0-255');
    if (index != null){
      assert(BigInt.zero <= index! && index! < BigInt.one << 32, 'Invalid Index');
    } else index = BigInt.zero;
  }
  Uint8List id(){
    throw Exception('Not Implemented');
  }

  /// fingerPrint 4 bytes (the first 4 bytes of the parent key hash)
  Uint8List get fingerPrint => this.id().sublist(0,4);

  ExtendedKey child({required BigInt index}){
    throw Exception('Not Implemented');
  }

  dynamic operator /(dynamic index) {
    BigInt i;

    if (index is double) {
      // hardened child derivation
      i = BigInt.from(index) + BigInt.two.pow(31);
    } else {
      // if ( index is int )
      // non-hardened child derivation
      i = BigInt.from(index);
    }
    return this.child(index: i);
  }

  dynamic operator ~/(int index) {
    return this.child(index: BigInt.from(index) + BigInt.two.pow(31));
  }

  bool get isMaster {
    if (depth == 0 && index == null && path == rootPath) {
      return true;
    }
    return false;
  }
}
