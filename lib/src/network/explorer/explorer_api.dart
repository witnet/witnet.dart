import 'dart:convert' show json;

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
    required this.nodePoolMessage,
    required this.expectedEpoch,
  });

  final Map<String, dynamic> databaseLastConfirmed;
  final Map<String, dynamic> databaseLastUnconfirmed;
  final String databaseMessage;
  final Map<String, dynamic> nodePoolMessage;
  final int expectedEpoch;

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
      databaseLastConfirmed: json["database_confirmed"],
      databaseLastUnconfirmed: json["database_unconfirmed"],
      databaseMessage: json["database_message"],
      nodePoolMessage: json["node_pool_message"],
      expectedEpoch: json["expected_epoch"]);

  Map<String, dynamic> jsonMap() => {
        "database_last_confirmed": databaseLastConfirmed,
        "database_last_unconfirmed": databaseLastUnconfirmed,
        "database_message": databaseMessage,
        "node_pool_message": nodePoolMessage,
        "expected_epoch": expectedEpoch,
      };

  void printDebug() {
    print('Status:');
    print('databaseLastConfirmed: $databaseLastConfirmed');
    print('databaseLastUnconfirmed: $databaseLastUnconfirmed');
    print('databaseMessage: $databaseMessage');
    print('nodePoolMessage: $nodePoolMessage');
    print('expectedEpoch: $expectedEpoch');
  }
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

class NetworkBalances {
  NetworkBalances({
    required this.balances,
    required this.totalItems,
    required this.totalBalancesSum,
    required this.lastUpdated,
  });

  final List<Balance> balances;
  final int totalItems;
  final int totalBalancesSum;
  final int lastUpdated;

  factory NetworkBalances.fromRawJson(String str) =>
      NetworkBalances.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory NetworkBalances.fromJson(Map<String, dynamic> json) =>
      NetworkBalances(
        balances: List<Balance>.from(
            json["balances"].map((e) => Balance.fromJson(e))),
        totalItems: json["total_items"],
        totalBalancesSum: json["total_balance_sum"],
        lastUpdated: json["last_updated"],
      );

  Map<String, dynamic> jsonMap() => {
        "balances": balances.map((e) => e.jsonMap()).toList(),
        "total_items": totalItems,
        "total_balances_sum": totalBalancesSum,
        "lastUpdated": lastUpdated,
      };
}

class Balance {
  Balance({
    required this.address,
    required this.balance,
    required this.label,
  });

  final String address;
  final int balance;
  final String label;

  factory Balance.fromRawJson(String str) => Balance.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        address: json["address"],
        balance: json["balance"],
        label: json["label"],
      );

  Map<String, dynamic> jsonMap() => {
        "address": address,
        "balance": balance,
        "label": label,
      };
}

class NetworkReputation {
  NetworkReputation({
    required this.reputations,
    required this.totalReputation,
    required this.lastUpdated,
  });

  final List<Reputation> reputations;
  final int totalReputation;
  final int lastUpdated;

  factory NetworkReputation.fromRawJson(String str) =>
      NetworkReputation.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory NetworkReputation.fromJson(Map<String, dynamic> json) =>
      NetworkReputation(
        reputations: List.from(json["reputation"])
            .map((e) => Reputation.fromJson(e))
            .toList(),
        totalReputation: json["total_reputation"],
        lastUpdated: json["last_updated"],
      );

  Map<String, dynamic> jsonMap() => {
        "reputations": reputations.map((e) => e.jsonMap()).toList(),
        "total_reputation": totalReputation,
        "last_updated": lastUpdated,
      };
}

class Reputation {
  Reputation({
    required this.address,
    required this.reputation,
    required this.eligibility,
  });

  final String address;
  final int reputation;
  final double eligibility;

  factory Reputation.fromRawJson(String str) =>
      Reputation.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory Reputation.fromJson(Map<String, dynamic> json) => Reputation(
        address: json["address"],
        reputation: json["reputation"],
        eligibility: json["eligibility"],
      );

