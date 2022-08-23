part of 'schema.dart';

class DRTransactionBody {
  DRTransactionBody({
    required this.inputs,
    required this.outputs,
    required this.dataRequestOutput,
  });

  List<Input> inputs;
  List<ValueTransferOutput> outputs;
  DataRequestOutput dataRequestOutput;

  factory DRTransactionBody.fromRawJson(String str) =>
      DRTransactionBody.fromJson(json.decode(str));

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory DRTransactionBody.fromJson(Map<String, dynamic> json) =>
      DRTransactionBody(
        inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
        outputs: List<ValueTransferOutput>.from(
            json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
        dataRequestOutput: DataRequestOutput.fromJson(json['dr_output']),
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "dr_output": dataRequestOutput.jsonMap(asHex: asHex),
        "inputs": List<dynamic>.from(inputs.map((x) => x.jsonMap(asHex: asHex))),
        "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap())),
      };

  Uint8List get pbBytes {
    final inputBytes =  concatBytes(List<Uint8List>.from(inputs.map((e) => pbField(1, LENGTH_DELIMITED,e.pbBytes))));
    final outputBytes = concatBytes(List<Uint8List>.from(outputs.map((e) => pbField(2, LENGTH_DELIMITED,e.pbBytes))));
    final drReqBytes = pbField(3, LENGTH_DELIMITED, dataRequestOutput.pbBytes);
    return  concatBytes([inputBytes, outputBytes, drReqBytes]);
  }

  /// Specified data to be divided in a new level in the proof of inclusion
  /// In this case data = dataRequestOutput.hash
  Uint8List get dataPoiHash => dataRequestOutput.hash;

  /// Rest of the transaction to be divided in a new level in the proof of inclusion
  /// In this case we choose the complete transaction
  Uint8List get restPoiHash => sha256(data: pbBytes);

  Uint8List get hash => sha256(data: concatBytes([dataPoiHash, restPoiHash]));

  int get weight {
    // DR_weight = DR_size*alpha + W*COMMIT + W*REVEAL*beta + TALLY*beta + W*OUTPUT_SIZE
    final int inputsWeight = inputs.length * INPUT_SIZE;
    final int outputsWeight = outputs.length * OUTPUT_SIZE;
    final drWeight = inputsWeight + outputsWeight + dataRequestOutput.weight * ALPHA;
    final drExtraWeight = dataRequestOutput.extraWeight;
    return drWeight + drExtraWeight;
  }

}