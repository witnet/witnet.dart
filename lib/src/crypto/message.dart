import 'dart:convert';
import 'dart:typed_data';


import 'package:witnet/crypto.dart';
import 'package:witnet/schema.dart';
import 'package:witnet/utils.dart';

class Message {
  Message({required this.message});

  Uint8List message;
  Hash? _hash;

  Uint8List fromBigInt(BigInt i) {
    message = bigIntToBytes(i);
    return message;
  }

  Uint8List fromString(String string) {
    message = stringToBytes(string);
    return message;
  }

  Uint8List fromBinary(String binary) {
    message = bigIntToBytes(binaryToBigInt(binary));
    return message;
  }

  factory Message.fromBytes(Uint8List bytes) {
    return Message(message: bytes);
  }

  BigInt get bigInt {
    return bytesToBigInt(message);
  }

  String get string {
    return bytesToString(message);
  }

  String get hex {
    return bytesToHex(message);
  }

  Uint8List get bytes {
    return message;
  }

  String get base64 {
    return Base64Encoder.urlSafe().convert(message.toList());
  }

  Uint8List get hash {
    if (_hash != null) {
      _hash = Hash(SHA256: sha256(data: message));
    }
    return _hash!.SHA256;
  }
}
