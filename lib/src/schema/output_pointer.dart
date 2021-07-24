import 'dart:convert';
import 'dart:typed_data';
import '../utils/protobuf/serializer.dart';
import '../utils/transformations/transformations.dart';

import 'hash.dart';
class OutputPointer {
  OutputPointer({
    this.transactionId,
    this.outputIndex,
  });
  Hash transactionId;
  int outputIndex;


  factory OutputPointer.fromString(String str) => OutputPointer(
      transactionId: Hash.fromString(str.split(':')[0]),
      outputIndex: int.parse(str.split(':')[1]),
  );

  String toString(){
    return 'OuputPointer(transactionID: $transactionId, index: $outputIndex)';
  }
  String get rawJson => json.encode(jsonMap);

  Map<String, dynamic> get jsonMap => {
    'output_pointer': '${transactionId.hex}:$outputIndex'
  };


  Uint8List get pbBytes {
    Uint8List outputIndexBytes = Uint8List.fromList([]);
    if (outputIndex > 0){
      outputIndexBytes = concatBytes([indexHeader, varInt(BigInt.from(outputIndex))]);
    }
    Uint8List content = Uint8List.fromList([]);
    content = concatBytes([fieldHeader, bytesSerializer(transactionId.SHA256)]);
    content = concatBytes([fieldHeader, bytesSerializer(content), outputIndexBytes ]);
    content = concatBytes([fieldHeader, bytesSerializer(content)]);
    return content;
  }
}