  Map<String, dynamic> jsonMap() => {
        "address": address,
        "reputation": reputation,
        "eligibility": eligibility,
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
  });

  String address;
  List<BlockInfo> blocks;

  factory AddressBlocks.fromExplorerJson(List<dynamic> data) {
    return AddressBlocks(
      address: data[0]['miner'],
      blocks: List<BlockInfo>.from(
          data.map((blockInfo) => BlockInfo.fromJson(blockInfo))),
    );
  }

  // TODO: move this to myWitWallet
  factory AddressBlocks.fromDBJson(List<dynamic> data) {
    return AddressBlocks(
      address: data[0]['address'],
      blocks: List<BlockInfo>.from(
          data.map((blockInfo) => BlockInfo.fromJson(blockInfo))),
    );
  }

  factory AddressBlocks.fromJson(List<dynamic> data) {
    bool dbJson = data[0]['miner'] == null;
    if (dbJson) {
      // TODO: move this to myWitWallet
      return AddressBlocks.fromDBJson(data);
    } else {
      return AddressBlocks.fromExplorerJson(data);
    }
  }

  Map<String, dynamic> jsonMap() {
    List<BlockInfo> blocksMined = blocks;
    return {
      'address': address,
      'blocks': blocksMined.map((e) => e.jsonMap()).toList(),
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
  });

  final String address;
  final List<DataRequestSolvedInfo> dataRequestsSolved;

  factory AddressDataRequestsSolved.fromRawJson(String str) =>
      AddressDataRequestsSolved.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressDataRequestsSolved.fromJson(Map<String, dynamic> json) {
    return AddressDataRequestsSolved(
      address: json["address"],
      dataRequestsSolved: List<DataRequestSolvedInfo>.from(
          json["data_requests_solved"]
              .map((dr) => DataRequestSolvedInfo.fromJson(dr))),
    );
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "data_requests_solved":
            dataRequestsSolved.map((e) => e.jsonMap()).toList().toList(),
      };
}

class AddressValueTransfers {
  AddressValueTransfers({
    required this.address,
    required this.addressValueTransfers,
  });

  final String address;
  final List<dynamic> addressValueTransfers;

  factory AddressValueTransfers.fromRawJson(String str) =>
      AddressValueTransfers.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory AddressValueTransfers.fromJson(Map<String, dynamic> json) =>
      AddressValueTransfers(
        address: json["address"],
        addressValueTransfers: List<AddressValueTransferInfo>.from(
            json["value_transfers"]
                .map((x) => AddressValueTransferInfo.fromJson(x))),
      );

  Map<String, dynamic> jsonMap() => {
        "address": address,
        "address_value_transfers": addressValueTransfers
            .map((e) => (e as AddressValueTransferInfo).jsonMap())
            .toList(),
      };
}

class AddressValueTransferInfo {
  AddressValueTransferInfo({
    required this.epoch,
    required this.timestamp,
    required this.hash,
    required this.direction,
    required this.inputAddresses,
    required this.outputAddresses,
    required this.value,
    required this.fee,
    required this.weight,
    required this.priority,
    required this.locked,
    required this.confirmed,
  });

  final int epoch;
  final int timestamp;
  final String hash;
  final String direction;
  final List<String> inputAddresses;
  final List<String> outputAddresses;
  final int value;
  final int fee;
  final int weight;
  final int priority;
  final bool locked;
  final bool confirmed;

  factory AddressValueTransferInfo.fromRawJson(String str) =>
      AddressValueTransferInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory AddressValueTransferInfo.fromJson(Map<String, dynamic> json) =>
      AddressValueTransferInfo(
        epoch: json["epoch"],
        timestamp: json["timestamp"],
        hash: json["hash"],
        direction: json["direction"],
        inputAddresses: List<String>.from(json["input_addresses"]),
        outputAddresses: List<String>.from(json["output_addresses"]),
        value: json["value"],
        fee: json["fee"],
        weight: json["weight"],
        priority: json["priority"],
        locked: json["locked"],
        confirmed: json["confirmed"],
      );

  Map<String, dynamic> jsonMap() => {
        "epoch": epoch,
        "timestamp": timestamp,
        "hash": hash,
        "direction": direction, // in, out, sel,
        "input_addresses": inputAddresses,
        "output_addresses": outputAddresses,
        "value": value,
        "fee": fee,
        "weight": weight,
        "priority": priority,
        "locked": locked,
        "confirmed": confirmed,
      };
}

class AddressInfo {
  final String address;
  final String label;
  final int active;
  final int block;
  final int mint;
  final int value_transfer;
  final int data_request;
  final int commit;
  final int reveal;
  final int tally;

  AddressInfo({
    required this.address,
    required this.label,
    required this.active,
    required this.block,
    required this.mint,
    required this.value_transfer,
    required this.data_request,
    required this.commit,
    required this.reveal,
    required this.tally,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        address: json["address"],
        label: json["label"],
        active: json["active"],
        block: json["block"],
        mint: json["mint"],
        value_transfer: json["value_transfer"],
        data_request: json["data_request"],
        commit: json["commit"],
        reveal: json["reveal"],
        tally: json["tally"],
      );

  Map<String, dynamic> jsonMap() => {
        "address": address,
        "label": label,
        "active": active,
        "block": block,
        "mint": mint,
        "value_transfer": value_transfer,
        "data_request": data_request,
        "commit": commit,
        "reveal": reveal,
        "tally": tally,
      };
}

class MintInfo {
  MintInfo({
    required this.miner,
    required this.blockHash,
    required this.outputs,
    required this.txnEpoch,
    required this.txnHash,
    required this.txnTime,
    required this.type,
  });

