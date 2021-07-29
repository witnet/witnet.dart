import 'dart:convert';
import 'value_transfer_output.dart';

class MintTransaction {
  MintTransaction({
    required this.epoch,
    required this.outputs,
  });

  int epoch;
  List<ValueTransferOutput> outputs;

  factory MintTransaction.fromRawJson(String str) => MintTransaction.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap);

  factory MintTransaction.fromJson(Map<String, dynamic> json) => MintTransaction(
    epoch: json['epoch'],
    outputs: List<ValueTransferOutput>.from(json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
  );

  Map<String, dynamic> get jsonMap => {
    "epoch": epoch,
    "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap)),
  };

}