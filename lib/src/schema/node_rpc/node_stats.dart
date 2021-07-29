// To parse this JSON data, do
//
//     final nodeStatsResponse = nodeStatsResponseFromMap(jsonString);

import 'dart:convert';

import 'node_response.dart';

class NodeStats extends NodeResponse {
  NodeStats({
    required this.blockMinedCount,
    required this.blockProposedCount,
    required this.commitsCount,
    required this.commitsProposedCount,
    required this.drEligibilityCount,
    required this.lastBlockProposed,
    required this.slashedCount,
  });

  final int blockMinedCount;
  final int blockProposedCount;
  final int commitsCount;
  final int commitsProposedCount;
  final int drEligibilityCount;
  final String lastBlockProposed;
  final int slashedCount;

  factory NodeStats.fromJson(String str) => NodeStats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NodeStats.fromMap(Map<String, dynamic> json) => NodeStats(
    blockMinedCount: json["block_mined_count"],
    blockProposedCount: json["block_proposed_count"],
    commitsCount: json["commits_count"],
    commitsProposedCount: json["commits_proposed_count"],
    drEligibilityCount: json["dr_eligibility_count"],
    lastBlockProposed: json["last_block_proposed"],
    slashedCount: json["slashed_count"],
  );

  Map<String, dynamic> toMap() => {
    "block_mined_count": blockMinedCount,
    "block_proposed_count": blockProposedCount,
    "commits_count": commitsCount,
    "commits_proposed_count": commitsProposedCount,
    "dr_eligibility_count": drEligibilityCount,
    "last_block_proposed": lastBlockProposed,
    "slashed_count": slashedCount,
  };
}
