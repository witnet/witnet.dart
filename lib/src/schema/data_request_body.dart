import 'dart:convert';
import 'dart:typed_data';

import 'data_request_output.dart';
import 'input.dart';
import 'value_transfer_output.dart';

import 'package:witnet/constants.dart' show INPUT_SIZE, OUTPUT_SIZE, ALPHA;
import 'package:witnet/crypto.dart' show sha256;
import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED;
import 'package:witnet/utils.dart' show concatBytes;

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

  String get rawJson => json.encode(jsonMap);

  factory DRTransactionBody.fromJson(Map<String, dynamic> json) =>
      DRTransactionBody(
        inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
        outputs: List<ValueTransferOutput>.from(
            json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
        dataRequestOutput: DataRequestOutput.fromJson(json['dr_output']),
      );

  Map<String, dynamic> get jsonMap => {
        "inputs": List<dynamic>.from(inputs.map((x) => x.jsonMap)),
        "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap)),
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