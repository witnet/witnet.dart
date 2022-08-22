part of 'schema.dart';

class MintTransaction {
  MintTransaction({
    required this.epoch,
    required this.outputs,
  });

  int epoch;
  List<ValueTransferOutput> outputs;

  factory MintTransaction.fromRawJson(String str) =>
      MintTransaction.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap());

  factory MintTransaction.fromJson(Map<String, dynamic> json) =>
    MintTransaction(
      epoch: json['epoch'],
      outputs: List<ValueTransferOutput>.from(
          json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
    );



  Map<String, dynamic> jsonMap({bool asHex=false}) => {
    "epoch": epoch,
    "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap())),
  };

  Uint8List get pbBytes {
    final outputBytes = concatBytes(List<Uint8List>.from(outputs.map((e) => pbField(2, LENGTH_DELIMITED, e.pbBytes))));

    return concatBytes([
      pbField(1, VARINT, epoch),
      outputBytes,
    ]);
  }

}
