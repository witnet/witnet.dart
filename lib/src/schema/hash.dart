import 'dart:typed_data' show Uint8List;

import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED;
import 'package:witnet/utils.dart' show bytesToHex, hexToBytes;

class Hash {
  Hash({
    required this.SHA256,
  });

  Uint8List SHA256;

  factory Hash.fromString(String string) {
    return Hash(SHA256: hexToBytes(string));
  }

  String toString() {
    return 'Hash(SHA256: ${bytesToHex(SHA256)})';
  }

  String get hex => bytesToHex(SHA256);

  Uint8List get bytes => SHA256;

  Uint8List get pbBytes => pbField(1, LENGTH_DELIMITED, SHA256);
}
/*








 */