  final String miner;
  final String blockHash;
  final List<ValueTransferOutput> outputs;
  final int txnEpoch;
  final String txnHash;
  final int txnTime;
  final String type;

  factory MintInfo.fromRawJson(String str) =>
      MintInfo.fromJson(json.decode(str));

  String rawJson() => json.encode(jsonMap());

  factory MintInfo.fromJson(Map<String, dynamic> json) {
    var outputAddresses = json["output_addresses"];
    var outputValues = json["output_values"];

    List<ValueTransferOutput> outputs = [];
    for (int i = 0; i < outputAddresses.length; i++) {
      ValueTransferOutput vto = ValueTransferOutput(
        value: outputValues[i],
        pkh: Address.fromAddress(outputAddresses[i]).publicKeyHash!,
        // TODO: the explorer should return some value
        timeLock: 0,
      );
      outputs.add(vto);
    }

    return MintInfo(
      miner: json["miner"],
      blockHash: json["block_hash"],
      outputs: outputs,
      txnEpoch: json["txn_epoch"],
      txnHash: json["txn_hash"],
      txnTime: json["txn_time"],
      type: json["type"],
    );
  }

  Map<String, dynamic> jsonMap() => {
        "miner": miner,
        "block_hash": blockHash,
        "mint_outputs":
            List<Map<String, dynamic>>.from(outputs.map((x) => x.jsonMap())),
        "txn_epoch": txnEpoch,
        "txn_hash": txnHash,
        "txn_time": txnTime,
        "type": type,
      };

  void printDebug() {
    print('Mint Info');
    print('miner: $miner');
    print('block_hash: $blockHash');
    print('mint_outputs: $outputs');
    print('txn_epoch: $txnEpoch');
    print('txn_hash: $txnHash');
    print('txn_time: $txnTime');
    print('type: $type');
  }
}

class InputUtxo {
  InputUtxo({
    required this.address,
    required this.inputUtxo,
    required this.value,
  });

  final String address;
  final String inputUtxo;
  final int value;

  String rawJson() => json.encode(jsonMap());

  Map<String, dynamic> jsonMap() {
    return {
      "address": address,
      "value": value,
      "input_utxo": inputUtxo,
    };
  }

  factory InputUtxo.fromExplorerJson(Map<String, dynamic> json) => InputUtxo(
      address: json["address"],
      inputUtxo: json["input_utxo"],
      value: json["value"]);

  // TODO: move this to myWitWallet
  factory InputUtxo.fromDBJson(Map<String, dynamic> json) => InputUtxo(
      address: json["pkh"],
      inputUtxo: json["output_pointer"],
      value: json["value"]);

  factory InputUtxo.fromJson(Map<String, dynamic> json) {
    bool dbJson = json["pkh"] != null;
    if (dbJson) {
      // TODO: move this to myWitWallet
      return InputUtxo.fromDBJson(json);
    } else {
      return InputUtxo.fromExplorerJson(json);
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return rawJson();
  }
}

class InputMerged {
  final String address;
  final int value;

  InputMerged({
    required this.address,
    required this.value,
  });

  factory InputMerged.fromJson(Map<String, dynamic> json) {
    return InputMerged(address: json["address"], value: json["value"]);
  }

  String rawJson() => json.encode(jsonMap());

  Map<String, dynamic> jsonMap() {
    return {"address": address, 'value': value};
  }
}

class TransactionUtxo {
  final String address;
  final int value;
  final int timelock;
  final bool locked;

  TransactionUtxo({
    required this.address,
    required this.value,
    required this.timelock,
    required this.locked,
  });

  factory TransactionUtxo.fromJson(Map<String, dynamic> json) {
    return TransactionUtxo(
        address: json["address"],
        value: json["value"],
        timelock: json["timelock"],
        locked: json["locked"]);
  }

  String rawJson() => json.encode(jsonMap());

  Map<String, dynamic> jsonMap() {
    return {
      "address": address,
      'value': value,
      'timelock': timelock,
      'locked': locked
    };
  }
}

// TODO: move to a different place
// TODO: use this enum in all the package
enum TxStatusLabel { pending, mined, confirmed, reverted, unknown }

enum TransactionType { value_transfer, data_request, mint }

class TransactionStatus {
  TxStatusLabel status = TxStatusLabel.pending;
  TransactionStatus({required this.status});

