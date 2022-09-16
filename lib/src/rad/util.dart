import 'package:cbor/cbor.dart';
import 'package:cbor/cbor.dart' as cbor;

dynamic cborToRad(List<int> data){
  final inst = cbor.cbor;
  return inst.decode(data);
}

List<int> radToCbor(dynamic data){
  if(data.runtimeType == double) {
    return cbor.cbor.encode(CborFloat(data)..floatPrecision());
  }
  return cbor.cbor.encode(cbor.CborValue(data));
}
