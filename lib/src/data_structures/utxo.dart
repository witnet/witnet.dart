
import 'dart:convert' show json;

import '../../schema.dart' show Input, OutputPointer;

class Utxo {
  Utxo({
    required this.outputPointer,
    required this.timelock,
    required this.utxoMature,
    required this.value,
  });

  OutputPointer outputPointer;
  int timelock;
  bool utxoMature;
  int value;

  factory Utxo.fromRawJson(String str) => Utxo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Utxo.fromJson(Map<String, dynamic> json) => Utxo(
    outputPointer: OutputPointer.fromString(json["output_pointer"]),
    timelock: json["timelock"],
    utxoMature: json["utxo_mature"],
    value: json["value"],
  );

  Input toInput() {
    return Input(outputPointer: outputPointer);
  }

  Map<String, dynamic> toJson() => {
    "output_pointer": outputPointer.jsonMap['output_pointer'],
    "timelock": timelock,
    "utxo_mature": utxoMature,
    "value": value,
  };
}