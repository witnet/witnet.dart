import 'dart:typed_data';

import 'string.dart';
import 'types.dart';
import '../op_codes.dart';

import 'package:witnet/crypto.dart' show sha256;
import 'package:witnet/utils.dart' show bytesToHex;

class RadBytes{
  Uint8List _value;
  RadBytes(this._value);
  final String type = TYPES.BYTES;
  Uint8List get value => _value;
  RadString get asString => RadString(_value.toString());
  RadString get hash => RadString(bytesToHex(sha256(data: _value)));
  dynamic op(int op, [dynamic key]){
    Map<int, dynamic> ops = {};
    if(key != null) {
      ops.addAll({
        OP.BYTES_AS_STRING: asString,
        OP.BYTES_HASH: hash,
      });
      return ops[op](key);
    } else return ops[op];
  }
}
