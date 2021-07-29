import 'dart:convert';
import 'dart:typed_data';

import 'package:witnet/src/crypto/aes/aes_crypt.dart';
import 'package:witnet/utils.dart' show hexToBytes;

class DecoderAES extends Converter<String, Uint8List>{
  final AesCrypt aes;
  DecoderAES(this.aes);

  @override
  Uint8List convert(String input) {
    hexToBytes(input);
    return(aes.aesDecrypt(hexToBytes(input)));
  }

}