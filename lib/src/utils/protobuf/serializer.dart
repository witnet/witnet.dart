

import 'dart:ffi';
import 'dart:typed_data';

import '../transformations/transformations.dart';

Uint8List varInt(BigInt value){
  List<int> _value = [];
  while (value > BigInt.from(0x7F)) {
    _value.add([(value & BigInt.from(0x7F) | BigInt.from(0x80)).toInt()][0]);
    value >>= 7;
  }
  _value.add(value.toInt());
  return Uint8List.fromList(_value);
}
Uint8List fieldHeader = varInt(BigInt.from(10)); // 0x0a
Uint8List indexHeader  = varInt(BigInt.from(16)); // 0x10
Uint8List outputHeader = varInt(BigInt.from(18)); // 0x12
Uint8List scriptHeader = varInt(BigInt.from(26)); // 0x1a


Uint8List varIntSerializer(dynamic value){
  if (value is String){
    return varInt(bytesToBigInt(stringToBytes(value)));
  } else if (value is Uint8List){
    return varInt(bytesToBigInt(value));
  } else if (value is int){
    return varInt(BigInt.from(value));
  } else if (value is BigInt){
    return varInt(value);
  } else {
    throw Exception('Unable to Serialize value type ${value.runtimeType}');
  }
}

Uint8List bytesSerializer(Uint8List bytes) {
  return concatBytes([varInt(BigInt.from(bytes.length)), bytes]);
}