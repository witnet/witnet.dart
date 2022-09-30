part of 'schema.dart';

class Input {
  Input({
    required this.outputPointer,
  });

  OutputPointer outputPointer;

  factory Input.fromRawJson(String str) => Input.fromJson(json.decode(str));

  factory Input.fromJson(Map<String, dynamic> json) => Input(
        outputPointer: OutputPointer.fromString(json["output_pointer"]),
      );

  String get rawJson => json.encode(jsonMap());

  Map<String, dynamic> jsonMap({bool asHex=false}) => outputPointer.jsonMap();

  String toString() {
    return 'Input(outputPointer: $outputPointer)';
  }
  Uint8List get pbBytes {
    return pbField(1, LENGTH_DELIMITED, outputPointer.pbBytes);
  }
}
