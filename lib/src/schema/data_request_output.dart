import 'dart:convert';
import 'data_request.dart';
class DrOutput {
  DrOutput({
    required this.collateral,
    required this.commitAndRevealFee,
    required this.dataRequest,
    required this.minConsensusPercentage,
    required this.witnessReward,
    required this.witnesses,
  });

  int collateral;
  int commitAndRevealFee;
  DataRequest dataRequest;
  int minConsensusPercentage;
  int witnessReward;
  int witnesses;

  factory DrOutput.fromRawJson(String str) => DrOutput.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DrOutput.fromJson(Map<String, dynamic> json) => DrOutput(
    collateral: json["collateral"],
    commitAndRevealFee: json["commit_and_reveal_fee"],
    dataRequest: DataRequest.fromJson(json["data_request"]),
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
}