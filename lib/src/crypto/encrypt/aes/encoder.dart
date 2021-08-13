import 'dart:convert';

import 'aes_crypt.dart';
import 'package:witnet/src/utils/transformations/transformations.dart';

class EncoderAES extends Converter<Object, String> {
  late AesCrypt aes;
  late AesMode mode;

  EncoderAES(this.aes, {required this.mode});

  @override
  String convert(dynamic input) {
    return bytesToHex(aes.aesEncrypt(input));
  }
}
