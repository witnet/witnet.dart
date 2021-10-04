import 'dart:convert' show json;
import 'dart:typed_data';

import 'package:witnet/data_structures.dart';
import 'package:witnet/schema.dart';
import 'package:witnet/src/crypto/address.dart';

class ExplorerResponse {}

class ExplorerException {
  ExplorerException({required this.code, required this.message});

  final int code;
  final String message;

  @override
  String toString() => message;
}

class ValueTransferTxn {
  ValueTransferTxn({
    required this.blockHash,
    required this.fee,
    required this.inputs,
    required this.outputs,
    required this.priority,
    required this.status,
    required this.txnEpoch,
    required this.txnHash,
    required this.txnTime,
    required this.type,
    required this.weight,
  });

  final String blockHash;
  final int fee;
  final List<List<dynamic>> inputs;
  final List<List<dynamic>> outputs;
  final int priority;
  final String status;
  final int txnEpoch;
  final String txnHash;
  final int txnTime;
  final String type;
  final int weight;

  factory ValueTransferTxn.fromRawJson(String str) =>
      ValueTransferTxn.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValueTransferTxn.fromJson(Map<String, dynamic> json) =>
      ValueTransferTxn(
        blockHash: json["block_hash"],
        fee: json["fee"],
        inputs: List<List<dynamic>>.from(
            json["inputs"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        outputs: List<List<dynamic>>.from(
            json["outputs"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        priority: json["priority"],
        status: json["status"],
        txnEpoch: json["txn_epoch"],
        txnHash: json["txn_hash"],
        txnTime: json["txn_time"],
        type: json["type"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "block_hash": blockHash,
        "fee": fee,
        "inputs": List<dynamic>.from(
            inputs.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "outputs": List<dynamic>.from(
            outputs.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "priority": priority,
        "status": status,
        "txn_epoch": txnEpoch,
        "txn_hash": txnHash,
        "txn_time": txnTime,
        "type": type,
        "weight": weight,
      };
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class Report {
  Report({
    required this.commitTxns,
    required this.dataRequestTxn,
    required this.revealTxns,
    required this.status,
    required this.tallyTxn,
    required this.transactionType,
    required this.type,
  });

  final List<CommitTxn> commitTxns;
  final DataRequestTxn dataRequestTxn;
  final List<RevealTxn> revealTxns;
  final String status;
  final TallyTxn tallyTxn;
  final String transactionType;
  final String type;

  factory Report.fromRawJson(String str) => Report.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        commitTxns: List<CommitTxn>.from(
            json["commit_txns"].map((x) => CommitTxn.fromJson(x))),
        dataRequestTxn: DataRequestTxn.fromJson(json["data_request_txn"]),
        revealTxns: List<RevealTxn>.from(
            json["reveal_txns"].map((x) => RevealTxn.fromJson(x))),
        status: json["status"],
        tallyTxn: TallyTxn.fromJson(json["tally_txn"]),
        transactionType: json["transaction_type"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "commit_txns": List<dynamic>.from(commitTxns.map((x) => x.toJson())),
        "data_request_txn": dataRequestTxn.toJson(),
        "reveal_txns": List<dynamic>.from(revealTxns.map((x) => x.toJson())),
        "status": status,
        "tally_txn": tallyTxn.toJson(),
        "transaction_type": transactionType,
        "type": type,
      };
}

class CommitTxn {
  CommitTxn({
    required this.blockHash,
    required this.epoch,
    required this.status,
    required this.time,
    required this.txnAddress,
    required this.txnHash,
  });

  final String blockHash;
  final int epoch;
  final String status;
  final int time;
  final String txnAddress;
  final String txnHash;

  factory CommitTxn.fromRawJson(String str) =>
      CommitTxn.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommitTxn.fromJson(Map<String, dynamic> json) => CommitTxn(
        blockHash: json['blockHash'],
        epoch: json["epoch"],
        status: json['status'],
        time: json["time"],
        txnAddress: json["txn_address"],
        txnHash: json["txn_hash"],
      );

  Map<String, dynamic> toJson() => {
        "block_hash": blockHash,
        "epoch": epoch,
        "status": status,
        "time": time,
        "txn_address": txnAddress,
        "txn_hash": txnHash,
      };
}

class DataRequestTxn {
  DataRequestTxn({
    required this.addresses,
    required this.aggregate,
    required this.blockHash,
    required this.collateral,
    required this.commitAndRevealFee,
    required this.consensusPercentage,
    required this.fee,
    required this.priority,
    required this.retrieve,
    required this.status,
    required this.tally,
    required this.txnEpoch,
    required this.txnHash,
    required this.txnTime,
    required this.type,
    required this.weight,
    required this.witnessReward,
    required this.witnesses,
  });

  final List<String> addresses;
  final String aggregate;
  final String blockHash;
  final int collateral;
  final int commitAndRevealFee;
  final int consensusPercentage;
  final int fee;
  final int priority;
  final List<Retrieve> retrieve;
  final String status;
  final String tally;
  final int txnEpoch;
  final String txnHash;
  final int txnTime;
  final String type;
  final int weight;
  final int witnessReward;
  final int witnesses;

  factory DataRequestTxn.fromRawJson(String str) =>
      DataRequestTxn.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataRequestTxn.fromJson(Map<String, dynamic> json) => DataRequestTxn(
        addresses: List<String>.from(json["addresses"].map((x) => x)),
        aggregate: json["aggregate"],
        blockHash: json["block_hash"],
        collateral: json["collateral"],
        commitAndRevealFee: json["commit_and_reveal_fee"],
        consensusPercentage: json["consensus_percentage"],
        fee: json["fee"],
        priority: json["priority"],
        retrieve: List<Retrieve>.from(
            json["retrieve"].map((x) => Retrieve.fromJson(x))),
        status: json["status"],
        tally: json["tally"],
        txnEpoch: json["txn_epoch"],
        txnHash: json["txn_hash"],
        txnTime: json["txn_time"],
        type: json["type"],
        weight: json["weight"],
        witnessReward: json["witness_reward"],
        witnesses: json["witnesses"],
      );

  Map<String, dynamic> toJson() => {
        "addresses": List<dynamic>.from(addresses.map((x) => x)),
        "aggregate": aggregate,
        "block_hash": blockHash,
        "collateral": collateral,
        "commit_and_reveal_fee": commitAndRevealFee,
        "consensus_percentage": consensusPercentage,
        "fee": fee,
        "priority": priority,
        "retrieve": List<dynamic>.from(retrieve.map((x) => x.toJson())),
        "status": status,
        "tally": tally,
        "txn_epoch": txnEpoch,
        "txn_hash": txnHash,
        "txn_time": txnTime,
        "type": type,
        "weight": weight,
        "witness_reward": witnessReward,
        "witnesses": witnesses,
      };
}

class Retrieve {
  Retrieve({
    required this.script,
    required this.url,
  });

  final String script;
  final String url;

  factory Retrieve.fromRawJson(String str) =>
      Retrieve.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Retrieve.fromJson(Map<String, dynamic> json) => Retrieve(
        script: json["script"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "script": script,
        "url": url,
      };
}

class RevealTxn {
  RevealTxn({
    required this.blockHash,
    required this.epoch,
    required this.error,
    required this.liar,
    required this.reveal,
    required this.status,
    required this.success,
    required this.time,
    required this.txnAddress,
    required this.txnHash,
  });

  final String blockHash;
  final int epoch;
  final bool error;
  final bool liar;
  final String reveal;
  final String status;
  final bool success;
  final int time;
  final String txnAddress;
  final String txnHash;

  factory RevealTxn.fromRawJson(String str) =>
      RevealTxn.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RevealTxn.fromJson(Map<String, dynamic> json) => RevealTxn(
        blockHash: json["block_hash"],
        epoch: json["epoch"],
        error: json["error"],
        liar: json["liar"],
        reveal: json["reveal"],
        status: json["status"],
        success: json["success"],
        time: json["time"],
        txnAddress: json["txn_address"],
        txnHash: json["txn_hash"],
      );

  Map<String, dynamic> toJson() => {
        "block_hash": blockHash,
        "epoch": epoch,
        "error": error,
        "liar": liar,
        "reveal": reveal,
        "status": status,
        "success": success,
        "time": time,
        "txn_address": txnAddress,
        "txn_hash": txnHash,
      };
}

class TallyTxn {
  TallyTxn({
    required this.blockHash,
    required this.epoch,
    required this.errors,
    required this.liars,
    required this.numErrors,
    required this.numLiars,
    required this.status,
    required this.success,
    required this.tally,
    required this.time,
    required this.txnHash,
  });

  final String blockHash;
  final int epoch;
  final List<String> errors;
  final List<dynamic> liars;
  final int numErrors;
  final int numLiars;
  final String status;
  final bool success;
  final String tally;
  final int time;
  final String txnHash;

  factory TallyTxn.fromRawJson(String str) =>
      TallyTxn.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TallyTxn.fromJson(Map<String, dynamic> json) => TallyTxn(
        blockHash: json["block_hash"],
        epoch: json["epoch"],
        errors: List<String>.from(json["errors"].map((x) => x)),
        liars: List<dynamic>.from(json["liars"].map((x) => x)),
        numErrors: json["num_errors"],
        numLiars: json["num_liars"],
        status: json["status"],
        success: json["success"],
        tally: json["tally"],
        time: json["time"],
        txnHash: json["txn_hash"],
      );

  Map<String, dynamic> toJson() => {
        "block_hash": blockHash,
        "epoch": epoch,
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "liars": List<dynamic>.from(liars.map((x) => x)),
        "num_errors": numErrors,
        "num_liars": numLiars,
        "status": status,
        "success": success,
        "tally": tally,
        "time": time,
        "txn_hash": txnHash,
      };
}

/// Class Mappings to the Explorer API methods
class Home {
  Home({
    required this.lastUpdated,
    required this.latestBlocks,
    required this.latestDataRequests,
    required this.latestValueTransfers,
    required this.networkStats,
    required this.supplyInfo,
  });

  final int lastUpdated;
  final List<List<dynamic>> latestBlocks;
  final List<List<dynamic>> latestDataRequests;
  final List<List<dynamic>> latestValueTransfers;
  final NetworkStats networkStats;
  final SupplyInfo supplyInfo;

  factory Home.fromRawJson(String str) => Home.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        lastUpdated: json["last_updated"],
        latestBlocks: List<List<dynamic>>.from(json["latest_blocks"]
            .map((x) => List<dynamic>.from(x.map((x) => x)))),
        latestDataRequests: List<List<dynamic>>.from(
            json["latest_data_requests"]
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
        latestValueTransfers: List<List<dynamic>>.from(
            json["latest_value_transfers"]
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
        networkStats: NetworkStats.fromJson(json["network_stats"]),
        supplyInfo: SupplyInfo.fromJson(json["supply_info"]),
      );

  Map<String, dynamic> jsonMap() => {
        "last_updated": lastUpdated,
        "latest_blocks": List<dynamic>.from(
            latestBlocks.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "latest_data_requests": List<dynamic>.from(
            latestDataRequests.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "latest_value_transfers": List<dynamic>.from(latestValueTransfers
            .map((x) => List<dynamic>.from(x.map((x) => x)))),
        "network_stats": networkStats.jsonMap(),
        "supply_info": supplyInfo.jsonMap(),
      };
}

class Status {
  Status({
    required this.databaseLastConfirmed,
    required this.databaseLastUnconfirmed,
    required this.databaseMessage,
    required this.nodePool,
    required this.nodePoolMessage,
  });

  final List<dynamic> databaseLastConfirmed;
  final List<dynamic> databaseLastUnconfirmed;
  final String databaseMessage;
  final NodePool nodePool;
  final String nodePoolMessage;

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        databaseLastConfirmed:
            List<dynamic>.from(json["database_last_confirmed"].map((x) => x)),
        databaseLastUnconfirmed:
            List<dynamic>.from(json["database_last_unconfirmed"].map((x) => x)),
        databaseMessage: json["database_message"],
        nodePool: NodePool.fromJson(json["node_pool"]),
        nodePoolMessage: json["node_pool_message"],
      );

  Map<String, dynamic> jsonMap() => {
        "database_last_confirmed":
            List<dynamic>.from(databaseLastConfirmed.map((x) => x)),
        "database_last_unconfirmed":
            List<dynamic>.from(databaseLastUnconfirmed.map((x) => x)),
        "database_message": databaseMessage,
        "node_pool": nodePool.jsonMap(),
        "node_pool_message": nodePoolMessage,
      };
}

class Network {
  Network({
    required this.lastUpdated,
    required this.rollbacks,
    required this.top100DrSolvers,
    required this.top100Miners,
    required this.uniqueDrSolvers,
    required this.uniqueMiners,
  });

  final int lastUpdated;
  final List<RollBack> rollbacks;
  final List<DrSolver> top100DrSolvers;
  final List<Miner> top100Miners;
  final int uniqueDrSolvers;
  final int uniqueMiners;

  factory Network.fromRawJson(String str) => Network.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        lastUpdated: json["last_updated"],
        rollbacks: List<RollBack>.from(
            json["rollbacks"].map((rollback) => RollBack.fromList(rollback))),
        top100DrSolvers: List<DrSolver>.from(json["top_100_dr_solvers"]
            .map((drSolver) => DrSolver.fromList(drSolver))),
        top100Miners: List<Miner>.from(
            json["top_100_miners"].map((miner) => Miner.fromList(miner))),
        uniqueDrSolvers: json["unique_dr_solvers"],
        uniqueMiners: json["unique_miners"],
      );

  Map<String, dynamic> jsonMap() => {
        "last_updated": lastUpdated,
        "rollbacks":
            List<dynamic>.from(rollbacks.map((rollback) => rollback.toList())),
        "top_100_dr_solvers": List<dynamic>.from(
            top100DrSolvers.map((drSolver) => drSolver.toList())),
        "top_100_miners":
            List<dynamic>.from(top100Miners.map((miner) => miner.toList())),
        "unique_dr_solvers": uniqueDrSolvers,
        "unique_miners": uniqueMiners,
      };
}

class DrSolver {
  PublicKeyHash pkh;
  int count;

  DrSolver({
    required this.pkh,
    required this.count,
  });

  factory DrSolver.fromList(List<dynamic> data) {
    return DrSolver(pkh: PublicKeyHash.fromAddress(data[0]), count: data[1]);
  }

  List<dynamic> toList() => [pkh.address, count];
}

class Miner {
  PublicKeyHash pkh;
  int count;

  Miner({
    required this.pkh,
    required this.count,
  });

  factory Miner.fromList(List<dynamic> data) {
    return Miner(pkh: PublicKeyHash.fromAddress(data[0]), count: data[1]);
  }

  List<dynamic> toList() => [pkh.address, count];
}

class RollBack {
  RollBack({
    required this.timestamp,
    required this.toEpoch,
    required this.fromEpoch,
    required this.blocksEffected,
  });

  factory RollBack.fromList(List<dynamic> data) {
    return RollBack(
        timestamp: data[0],
        toEpoch: data[1],
        fromEpoch: data[2],
        blocksEffected: data[3]);
  }

  List<int> toList() => [timestamp, toEpoch, fromEpoch, blocksEffected];

  dynamic get time => DateTime.fromMicrosecondsSinceEpoch(timestamp);

  int timestamp;
  int toEpoch;
  int fromEpoch;
  int blocksEffected;
}

class NetworkStats {
  NetworkStats({
    required this.epochs,
    required this.numActiveNodes,
    required this.numBlocks,
    required this.numDataRequests,
    required this.numPendingRequests,
    required this.numReputedNodes,
    required this.numValueTransfers,
  });

  final int epochs;
  final int numActiveNodes;
  final int numBlocks;
  final int numDataRequests;
  final int numPendingRequests;
  final int numReputedNodes;
  final int numValueTransfers;

  factory NetworkStats.fromRawJson(String str) =>
      NetworkStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory NetworkStats.fromJson(Map<String, dynamic> json) => NetworkStats(
        epochs: json["epochs"],
        numActiveNodes: json["num_active_nodes"],
        numBlocks: json["num_blocks"],
        numDataRequests: json["num_data_requests"],
        numPendingRequests: json["num_pending_requests"],
        numReputedNodes: json["num_reputed_nodes"],
        numValueTransfers: json["num_value_transfers"],
      );

  Map<String, dynamic> jsonMap() => {
        "epochs": epochs,
        "num_active_nodes": numActiveNodes,
        "num_blocks": numBlocks,
        "num_data_requests": numDataRequests,
        "num_pending_requests": numPendingRequests,
        "num_reputed_nodes": numReputedNodes,
        "num_value_transfers": numValueTransfers,
      };
}

class SupplyInfo {
  SupplyInfo({
    required this.blocksMinted,
    required this.blocksMintedReward,
    required this.blocksMissing,
    required this.blocksMissingReward,
    required this.collateralLocked,
    required this.collateralizedDataRequests,
    required this.currentLockedSupply,
    required this.currentTime,
    required this.currentUnlockedSupply,
    required this.epoch,
    required this.totalSupply,
  });

  final int blocksMinted;
  final double blocksMintedReward;
  final int blocksMissing;
  final double blocksMissingReward;
  final int collateralLocked;
  final int collateralizedDataRequests;
  final double currentLockedSupply;
  final int currentTime;
  final double currentUnlockedSupply;
  final int epoch;
  final double totalSupply;

  factory SupplyInfo.fromRawJson(String str) =>
      SupplyInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory SupplyInfo.fromJson(Map<String, dynamic> json) => SupplyInfo(
        blocksMinted: json["blocks_minted"],
        blocksMintedReward: json["blocks_minted_reward"].toDouble(),
        blocksMissing: json["blocks_missing"],
        blocksMissingReward: json["blocks_missing_reward"].toDouble(),
        collateralLocked: json["collateral_locked"],
        collateralizedDataRequests: json["collateralized_data_requests"],
        currentLockedSupply: json["current_locked_supply"].toDouble(),
        currentTime: json["current_time"],
        currentUnlockedSupply: json["current_unlocked_supply"].toDouble(),
        epoch: json["epoch"],
        totalSupply: json["total_supply"].toDouble(),
      );

  Map<String, dynamic> jsonMap() => {
        "blocks_minted": blocksMinted,
        "blocks_minted_reward": blocksMintedReward,
        "blocks_missing": blocksMissing,
        "blocks_missing_reward": blocksMissingReward,
        "collateral_locked": collateralLocked,
        "collateralized_data_requests": collateralizedDataRequests,
        "current_locked_supply": currentLockedSupply,
        "current_time": currentTime,
        "current_unlocked_supply": currentUnlockedSupply,
        "epoch": epoch,
        "total_supply": totalSupply,
      };
}

class NodePool {
  NodePool({
    required this.chainBeacon,
    required this.currentEpoch,
    required this.nodeState,
  });

  final ChainBeacon chainBeacon;
  final int currentEpoch;
  final String nodeState;

  factory NodePool.fromRawJson(String str) =>
      NodePool.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory NodePool.fromJson(Map<String, dynamic> json) => NodePool(
        chainBeacon: ChainBeacon.fromJson(json["chain_beacon"]),
        currentEpoch: json["current_epoch"],
        nodeState: json["node_state"],
      );

  Map<String, dynamic> jsonMap() => {
        "chain_beacon": chainBeacon.toJson(),
        "current_epoch": currentEpoch,
        "node_state": nodeState,
      };
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

  String toRawJson() => json.encode(toJson());

  factory ChainBeacon.fromJson(Map<String, dynamic> json) => ChainBeacon(
        checkpoint: json["checkpoint"],
        hashPrevBlock: json["hashPrevBlock"],
      );

  Map<String, dynamic> toJson() => {
        "checkpoint": checkpoint,
        "hashPrevBlock": hashPrevBlock,
      };
}

class AddressBlocks {
  AddressBlocks({
    required this.address,
    required this.blocks,
    required this.numBlocksMinted,
    required this.type,
  });

  String address;
  List<BlockInfo> blocks;
  int numBlocksMinted;
  String type;

  factory AddressBlocks.fromJson(Map<String, dynamic> data) {
    return AddressBlocks(
        address: data['address'],
        blocks: List<BlockInfo>.from(
            data['blocks'].map((blockInfo) => BlockInfo.fromList(blockInfo))),
        numBlocksMinted: data['num_blocks_minted'],
        type: data['type']);
  }

  Map<String, dynamic> jsonMap() {
    return {
      'address': address,
      'blocks': List<dynamic>.from(blocks.map((e) => e.toList()))
    };
  }
}

class AddressDetails {
  AddressDetails({
    required this.address,
    required this.balance,
    required this.eligibility,
    required this.reputation,
    required this.totalReputation,
    required this.type,
  });

  final String address;
  final int balance;
  final int eligibility;
  final int reputation;
  final int totalReputation;
  final String type;

  factory AddressDetails.fromRawJson(String str) =>
      AddressDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory AddressDetails.fromJson(Map<String, dynamic> json) => AddressDetails(
        address: json["address"],
        balance: json["balance"],
        eligibility: json["eligibility"],
        reputation: json["reputation"],
        totalReputation: json["total_reputation"],
        type: json["type"],
      );

  Map<String, dynamic> jsonMap() => {
        "address": address,
        "balance": balance,
        "eligibility": eligibility,
        "reputation": reputation,
        "total_reputation": totalReputation,
        "type": type,
      };
}

class AddressDataRequestsSolved {
  AddressDataRequestsSolved({
    required this.address,
    required this.dataRequestsSolved,
    required this.numDataRequestsSolved,
    required this.type,
  });

  final String address;
  final List<DataRequestSolvedInfo> dataRequestsSolved;
  final int numDataRequestsSolved;
  final String type;

  factory AddressDataRequestsSolved.fromRawJson(String str) =>
      AddressDataRequestsSolved.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressDataRequestsSolved.fromJson(Map<String, dynamic> json) =>
      AddressDataRequestsSolved(
        address: json["address"],
        dataRequestsSolved: List<DataRequestSolvedInfo>.from(
            json["data_requests_solved"]
                .map((x) => DataRequestSolvedInfo.fromList(x))),
        numDataRequestsSolved: json["num_data_requests_solved"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "data_requests_solved":
            List<dynamic>.from(dataRequestsSolved.map((x) => x.tolist())),
        "num_data_requests_solved": numDataRequestsSolved,
        "type": type,
      };
}

class AddressValueTransfers {
  AddressValueTransfers({
    required this.address,
    required this.numValueTransfers,
    required this.type,
    required this.transactionHashes,
  });

  final String address;
  final int numValueTransfers;
  final String type;
  final List<String> transactionHashes;

  factory AddressValueTransfers.fromRawJson(String str) =>
      AddressValueTransfers.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory AddressValueTransfers.fromJson(Map<String, dynamic> json) =>
      AddressValueTransfers(
        address: json["address"],
        numValueTransfers: json["num_value_transfers"],
        type: json["type"],
        transactionHashes:
            List<String>.from(json["value_transfers"].map((x) => x[1])),
      );

  Map<String, dynamic> jsonMap() => {
        "address": address,
        "num_value_transfers": numValueTransfers,
        "type": type,
        "transaction_hashes": transactionHashes,
      };
}

class MintInfo {
  MintInfo({
    required this.blockHash,
    required this.outputs,
    required this.status,
    required this.txnEpoch,
    required this.txnHash,
    required this.txnTime,
    required this.type,
  });

  final String blockHash;
  final List<ValueTransferOutput> outputs;
  final String status;
  final int txnEpoch;
  final String txnHash;
  final int txnTime;
  final String type;

  factory MintInfo.fromRawJson(String str) =>
      MintInfo.fromJson(json.decode(str));

  String rawJson() => json.encode(jsonMap());

  factory MintInfo.fromJson(Map<String, dynamic> json) => MintInfo(
        blockHash: json["block_hash"],
        outputs: List<ValueTransferOutput>.from(json["mint_outputs"].map((x) =>
            ValueTransferOutput(
                pkh: Address.fromAddress(x[0]).publicKeyHash!,
                timeLock: 0,
                value: x[1]))),
        status: json["status"],
        txnEpoch: json["txn_epoch"],
        txnHash: json["txn_hash"],
        txnTime: json["txn_time"],
        type: json["type"],
      );

  Map<String, dynamic> jsonMap() => {
        "block_hash": blockHash,
        "mint_outputs":
            List<Map<String, dynamic>>.from(outputs.map((x) => x.jsonMap())),
        "status": status,
        "txn_epoch": txnEpoch,
        "txn_hash": txnHash,
        "txn_time": txnTime,
        "type": type,
      };

  void printDebug() {
    print('Mint Info');
    print('block_hash: $blockHash');
    print('mint_outputs: $outputs');
    print('status: $status');
    print('txn_epoch: $txnEpoch');
    print('txn_hash: $txnHash');
    print('txn_time: $txnTime');
    print('type: $type');
  }
}

class InputUtxo {
  InputUtxo({
    required this.address,
    required this.input,
    required this.value,
  });

  final String address;
  final Input input;
  final int value;

  String rawJson() => json.encode(jsonMap());

  Map<String, dynamic> jsonMap() {
    return {
      "pkh": address,
      "output_pointer":
          '${input.outputPointer.transactionId.hex}:${input.outputPointer.outputIndex}',
      "value": value,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return rawJson();
  }
}

class ValueTransferInfo {
  ValueTransferInfo({
    required this.blockHash,
    required this.fee,
    required this.inputs,
    required this.outputs,
    required this.priority,
    required this.status,
    required this.txnEpoch,
    required this.txnHash,
    required this.txnTime,
    required this.type,
    required this.weight,
  });

  final String blockHash;
  final int fee;
  final List<InputUtxo> inputs;
  final List<ValueTransferOutput> outputs;
  final int priority;
  final String status;
  final int txnEpoch;
  final String txnHash;
  final int txnTime;
  final String type;
  final int weight;

  factory ValueTransferInfo.fromJson(Map<String, dynamic> data) {
    List<InputUtxo> inputs = [];
    List<ValueTransferOutput> outputs = [];
    List<dynamic> inputAddresses = data['input_addresses'] as List<dynamic>;
    List<dynamic> outputAddresses = data['output_addresses'] as List<dynamic>;
    Map<String, dynamic> inputUxtos = data['input_utxos'];
    inputAddresses.forEach((element) {
      if (inputUxtos.containsKey(element[0])) {
        var _sub = inputUxtos[element[0]]!.first;

        String outputPointer = '${_sub[1]}:${_sub[2]}';

        inputs.add(
          InputUtxo(
            address: element[0] as String,
            input:
                Input(outputPointer: OutputPointer.fromString(outputPointer)),
            value: element[1] as int,
          ),
        );
      }
    });

    outputAddresses.forEach((element) {
      Address address = Address.fromAddress(element[0]);

      outputs.add(ValueTransferOutput(
          pkh: address.publicKeyHash!,
          timeLock: element[2],
          value: element[1]));
    });
    return ValueTransferInfo(
      blockHash: data["block_hash"],
      fee: data["fee"],
      priority: data["priority"],
      status: data["status"],
      txnEpoch: data["txn_epoch"],
      txnHash: data["txn_hash"],
      txnTime: data["txn_time"],
      type: data["type"],
      weight: data["weight"],
      inputs: inputs,
      outputs: outputs,
    );
  }

  factory ValueTransferInfo.fromDbJson(Map<String, dynamic> data) {
    List<InputUtxo> inputs = [];
    List<ValueTransferOutput> outputs = [];
    List<dynamic> out = data['outputs'];
    List<dynamic> inp = data['inputs'];
    inp.forEach((element) {
      inputs.add(
        InputUtxo(
          address: element['pkh'],
          input: Input(
              outputPointer:
                  OutputPointer.fromString(element['output_pointer'])),
          value: element['value'],
        ),
      );
    });
    out.forEach((element) {
      outputs.add(ValueTransferOutput(
        pkh: PublicKeyHash.fromAddress(element['pkh']),
        timeLock: element['time_lock'],
        value: element['value'],
      ));
    });

    return ValueTransferInfo(
      blockHash: data["block_hash"],
      fee: data["fee"],
      priority: data["priority"],
      status: data["status"],
      txnEpoch: data["txn_epoch"],
      txnHash: data["txn_hash"],
      txnTime: data["txn_time"],
      type: 'value_transfer',
      weight: data["weight"],
      inputs: inputs,
      outputs: outputs,
    );
  }

  String rawJson() => json.encode(jsonMap());

  Map<String, dynamic> jsonMap() {
    return {
      "block_hash": blockHash,
      "fee": fee,
      "priority": priority,
      "status": status,
      "txn_epoch": txnEpoch,
      "txn_hash": txnHash,
      "txn_time": txnTime,
      "weight": weight,
      "inputs": List<Map<String, dynamic>>.from(inputs.map((e) => e.jsonMap())),
      "outputs":
          List<Map<String, dynamic>>.from(outputs.map((e) => e.jsonMap())),
    };
  }

  void printDebug() {
    print('ValueTransferInfo:');

    print('blockHash: $blockHash');
    print('txnHash: $txnHash');
    print(
        'txnEpoch: $txnEpoch txnTime: ${DateTime.fromMillisecondsSinceEpoch(txnTime * 1000)}');

    print('status: $status');
    print('fee: $fee');
    print('priority: $priority');
    print('Inputs:');
    inputs.forEach((element) {
      print(element);
    });
    print('Outputs:');
    outputs.forEach((element) {
      print(element.rawJson);
    });
  }
}

class BlockInfo {
  BlockInfo({
    required this.blockID,
    required this.timestamp,
    required this.epoch,
    required this.reward,
    required this.fees,
    required this.valueTransferCount,
    required this.dataRequestCount,
    required this.commitCount,
    required this.revealCount,
    required this.tallyCount,
  });

  final Uint8List blockID;
  final int timestamp;
  final int epoch;
  final int reward;
  final int fees;
  final int valueTransferCount;
  final int dataRequestCount;
  final int commitCount;
  final int revealCount;
  final int tallyCount;

  factory BlockInfo.fromList(List<dynamic> data) {
    return BlockInfo(
        blockID: data[0],
        timestamp: data[1],
        epoch: data[2],
        reward: data[3],
        fees: data[4],
        valueTransferCount: data[5],
        dataRequestCount: data[6],
        commitCount: data[7],
        revealCount: data[8],
        tallyCount: data[9]);
  }

  List<dynamic> toList() {
    return [
      blockID,
      timestamp,
      epoch,
      reward,
      fees,
      valueTransferCount,
      commitCount,
      revealCount,
      tallyCount
    ];
  }
}

class DataRequestSolvedInfo {
  DataRequestSolvedInfo(
      {required this.success,
      required this.transactionID,
      required this.timestamp,
      required this.collateral,
      required this.epoch,
      required this.result,
      required this.error,
      required this.liar});

  final bool success;
  final String transactionID;
  final int timestamp;
  final int collateral;
  final int epoch;
  final DataRequestResult result;
  final bool error;
  final bool liar;

  factory DataRequestSolvedInfo.fromList(List<dynamic> data) {
    print(data);
    var result = (data[5].runtimeType == String)
        ? DataRequestResult(accepted: false, value: '')
        : DataRequestResult.fromList(data[5]);

    return DataRequestSolvedInfo(
        success: data[0],
        transactionID: data[1],
        timestamp: data[2],
        collateral: data[3],
        epoch: data[4],
        result: result,
        error: data[6],
        liar: data[7]);
  }

  List<dynamic> tolist() {
    return [success, transactionID, timestamp, collateral, result, error, liar];
  }

  Map<String, dynamic> jsonMap() => {
        'transactionID': transactionID,
        'timestamp': timestamp,
        'collateral': collateral,
        'error': error,
        'liar': liar,
        'success': success,
      };

  void printDebug() {
    print('transactionID: $transactionID');
    print('timestamp: $timestamp');
    print('collateral: $collateral');
    print('error: $error');
    print('liar $liar');
    print('success: $success');
  }
}

class DataRequestResult {
  DataRequestResult({
    required this.accepted,
    required this.value,
  });

  final bool accepted;
  final dynamic value;

  factory DataRequestResult.fromList(List<dynamic> data) {
    return DataRequestResult(accepted: data[0], value: data[1]);
  }

  List<dynamic> toList() {
    return [accepted, value];
  }
}

class Tapi {
  Tapi({
    required this.tapis,
  });

  final Map<String, TapiInfo> tapis;

  factory Tapi.fromRawJson(String str) => Tapi.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory Tapi.fromJson(Map<String, dynamic> json) {
    Map<String, TapiInfo> _tapis = {};
    json.forEach((key, value) {
      _tapis[key] = TapiInfo.fromJson(value);
    });
    return Tapi(tapis: _tapis);
  }

  Map<String, dynamic> jsonMap() => tapis;
}

class TapiInfo {
  TapiInfo({
    required this.accept,
    required this.active,
    required this.bit,
    required this.currentEpoch,
    required this.description,
    required this.globalAcceptanceRate,
    required this.previousEpoch,
    required this.rates,
    required this.relativeAcceptanceRate,
    required this.startEpoch,
    required this.startTime,
    required this.stopEpoch,
    required this.stopTime,
    required this.tapiId,
    required this.title,
    required this.urls,
  });

  final List<dynamic> accept;
  final bool active;
  final int bit;
  final int currentEpoch;
  final String description;
  final double globalAcceptanceRate;
  final int previousEpoch;
  final List<Rate> rates;
  final double relativeAcceptanceRate;
  final int startEpoch;
  final int startTime;
  final int stopEpoch;
  final int stopTime;
  final int tapiId;
  final String title;
  final List<String> urls;

  factory TapiInfo.fromRawJson(String str) =>
      TapiInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory TapiInfo.fromJson(Map<String, dynamic> json) => TapiInfo(
        accept: List<dynamic>.from(json["accept"].map((x) => x)),
        active: json["active"],
        bit: json["bit"],
        currentEpoch: json["current_epoch"],
        description: json["description"],
        globalAcceptanceRate: json["global_acceptance_rate"].toDouble(),
        previousEpoch: json["previous_epoch"],
        rates: List<Rate>.from(json["rates"].map((x) => Rate.fromJson(x))),
        relativeAcceptanceRate: json["relative_acceptance_rate"].toDouble(),
        startEpoch: json["start_epoch"],
        startTime: json["start_time"],
        stopEpoch: json["stop_epoch"],
        stopTime: json["stop_time"],
        tapiId: json["tapi_id"],
        title: json["title"],
        urls: List<String>.from(json["urls"].map((x) => x)),
      );

  Map<String, dynamic> jsonMap() => {
        "accept": List<dynamic>.from(accept.map((x) => x)),
        "active": active,
        "bit": bit,
        "current_epoch": currentEpoch,
        "description": description,
        "global_acceptance_rate": globalAcceptanceRate,
        "previous_epoch": previousEpoch,
        "rates": List<dynamic>.from(rates.map((x) => x.jsonMap())),
        "relative_acceptance_rate": relativeAcceptanceRate,
        "start_epoch": startEpoch,
        "start_time": startTime,
        "stop_epoch": stopEpoch,
        "stop_time": stopTime,
        "tapi_id": tapiId,
        "title": title,
        "urls": List<dynamic>.from(urls.map((x) => x)),
      };
}

class Rate {
  Rate({
    required this.globalRate,
    required this.periodicRate,
    required this.relativeRate,
  });

  final double globalRate;
  final double periodicRate;
  final double relativeRate;

  factory Rate.fromRawJson(String str) => Rate.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        globalRate: json["global_rate"].toDouble(),
        periodicRate: json["periodic_rate"].toDouble(),
        relativeRate: json["relative_rate"].toDouble(),
      );

  Map<String, dynamic> jsonMap() => {
        "global_rate": globalRate,
        "periodic_rate": periodicRate,
        "relative_rate": relativeRate,
      };
}

class Blockchain {
  Blockchain({required this.blockchain});

  final List<BlockchainInfo> blockchain;

  factory Blockchain.fromJson(Map<String, dynamic> data) {
    return Blockchain(
        blockchain: List<BlockchainInfo>.from(
            data['blockchain'].map((e) => BlockchainInfo.fromList(e))));
  }
}

class BlockchainInfo {
  BlockchainInfo(
      {required this.blockID,
      required this.epoch,
      required this.timestamp,
      required this.minerAddress,
      required this.fee,
      required this.valueTransferCount,
      required this.dataRequestCount,
      required this.commitCount,
      required this.revealCount,
      required this.tallyCount,
      required this.confirmed});

  final String blockID;
  final int epoch;
  final int timestamp;
  final String minerAddress;
  final int fee;
  final int valueTransferCount;
  final int dataRequestCount;
  final int commitCount;
  final int revealCount;
  final int tallyCount;
  final bool confirmed;

  factory BlockchainInfo.fromList(List<dynamic> data) {
    return BlockchainInfo(
        blockID: data[0],
        epoch: data[1],
        timestamp: data[2],
        minerAddress: data[3],
        fee: data[4],
        valueTransferCount: data[5],
        dataRequestCount: data[6],
        commitCount: data[7],
        revealCount: data[8],
        tallyCount: data[9],
        confirmed: data[10]);
  }
}
