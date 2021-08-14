import 'dart:convert' show json;

import 'value_transfer_output.dart' show ValueTransferOutput;

class Mint {
  Mint({
    required this.epoch,
    required this.outputs,
  });

  final int epoch;
  final List<ValueTransferOutput> outputs;

  factory Mint.fromRawJson(String str) => Mint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Mint.fromJson(Map<String, dynamic> json) => Mint(
        epoch: json["epoch"],
        outputs: List<ValueTransferOutput>.from(
            json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "epoch": epoch,
        "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap)),
      };
}