  factory TransactionStatus.fromJson(Map<String, dynamic> json) {
    TxStatusLabel status;
    if (json['status'] != null) {
      if (json['status'] == 'confirmed' ||
          json['status'] == 'TxStatusLabel.confirmed') {
        status = TxStatusLabel.confirmed;
      } else if (json['status'] == 'mined' ||
          json['status'] == 'TxStatusLabel.mined') {
        status = TxStatusLabel.mined;
      } else if (json['status'] == 'TxStatusLabel.unknown') {
        status = TxStatusLabel.unknown;
      } else {
        status = TxStatusLabel.pending;
      }
    } else if (json["reverted"] != null && json["reverted"] == true) {
      status = TxStatusLabel.reverted;
    } else if (json["confirmed"] != null && json["confirmed"] == true) {
      status = TxStatusLabel.confirmed;
    } else if (json["confirmed"] != null && json["confirmed"] == false) {
      status = TxStatusLabel.mined;
    } else {
      status = TxStatusLabel.pending;
    }
    return TransactionStatus(status: status);
  }
}

class NullableFields {
  final int? value;
  final bool confirmed;
  final bool reverted;
  final List<String> inputAddresses;
  final List<InputMerged> inputsMerged;
  final List<String> outputAddresses;
  final List<int> outputValues;
  final List<int> timelocks;
  final List<TransactionUtxo> utxos;
  final List<TransactionUtxo> utxosMerged;
  final List<String> trueOutputAddresses;
  final List<String> changeOutputAddresses;
  final int? trueValue;
  final int? changeValue;
  NullableFields(
      {required this.changeOutputAddresses,
      required this.changeValue,
      required this.confirmed,
      required this.inputAddresses,
      required this.inputsMerged,
      required this.outputAddresses,
      required this.outputValues,
      required this.reverted,
      required this.timelocks,
      required this.trueOutputAddresses,
      required this.trueValue,
      required this.utxos,
      required this.utxosMerged,
      required this.value});
}

NullableFields getOrDefault(Map<String, dynamic> data) {
  return NullableFields(
    value: data["value"] ?? null,
    confirmed: data["confirmed"] ??
        TransactionStatus.fromJson(data).status == TxStatusLabel.confirmed,
    reverted: data["reverted"] ??
        TransactionStatus.fromJson(data).status == TxStatusLabel.reverted,
    inputAddresses: data["input_addresses"] != null
        ? List<String>.from(data["input_addresses"])
        : List<String>.from(data["inputs"].map((input) {
            print('inout address:: ${input}');
            return input['pkh'];
          }).toList()),
    inputsMerged: data["inputs_merged"] != null
        ? List<InputMerged>.from(
            data["inputs_merged"].map((x) => InputMerged.fromJson(x)))
        : [],
    outputAddresses: data["output_addresses"] != null
        ? List<String>.from(data["output_addresses"])
        : List<String>.from(
            data["outputs"].map((output) => output['pkh']).toList()),
    outputValues: data["output_values"] != null
        ? List<int>.from(data["output_values"])
        : List<int>.from(
            data["outputs"].map((output) => output['value']).toList()),
    timelocks: data["timelocks"] != null
        ? List<int>.from(data["timelocks"])
        : List<int>.from(
            data["outputs"].map((output) => output['time_lock']).toList()),
    utxos: data["utxos"] != null
        ? List<TransactionUtxo>.from(data["utxos"]
            .map((e) => TransactionUtxo.fromJson(Map<String, dynamic>.from(e))))
        : [],
    utxosMerged: data["utxos_merged"] != null
        ? List<TransactionUtxo>.from(data["utxos_merged"]
            .map((e) => TransactionUtxo.fromJson(Map<String, dynamic>.from(e))))
        : [],
    trueOutputAddresses: data["true_output_addresses"] != null
        ? List<String>.from(data["true_output_addresses"])
        : [],
    changeOutputAddresses: data["change_output_addresses"] != null
        ? List<String>.from(data["change_output_addresses"])
        : [],
    trueValue: data["true_value"],
    changeValue: data["change_value"],
  );
}

class ValueTransferInfo extends HashInfo {
  ValueTransferInfo(
      {required this.epoch,
      required this.timestamp,
      required this.hash,
      required this.inputAddresses,
      required this.outputAddresses,
      required this.value,
      required this.fee,
      required this.weight,
      required this.priority,
      required this.block,
      required this.confirmed,
      required this.reverted,
      required this.inputUtxos,
      required this.inputsMerged,
      required this.outputValues,
      required this.timelocks,
      required this.utxos,
      required this.utxosMerged,
      required this.trueOutputAddresses,
      required this.changeOutputAddresses,
      this.trueValue,
      this.changeValue,
      required this.status,
      required this.outputs})
      : super(
            txnHash: hash,
            status: status,
            type: TransactionType.value_transfer,
            txnTime: epoch,
            blockHash: null);

