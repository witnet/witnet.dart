
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

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory Utxo.fromJson(Map<String, dynamic> json) => Utxo(
    outputPointer: OutputPointer.fromString(json["output_pointer"]),
    timelock: json["timelock"],
    utxoMature: json["utxo_mature"],
    value: json["value"],
  );

  Input toInput() {
    return Input(outputPointer: outputPointer);
  }

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
    "output_pointer": outputPointer.jsonMap(asHex: asHex)['output_pointer'],
    "timelock": timelock,
    "utxo_mature": utxoMature,
    "value": value,
  };
}