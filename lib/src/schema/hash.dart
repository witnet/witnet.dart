import 'dart:typed_data';
import '../utils/transformations/transformations.dart'
  show bigIntToBytes, bytesToHex, hexToBigInt, hexToBytes, bytesToBigInt, concatBytes;
import '../utils/protobuf/serializer.dart' show varInt, fieldHeader;

class Hash {
  Hash({
    this.SHA256,
  });
  Uint8List SHA256;

  factory Hash.fromString(String string) {
    return Hash(SHA256: hexToBytes(string));
  }

  String toString(){
    return 'Hash(SHA256: ${bytesToHex(SHA256)})';
  }
  String get hex => bytesToHex(SHA256);
  Uint8List get bytes => SHA256;
  Uint8List get pbBytes => concatBytes([fieldHeader, varInt(bytesToBigInt(SHA256))]);

}