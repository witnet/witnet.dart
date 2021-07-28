import 'dart:convert';
import 'dart:typed_data';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:witnet/utils.dart' show hexToBytes;

class DecoderAES extends Converter<String, Object>{
  final AesCrypt aes;
  DecoderAES(this.aes);

  @override
  Object convert(String input) {
    hexToBytes(input);
    return(aes.aesDecrypt(hexToBytes(input)));
  }

}