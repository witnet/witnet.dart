import 'dart:convert';
import 'dart:typed_data';

import 'output_pointer.dart';

import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED;

class Input {
  Input({
    required this.outputPointer,
  });

  OutputPointer outputPointer;

  factory Input.fromRawJson(String str) => Input.fromJson(json.decode(str));

  factory Input.fromJson(Map<String, dynamic> json) => Input(
        outputPointer: OutputPointer.fromString(json["output_pointer"]),
      );

  String get rawJson => json.encode(jsonMap);

  Map<String, dynamic> get jsonMap => outputPointer.jsonMap;

  String toString() {
    return 'Input(outputPointer: $outputPointer)';
  }
  Uint8List get pbBytes {
    return pbField(1, LENGTH_DELIMITED, outputPointer.pbBytes);
  }
}