  final int epoch;
  final int timestamp;
  final String hash;
  final String block;
  final List<InputUtxo> inputUtxos;
  final int fee;
  final int weight;
  final int priority;
  final TxStatusLabel status;
  final List<ValueTransferOutput> outputs;
  final int? value;
  final bool confirmed;
  final bool reverted;
  final List<String> inputAddresses;
  final List<InputMerged> inputsMerged;
  final List<String> outputAddresses;
  final List<int> outputValues;
  final List<int> timelocks;
  final List<TransactionUtxo> utxos;
  final List<TransactionUtxo> utxosMerged;
  final List<String> trueOutputAddresses;
  final List<String> changeOutputAddresses;
  final int? trueValue;
  final int? changeValue;

  factory ValueTransferInfo.fromExplorerJson(Map<String, dynamic> data) {
    List<String> outputAddresses = getOrDefault(data).outputAddresses;
    List<int> outputValues = getOrDefault(data).outputValues;
    List<ValueTransferOutput> outputs = [];
    for (int i = 0; i < outputValues.length; i++) {
      ValueTransferOutput vto = ValueTransferOutput(
        value: outputValues[i],
        pkh: Address.fromAddress(outputAddresses[i]).publicKeyHash!,
        timeLock: 0,
      );
      outputs.add(vto);
    }

    final result = ValueTransferInfo(
      epoch: data["epoch"],
      timestamp: data["timestamp"],
      hash: data["hash"],
      block: data["block"],
      inputUtxos: List<InputUtxo>.from(
          data["input_utxos"].map((x) => InputUtxo.fromJson(x))),
      fee: data["fee"],
      priority: data["priority"],
      weight: data["weight"],
      status: TransactionStatus.fromJson(data).status,
      outputs: outputs,
      value: getOrDefault(data).value,
      confirmed: getOrDefault(data).confirmed,
      reverted: getOrDefault(data).reverted,
      inputAddresses: getOrDefault(data).inputAddresses,
      inputsMerged: getOrDefault(data).inputsMerged,
      outputAddresses: outputAddresses,
      outputValues: outputValues,
      timelocks: getOrDefault(data).timelocks,
      utxos: getOrDefault(data).utxos,
      utxosMerged: getOrDefault(data).utxosMerged,
      trueOutputAddresses: getOrDefault(data).trueOutputAddresses,
      changeOutputAddresses: getOrDefault(data).outputAddresses,
      trueValue: getOrDefault(data).trueValue,
      changeValue: getOrDefault(data).changeValue,
    );
    return result;
  }

  // TODO: move this to myWitWallet
  factory ValueTransferInfo.fromDBJson(Map<String, dynamic> data) {
    List<String> outputAddresses = getOrDefault(data).outputAddresses;
    List<int> outputValues = getOrDefault(data).outputValues;
    List<ValueTransferOutput> outputs = [];
    if (data['outputs'] != null) {
      data['outputs'].forEach((element) {
        Address address = Address.fromAddress(element['pkh']);

        outputs.add(ValueTransferOutput(
            pkh: address.publicKeyHash!,
            timeLock: element['time_lock'],
            value: element['value']));
      });
    } else {
      for (int i = 0; i < outputValues.length; i++) {
        ValueTransferOutput vto = ValueTransferOutput(
          value: outputValues[i],
          pkh: Address.fromAddress(outputAddresses[i]).publicKeyHash!,
          timeLock: 0,
        );
        outputs.add(vto);
      }
    }
    return ValueTransferInfo(
        epoch: data["txn_epoch"],
        timestamp: data["txn_time"],
        hash: data["txn_hash"],
        block: data["block_hash"],
        inputUtxos: List<InputUtxo>.from(
            data["inputs"].map((x) => InputUtxo.fromJson(x))),
        fee: data["fee"],
        priority: data["priority"],
        weight: data["weight"],
        status: TransactionStatus.fromJson(data).status,
        outputs: outputs,
        value: getOrDefault(data).value,
        confirmed: getOrDefault(data).confirmed,
        reverted: getOrDefault(data).reverted,
        inputAddresses: getOrDefault(data).inputAddresses,
        inputsMerged: getOrDefault(data).inputsMerged,
        outputAddresses: getOrDefault(data).outputAddresses,
        outputValues: getOrDefault(data).outputValues,
        timelocks: getOrDefault(data).timelocks,
        utxos: getOrDefault(data).utxos,
        utxosMerged: getOrDefault(data).utxosMerged,
        trueOutputAddresses: getOrDefault(data).trueOutputAddresses,
        changeOutputAddresses: getOrDefault(data).outputAddresses,
        trueValue: getOrDefault(data).trueValue,
        changeValue: getOrDefault(data).changeValue);
  }

