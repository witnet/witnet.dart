import 'dart:convert';
import 'dart:typed_data';
import 'input.dart';
import 'value_transfer_output.dart';

class DRTransactionBody {
  DRTransactionBody({
    this.inputs,
    this.outputs,
  });
  List<Input> inputs;
  List<ValueTransferOutput> outputs;


  factory DRTransactionBody.fromRawJson(String str) => DRTransactionBody.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap);

  factory DRTransactionBody.fromJson(Map<String, dynamic> json) => DRTransactionBody(
    inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
    outputs: List<ValueTransferOutput>.from(json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
  );

  Map<String, dynamic> get jsonMap => {
    "inputs": List<dynamic>.from(inputs.map((x) => x.jsonMap)),
    "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap)),
  };
  Uint8List get pbBytes {
    // TODO
    return Uint8List.fromList([]);
  }
}