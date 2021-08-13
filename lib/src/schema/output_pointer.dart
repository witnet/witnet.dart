import 'dart:convert';
import 'dart:typed_data';

import 'hash.dart';

import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED, VARINT;
import 'package:witnet/utils.dart' show concatBytes;

class OutputPointer {
  OutputPointer({
    required this.transactionId,
    required this.outputIndex,
  });

  Hash transactionId;
  int outputIndex;

  factory OutputPointer.fromString(String str) => OutputPointer(
        transactionId: Hash.fromString(str.split(':')[0]),
        outputIndex: int.parse(str.split(':')[1]),
      );

  String toString() {
    return 'OuputPointer(transactionID: $transactionId, index: $outputIndex)';
  }

  String get rawJson => json.encode(jsonMap);

  Map<String, dynamic> get jsonMap =>
      {'output_pointer': '${transactionId.hex}:$outputIndex'};

  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, LENGTH_DELIMITED, transactionId.pbBytes),
      (outputIndex > 0)
          ? pbField(2, VARINT, outputIndex)
          : Uint8List.fromList([])
    ]);
  }
}
