import 'dart:convert';
import 'dart:typed_data';

import '../crypto/crypto.dart';
import '../utils/transformations/transformations.dart' show concatBytes;

import 'input.dart';
import 'value_transfer_output.dart';


class VTTransactionBody {
  VTTransactionBody({
    required this.inputs,
    required this.outputs,
  });
  List<Input> inputs;
  List<ValueTransferOutput> outputs;

  factory VTTransactionBody.fromRawJson(String str) => VTTransactionBody.fromJson(json.decode(str));

  factory VTTransactionBody.fromJson(Map<String, dynamic> json) => VTTransactionBody(
    inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
    outputs: List<ValueTransferOutput>.from(json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
  );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    "inputs": List<dynamic>.from(inputs.map((x) => x.jsonMap)),
    "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap)),
  };

  Uint8List get pbBytes {
    var inputBytes = concatBytes(List<Uint8List>.from(inputs.map((e) => e.pbBytes)));
    var outputBytes = concatBytes(List<Uint8List>.from(outputs.map((e) => e.pbBytes)));
    return concatBytes([inputBytes, outputBytes]);
  }

  Uint8List get hash => sha256(data: pbBytes);


}