  factory ValueTransferInfo.fromJson(Map<String, dynamic> data) {
    bool dbJson = data["epoch"] == null;
    if (dbJson) {
      // TODO: move this to myWitWallet
      return ValueTransferInfo.fromDBJson(data);
    } else {
      return ValueTransferInfo.fromExplorerJson(data);
    }
  }

  String rawJson() => json.encode(jsonMap());

  Map<String, dynamic> jsonMap() {
    return {
      "txn_epoch": epoch,
      "txn_time": timestamp,
      "txn_hash": hash,
      "block_hash": block,
      "confirmed": confirmed,
      "reverted": reverted,
      "input_addresses": inputAddresses,
      "output_addresses": outputAddresses,
      "output_values": outputValues,
      "timelocks": timelocks,
      "fee": fee,
      "value": value,
      "priority": priority,
      "weight": weight,
      "true_output_addresses": trueOutputAddresses,
      "change_output_addresses": changeOutputAddresses,
      "trueValue": trueValue,
      "changeValue": changeValue,
      "status": status.toString(),
      "outputs":
          List<Map<String, dynamic>>.from(outputs.map((e) => e.jsonMap())),
      "inputs":
          List<Map<String, dynamic>>.from(inputUtxos.map((e) => e.jsonMap())),
      "inputs_merged":
          List<Map<String, dynamic>>.from(inputsMerged.map((e) => e.jsonMap())),
      "utxos": List<Map<String, dynamic>>.from(utxos.map((e) => e.jsonMap())),
      "utxos_merged":
          List<Map<String, dynamic>>.from(utxosMerged.map((e) => e.jsonMap())),
    };
  }

  void printDebug() {
    print('ValueTransferInfo:');
    print("epoch: $epoch");
    print('timestamp: $timestamp');
    print('hash: $hash');
    print('inputAddresses:');
    inputAddresses.forEach((element) {
      print(element);
    });
    print('outputAddresses:');
    outputAddresses.forEach((element) {
      print(element);
    });
    print('value: $value');
    print('fee: $fee');
    print('weight: $weight');
    print('priority: $priority');
  }

  bool containsAddress(String address) {
    bool isInTrx = false;
    inputAddresses.forEach((input) {
      if (input == address) {
        isInTrx = true;
      }
    });
    outputAddresses.forEach((output) {
      if (output == address) {
        isInTrx = true;
      }
    });
    return isInTrx;
  }
}

class BlockInfo {
  BlockInfo({
    required this.hash,
    required this.timestamp,
    required this.epoch,
    required this.reward,
    required this.fees,
    required this.valueTransferCount,
    required this.dataRequestCount,
    required this.commitCount,
    required this.revealCount,
    required this.tallyCount,
    required this.confirmed,
    required this.miner,
  });

  final String hash;
  final int timestamp;
  final int epoch;
  final int reward;
  final int fees;
  final int valueTransferCount;
  final int dataRequestCount;
  final int commitCount;
  final int revealCount;
  final int tallyCount;
  final bool confirmed;
  final String miner;

  factory BlockInfo.fromJson(Map<String, dynamic> data) {
    return BlockInfo(
      hash: data["hash"],
      timestamp: data["timestamp"],
      epoch: data["epoch"],
      reward: data["block_reward"],
      fees: data["block_fees"],
      valueTransferCount: data["value_transfers"],
      dataRequestCount: data["data_requests"],
      commitCount: data["commits"],
      revealCount: data["reveals"],
      tallyCount: data["tallies"],
      confirmed: data["confirmed"],
      miner: data["miner"],
    );
  }

  Map<String, dynamic> jsonMap() => {
        'hash': hash,
        'timestamp': timestamp,
        'epoch': epoch,
        'block_reward': reward,
        'block_fees': fees,
        'value_transfers': valueTransferCount,
        'data_requests': dataRequestCount,
        'commits': commitCount,
        'reveals': revealCount,
        'tallies': tallyCount,
        'confirmed': confirmed,
        'miner': miner,
      };
}

class BlockDetails {
  BlockDetails({
    required this.blockHash,
    required this.epoch,
    required this.timestamp,
    required this.drWeight,
    required this.vtWeight,
    required this.blockWeight,
    required this.confirmed,
    required this.reverted,
    required this.mintInfo,
  });

  final int epoch;
  final int timestamp;
  final String blockHash;
  final int drWeight;
  final int vtWeight;
  final int blockWeight;
  final bool confirmed;
  final bool reverted;
  final MintInfo mintInfo;

