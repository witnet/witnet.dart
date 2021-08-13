import 'package:cbor/cbor.dart' as cbor;

List<dynamic> cborToRad(List<int> data){
  final inst = cbor.Cbor();
  inst.decodeFromList(data);
  return inst.getDecodedData()?[0];
}

List<int> radToCbor(List<dynamic> data){
  final inst = cbor.Cbor();
  final encoder = inst.encoder;
  encoder.writeArray(data);
  final buffer = inst.output.getData();
  return buffer.toList();
}