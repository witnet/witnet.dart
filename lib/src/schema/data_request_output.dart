import 'dart:convert';
import 'dart:typed_data';

import 'package:witnet/constants.dart';

import 'rad_request.dart';

import 'package:witnet/crypto.dart' show sha256;
import 'package:witnet/protobuf.dart'show pbField, LENGTH_DELIMITED, VARINT;
import 'package:witnet/utils.dart' show concatBytes;

class DataRequestOutput {
  DataRequestOutput({
    required this.collateral,
    required this.commitAndRevealFee,
    required this.dataRequest,
    required this.minConsensusPercentage,
    required this.witnessReward,
    required this.witnesses,
  });

  int collateral;
  int commitAndRevealFee;
  RADRequest dataRequest;
  int minConsensusPercentage;
  int witnessReward;
  int witnesses;

  factory DataRequestOutput.fromRawJson(String str) =>
      DataRequestOutput.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataRequestOutput.fromJson(Map<String, dynamic> json) => DataRequestOutput(
        collateral: json["collateral"],
        commitAndRevealFee: json["commit_and_reveal_fee"],
        dataRequest: RADRequest.fromJson(json["data_request"]),
        minConsensusPercentage: json["min_consensus_percentage"],
        witnessReward: json["witness_reward"],
        witnesses: json["witnesses"],
      );

  Map<String, dynamic> toJson() => {
        "collateral": collateral,
        "commit_and_reveal_fee": commitAndRevealFee,
        "data_request": dataRequest.toJson(),
        "min_consensus_percentage": minConsensusPercentage,
        "witness_reward": witnessReward,
        "witnesses": witnesses,
      };

  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, LENGTH_DELIMITED, dataRequest.pbBytes),
      pbField(2, VARINT, witnessReward),
      pbField(3, VARINT, witnesses),
      pbField(4, VARINT, commitAndRevealFee),
      pbField(5, VARINT, minConsensusPercentage),
      pbField(6, VARINT, collateral)
    ]);
  }
  Uint8List get hash {
    return sha256(data: pbBytes);
  }
  /// Returns the DataRequestOutput weight
  int get weight {
    // Witness reward: 8 bytes
    // Witnesses: 2 bytes
    // commit_and_reveal_fee: 8 bytes
    // min_consensus_percentage: 4 bytes
    // collateral: 8 bytes
    return dataRequest.weight + 8 + 2 + 8 + 4 + 8;
  }
  /// Data Request extra weight related by commits, reveals and tally
  int get extraWeight {
    int commitsWeight = witnesses * COMMIT_WEIGHT;
    int revealsWeight = witnesses * REVEAL_WEIGHT * BETA;
    int tallyOutputsWeight = witnesses * OUTPUT_SIZE;
    int tallyWeight = TALLY_WEIGHT * BETA + tallyOutputsWeight;
    return commitsWeight + revealsWeight + tallyWeight;
  }
}