  factory BlockDetails.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> mint_txn = json['block']["transactions"]["mint"];
    String mintHash = mint_txn["hash"];
    List<ValueTransferOutput> outputs = [];
    for (int i = 0; i < mint_txn['output_addresses'].length; i++) {
      String _address = mint_txn['output_addresses'][i];
      int _value = mint_txn['output_values'][i];

      ValueTransferOutput _output = ValueTransferOutput(
          pkh: PublicKeyHash.fromAddress(_address), value: _value, timeLock: 0);
      outputs.add(_output);
    }
    MintInfo mintInfo = MintInfo(
        miner: mint_txn["miner"],
        blockHash: json['block']["details"]["hash"],
        outputs: outputs,
        txnEpoch: json['block']["details"]["epoch"],
        txnHash: mintHash,
        txnTime: json['block']["details"]["timestamp"],
        type: "mint");

    return BlockDetails(
      blockHash: json['block']["details"]["hash"],
      epoch: json['block']["details"]["epoch"],
      timestamp: json['block']["details"]["timestamp"],
      drWeight: json['block']["details"]["data_request_weight"] ?? 0,
      vtWeight: json['block']["details"]["value_transfer_weight"] ?? 0,
      blockWeight: json['block']["details"]["weight"],
      confirmed: json['block']["details"]["confirmed"],
      reverted: json['block']["details"]["reverted"],
      mintInfo: mintInfo,
    );
  }
}

class DataRequestSolvedInfo {
  DataRequestSolvedInfo(
      {required this.success,
      required this.hash,
      required this.epoch,
      required this.timestamp,
      required this.collateral,
      required this.witnessReward,
      required this.reveal,
      required this.error,
      required this.liar});

  final bool success;
  final String hash;
  final int epoch;
  final int timestamp;
  final int collateral;
  final int witnessReward;
  final String reveal;
  final bool error;
  final bool liar;

  factory DataRequestSolvedInfo.fromJson(Map<String, dynamic> data) {
    return DataRequestSolvedInfo(
        success: data['success'],
        hash: data["hash"],
        epoch: data['epoch'],
        timestamp: data['timestamp'],
        collateral: data['collateral'],
        witnessReward: data['witness_reward'],
        reveal: data['reveal'],
        error: data['error'],
        liar: data['liar']);
  }

  Map<String, dynamic> jsonMap() => {
        'success': success,
        'hash': hash,
        'timestamp': timestamp,
        'collateral': collateral,
        'epoch': epoch,
        'witnessReward': witnessReward,
        'reveal': reveal,
        'error': error,
        'liar': liar,
      };

