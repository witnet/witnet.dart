
import 'dart:convert';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:witnet/src/utils/transformations/transformations.dart';

class EncoderAES extends Converter<Object, String> {
  final AesCrypt aes;
  final AesMode mode;
  EncoderAES(this.aes, {this.mode});

  @override
  String convert(dynamic input) {
    return bytesToHex(aes.aesEncrypt(input));
  }

}