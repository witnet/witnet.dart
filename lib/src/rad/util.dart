import 'dart:typed_data';
import 'package:typed_data/typed_buffers.dart';
import 'package:cbor/cbor.dart' as cbor;

dynamic cborToRad(List<int> data){
  final inst = cbor.Cbor();
  inst.decodeFromList(data);
  return inst.getDecodedData()?[0];
}
List<int> valueToCbor(dynamic value){
  final inst = cbor.Cbor();
  final encoder = inst.encoder;
  switch (value.runtimeType){
    case double: encoder.writeDouble(value); break;
    case int: encoder.writeInt(value); break;
    case List: encoder.writeArray(value); break;
    case String: encoder.writeString(value); break;
    case Uint8Buffer: encoder.writeBytes(value); break;
  }
  final buffer = inst.output.getData();
  return buffer.toList();
}

List<int> radToCbor(List<dynamic> data){
  final inst = cbor.Cbor();
  final encoder = inst.encoder;
  encoder.writeArray(data);
  final buffer = inst.output.getData();
  return buffer.toList();
}