  void printDebug() {
    print('transactionID: $hash');
    print('timestamp: $timestamp');
    print('collateral: $collateral');
    print('error: $error');
    print('witnessReward: $witnessReward');
    print('reveal: $reveal');
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

  factory Tapi.fromJson(List<dynamic> tapis) {
    Map<String, TapiInfo> _tapis = {};
    tapis.forEach((value) =>
        _tapis[value['tapi_id'].toString()] = TapiInfo.fromJson(value));
    return Tapi(tapis: _tapis);
  }

  Map<String, dynamic> jsonMap() {
    Map<String, dynamic> json = {};
    tapis.forEach((key, value) {
      json[key] = value.jsonMap();
    });
    return json;
  }
}

class TapiInfo {
  TapiInfo({
    required this.activated,
    required this.active,
    required this.bit,
    required this.currentEpoch,
    required this.description,
    required this.finished,
    required this.globalAcceptanceRate,
    required this.lastUpdated,
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

  final bool activated;
  final bool active;
  final int bit;
  final int currentEpoch;
  final String description;
  final bool finished;
  final double globalAcceptanceRate;
  final int lastUpdated;
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
        activated: json["activated"],
        active: json["active"],
        bit: json["bit"],
        currentEpoch: json["current_epoch"],
        description: json["description"],
        finished: json["finished"],
        globalAcceptanceRate: json["global_acceptance_rate"].toDouble(),
        lastUpdated: json["last_updated"],
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
        "activated": activated,
        "active": active,
        "bit": bit,
        "current_epoch": currentEpoch,
        "description": description,
        "finished": finished,
        "global_acceptance_rate": globalAcceptanceRate,
        "last_updated": lastUpdated,
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
  Blockchain(
      {required this.blockchain,
      required this.reverted,
      required this.totalEpochs});

  final List<int?> reverted;
  final int totalEpochs;
  final List<BlockchainInfo> blockchain;

  factory Blockchain.fromJson(Map<String, dynamic> data) {
    return Blockchain(
        blockchain: List<BlockchainInfo>.from(
            data['blockchain'].map((e) => BlockchainInfo.fromJson(e))),
        reverted: List<int?>.from(data["reverted"]),
        totalEpochs: data["total_epochs"]);
  }
}

class BlockchainInfo {
  BlockchainInfo(
      {required this.hash,
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

  final String hash;
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

  factory BlockchainInfo.fromJson(Map<String, dynamic> data) {
    return BlockchainInfo(
        hash: data["hash"],
        minerAddress: data["miner"],
        valueTransferCount: data["value_transfers"],
        dataRequestCount: data["data_requests"],
        commitCount: data["commits"],
        revealCount: data["reveals"],
        tallyCount: data["tallies"],
        fee: data["fees"],
        epoch: data["epoch"],
        timestamp: data["timestamp"],
        confirmed: data["confirmed"]);
  }
}

class HashInfo {
  HashInfo({
    required this.txnHash,
    required this.status,
    required this.type,
    required this.txnTime,
    required this.blockHash,
  });

  final String txnHash;
  final TxStatusLabel status;
  final TransactionType type;
  final int txnTime;
  final dynamic blockHash;

  factory HashInfo.fromRawJson(String str) =>
      HashInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  void printDebug() {
    print('HashInfo');
    print('  Transaction Hash: $txnHash');
    print('  status: $status');
    print('  type: $type');
    print('  time: $txnTime');
    print('  Block Hash: $blockHash');
  }

  factory HashInfo.fromJson(Map<String, dynamic> json) => HashInfo(
        txnHash: json["txn_hash"],
        status: json["status"],
        type: json["type"],
        txnTime: json["txn_time"],
        blockHash: json["block_hash"],
      );

  Map<String, dynamic> jsonMap() => {
        "txn_hash": txnHash,
        "status": status,
        "type": type,
        "txn_time": txnTime,
        "block_hash": blockHash,
      };
}

class PrioritiesEstimate {
  PrioritiesEstimate({
    // required this.drtStinky,
    // required this.drtLow,
    // required this.drtMedium,
    // required this.drtHigh,
    // required this.drtOpulent,
    required this.vttStinky,
    required this.vttLow,
    required this.vttMedium,
    required this.vttHigh,
    required this.vttOpulent,
  });

  // final PriorityEstimate drtStinky;
  // final PriorityEstimate drtLow;
  // final PriorityEstimate drtMedium;
  // final PriorityEstimate drtHigh;
  // final PriorityEstimate drtOpulent;
  final PriorityEstimate vttStinky;
  final PriorityEstimate vttLow;
  final PriorityEstimate vttMedium;
  final PriorityEstimate vttHigh;
  final PriorityEstimate vttOpulent;

  factory PrioritiesEstimate.fromRawJson(String str) =>
      PrioritiesEstimate.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory PrioritiesEstimate.fromJson(Map<String, dynamic> json) {
    return PrioritiesEstimate(
        // drtStinky: PriorityEstimate.fromJson(json["drt_stinky"]),
        // drtLow: PriorityEstimate.fromJson(json["drt_low"]),
        // drtMedium: PriorityEstimate.fromJson(json["drt_medium"]),
        // drtHigh: PriorityEstimate.fromJson(json["drt_high"]),
        // drtOpulent: PriorityEstimate.fromJson(json["drt_opulent"]),
        vttStinky: PriorityEstimate.fromJson(json["vtt_stinky"]),
        vttLow: PriorityEstimate.fromJson(json["vtt_low"]),
        vttMedium: PriorityEstimate.fromJson(json["vtt_medium"]),
        vttHigh: PriorityEstimate.fromJson(json["vtt_high"]),
        vttOpulent: PriorityEstimate.fromJson(json["vtt_opulent"]));
  }

  Map<String, PriorityEstimate> jsonMap() => {
        // "drt_stinky": drtStinky,
        // "drt_low": drtLow,
        // "drt_medium": drtMedium,
        // "drt_high": drtHigh,
        // "drt_opulent": drtOpulent,
        "vtt_stinky": vttStinky,
        "vtt_low": vttLow,
        "vtt_medium": vttMedium,
        "vtt_high": vttHigh,
        "vtt_opulent": vttOpulent,
      };
}

class PriorityEstimate {
  PriorityEstimate({
    required this.priority,
    required this.timeToBlock,
  });

  final double priority;
  final int timeToBlock;

  factory PriorityEstimate.fromJson(Map<String, dynamic> json) =>
      PriorityEstimate(
        priority: json["priority"],
        timeToBlock: json["time_to_block"],
      );

  Map<String, dynamic> jsonMap() => {
        "priority": priority,
        "time_to_block": timeToBlock,
      };
}

class Mempool {
  Mempool({
    required this.timestamp,
    required this.fee,
    required this.amount,
  });

  final int timestamp;
  final List<int> fee;
  final List<int> amount;

  factory Mempool.fromJson(Map<String, dynamic> json) => Mempool(
        timestamp: json["timestamp"],
        fee: json["fee"],
        amount: json["amount"],
      );

  Map<String, dynamic> jsonMap() => {
        "timestamp": timestamp,
        "fee": fee,
        "amount": amount,
      };
}
