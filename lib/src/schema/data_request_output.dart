part of 'schema.dart';



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

  String toRawJson({bool asHex=false}) => json.encode(jsonMap(asHex: asHex));

  factory DataRequestOutput.fromJson(Map<String, dynamic> json) => DataRequestOutput(
        collateral: json["collateral"],
        commitAndRevealFee: json["commit_and_reveal_fee"],
        dataRequest: RADRequest.fromJson(json["data_request"]),
        minConsensusPercentage: json["min_consensus_percentage"],
        witnessReward: json["witness_reward"],
        witnesses: json["witnesses"],
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "collateral": collateral,
        "commit_and_reveal_fee": commitAndRevealFee,
        "data_request": dataRequest.jsonMap(asHex: asHex),
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
    final commitsWeight = witnesses * COMMIT_WEIGHT;
    final revealsWeight = witnesses * REVEAL_WEIGHT * BETA;
    final tallyOutputsWeight = witnesses * OUTPUT_SIZE;
    final tallyWeight = TALLY_WEIGHT * BETA + tallyOutputsWeight;
    return commitsWeight + revealsWeight + tallyWeight;
  }
}
