
import 'dart:convert';

import 'package:witnet/data_structures.dart' show Utxo;
import 'package:witnet/schema.dart' show Transaction;

class NodeException {
  NodeException({
    required this.code,
    required this.message,
  });

  final int code;
  final String message;

  factory NodeException.fromRawJson(String str) =>
      NodeException.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory NodeException.fromJson(Map<String, dynamic> json) => NodeException(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> jsonMap() => {
    "code": code,
    "message": message,
  };

  @override String toString() => 'NodeException(code: $code, message:$message)';
}

class ChainBeacon {
  ChainBeacon({
    required this.checkpoint,
    required this.hashPrevBlock,
  });

  final int checkpoint;
  final String hashPrevBlock;

  factory ChainBeacon.fromRawJson(String str) =>
      ChainBeacon.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory ChainBeacon.fromJson(Map<String, dynamic> json) => ChainBeacon(
    checkpoint: json["checkpoint"],
    hashPrevBlock: json["hashPrevBlock"],
  );

  Map<String, dynamic> jsonMap() => {
    "checkpoint": checkpoint,
    "hashPrevBlock": hashPrevBlock,
  };
}

class TransactionResponse {
  TransactionResponse({
    required this.blockHash,
    required this.confirmed,
    required this.transaction,
    required this.weight,
  });

  String blockHash;
  bool confirmed;
  Transaction transaction;
  int weight;

  factory TransactionResponse.fromRawJson(String str) =>
      TransactionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
        blockHash: json["blockHash"],
        confirmed: json["confirmed"],
        transaction: Transaction.fromJson(json["transaction"]),
        weight: json["weight"],
      );

  Map<String, dynamic> jsonMap() => {
    "blockHash": blockHash,
    "confirmed": confirmed,
    "transaction": transaction.jsonMap(),
    "weight": weight,
  };
}

class UtxoInfo {
  UtxoInfo({
    required this.collateralMin,
    required this.utxos,
  });

  int collateralMin;
  List<Utxo> utxos;

  factory UtxoInfo.fromRawJson(String str) =>
      UtxoInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory UtxoInfo.fromJson(Map<String, dynamic> json) => UtxoInfo(
    collateralMin: json["collateral_min"],
    utxos: List<Utxo>.from(json["utxos"].map((x) => Utxo.fromJson(x))),
  );

  Map<String, dynamic> jsonMap() => {
    "collateral_min": collateralMin,
    "utxos": List<dynamic>.from(utxos.map((x) => x.jsonMap())),
  };
}

class NodeStats {
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

  String jsonMap() => json.encode(toMap());

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

class SyncStatus {
  SyncStatus({
    required this.chainBeacon,
    required this.currentEpoch,
    required this.nodeState,
  });

  final ChainBeacon chainBeacon;
  final int currentEpoch;
  final String nodeState;

  factory SyncStatus.fromRawJson(String str) =>
      SyncStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory SyncStatus.fromJson(Map<String, dynamic> json) => SyncStatus(
    chainBeacon: ChainBeacon.fromJson(json["chain_beacon"]),
    currentEpoch: json["current_epoch"],
    nodeState: json["node_state"],
  );

  Map<String, dynamic> jsonMap() => {
    "chain_beacon": chainBeacon.jsonMap(),
    "current_epoch": currentEpoch,
    "node_state": nodeState,
  };
}
