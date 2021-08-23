

import 'dart:convert' show json;
import 'dart:typed_data';

import 'package:witnet/schema.dart';

class ExplorerResponse {

}


class ValueTransferTxn{
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
  factory ValueTransferTxn.fromRawJson(String str) => ValueTransferTxn.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValueTransferTxn.fromJson(Map<String, dynamic> json) => ValueTransferTxn(
    blockHash: json["block_hash"],
    fee: json["fee"],
    inputs: List<List<dynamic>>.from(json["inputs"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    outputs: List<List<dynamic>>.from(json["outputs"].map((x) => List<dynamic>.from(x.map((x) => x)))),
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
    "inputs": List<dynamic>.from(inputs.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "outputs": List<dynamic>.from(outputs.map((x) => List<dynamic>.from(x.map((x) => x)))),
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
    commitTxns: List<CommitTxn>.from(json["commit_txns"].map((x) => CommitTxn.fromJson(x))),
    dataRequestTxn: DataRequestTxn.fromJson(json["data_request_txn"]),
    revealTxns: List<RevealTxn>.from(json["reveal_txns"].map((x) => RevealTxn.fromJson(x))),
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

  factory CommitTxn.fromRawJson(String str) => CommitTxn.fromJson(json.decode(str));

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

  factory DataRequestTxn.fromRawJson(String str) => DataRequestTxn.fromJson(json.decode(str));

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
    retrieve: List<Retrieve>.from(json["retrieve"].map((x) => Retrieve.fromJson(x))),
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

  factory Retrieve.fromRawJson(String str) => Retrieve.fromJson(json.decode(str));

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

  factory RevealTxn.fromRawJson(String str) => RevealTxn.fromJson(json.decode(str));

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

  factory TallyTxn.fromRawJson(String str) => TallyTxn.fromJson(json.decode(str));

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
    latestBlocks: List<List<dynamic>>.from(json["latest_blocks"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    latestDataRequests: List<List<dynamic>>.from(json["latest_data_requests"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    latestValueTransfers: List<List<dynamic>>.from(json["latest_value_transfers"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    networkStats: NetworkStats.fromJson(json["network_stats"]),
    supplyInfo: SupplyInfo.fromJson(json["supply_info"]),
  );

  Map<String, dynamic> jsonMap() => {
    "last_updated": lastUpdated,
    "latest_blocks": List<dynamic>.from(latestBlocks.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "latest_data_requests": List<dynamic>.from(latestDataRequests.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "latest_value_transfers": List<dynamic>.from(latestValueTransfers.map((x) => List<dynamic>.from(x.map((x) => x)))),
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
    databaseLastConfirmed: List<dynamic>.from(json["database_last_confirmed"].map((x) => x)),
    databaseLastUnconfirmed: List<dynamic>.from(json["database_last_unconfirmed"].map((x) => x)),
    databaseMessage: json["database_message"],
    nodePool: NodePool.fromJson(json["node_pool"]),
    nodePoolMessage: json["node_pool_message"],
  );

  Map<String, dynamic> jsonMap() => {
    "database_last_confirmed": List<dynamic>.from(databaseLastConfirmed.map((x) => x)),
    "database_last_unconfirmed": List<dynamic>.from(databaseLastUnconfirmed.map((x) => x)),
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
    rollbacks: List<RollBack>.from(json["rollbacks"].map((rollback) => RollBack.fromList(rollback))),
    top100DrSolvers: List<DrSolver>.from(json["top_100_dr_solvers"].map((drSolver) => DrSolver.fromList(drSolver))),
    top100Miners: List<Miner>.from(json["top_100_miners"].map((miner) => Miner.fromList(miner))),
    uniqueDrSolvers: json["unique_dr_solvers"],
    uniqueMiners: json["unique_miners"],
  );

  Map<String, dynamic> jsonMap() => {
    "last_updated": lastUpdated,
    "rollbacks": List<dynamic>.from(rollbacks.map((rollback) => rollback.toList())),
    "top_100_dr_solvers": List<dynamic>.from(top100DrSolvers.map((drSolver) => drSolver.toList())),
    "top_100_miners": List<dynamic>.from(top100Miners.map((miner) => miner.toList())),
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

  factory DrSolver.fromList(List<dynamic> data){
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

  factory Miner.fromList(List<dynamic> data){
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

  factory RollBack.fromList(List<dynamic> data){
    return RollBack(
        timestamp: data[0],
        toEpoch: data[1],
        fromEpoch: data[2],
        blocksEffected: data[3]
    );
  }
  List<int> toList() => [timestamp,toEpoch,fromEpoch,blocksEffected];

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

  factory NetworkStats.fromRawJson(String str) => NetworkStats.fromJson(json.decode(str));

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

  factory SupplyInfo.fromRawJson(String str) => SupplyInfo.fromJson(json.decode(str));

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

  factory NodePool.fromRawJson(String str) => NodePool.fromJson(json.decode(str));

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

  factory ChainBeacon.fromRawJson(String str) => ChainBeacon.fromJson(json.decode(str));

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

  factory AddressBlocks.fromJson(Map<String, dynamic> data){
    return AddressBlocks(
        address: data['address'],
        blocks: List<BlockInfo>.from(data['blocks'].map((blockInfo) => BlockInfo.fromList(blockInfo))),
        numBlocksMinted: data['num_blocks_minted'],
        type: data['type']
    );
  }

  Map<String, dynamic> jsonMap(){
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

  factory AddressDetails.fromRawJson(String str) => AddressDetails.fromJson(json.decode(str));

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

  factory AddressDataRequestsSolved.fromRawJson(String str) => AddressDataRequestsSolved.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressDataRequestsSolved.fromJson(Map<String, dynamic> json) => AddressDataRequestsSolved(
    address: json["address"],
    dataRequestsSolved: List<DataRequestSolvedInfo>.from(json["data_requests_solved"].map((x) => DataRequestSolvedInfo.fromList(x))),
    numDataRequestsSolved: json["num_data_requests_solved"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "data_requests_solved": List<dynamic>.from(dataRequestsSolved.map((x) => x.tolist())),
    "num_data_requests_solved": numDataRequestsSolved,
    "type": type,
  };
}
class AddressValueTransfers {
  AddressValueTransfers({
    required this.address,
    required this.numValueTransfers,
    required this.type,
    required this.valueTransfers,
  });

  final String address;
  final int numValueTransfers;
  final String type;
  final List<List<dynamic>> valueTransfers;

  factory AddressValueTransfers.fromRawJson(String str) => AddressValueTransfers.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory AddressValueTransfers.fromJson(Map<String, dynamic> json) => AddressValueTransfers(
    address: json["address"],
    numValueTransfers: json["num_value_transfers"],
    type: json["type"],
    valueTransfers: List<List<dynamic>>.from(json["value_transfers"].map((x) => List<dynamic>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> jsonMap() => {
    "address": address,
    "num_value_transfers": numValueTransfers,
    "type": type,
    "value_transfers": List<dynamic>.from(valueTransfers.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
class ValueTransferInfo{



}

class BlockInfo{
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

  factory BlockInfo.fromList(List<dynamic> data){
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

  List<dynamic> toList(){
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
class DataRequestSolvedInfo{

  DataRequestSolvedInfo({
   required this.success,
   required this.transactionID,
   required this.timestamp,
   required this.collateral,
    required this.epoch,
   required this.result,
   required this.error,
   required this.liar
});

  final bool success;
  final String transactionID;
  final int timestamp;
  final int collateral;
  final int epoch;
  final DataRequestResult result;
  final bool error;
  final bool liar;

  factory DataRequestSolvedInfo.fromList(List<dynamic> data){
    print(data);
    var result = (data[5].runtimeType == String) ?
    DataRequestResult(accepted: false, value: '') :
    DataRequestResult.fromList(data[5]);

    return DataRequestSolvedInfo(
        success: data[0],
        transactionID: data[1],
        timestamp: data[2],
        collateral: data[3],
        epoch: data[4],
        result: result,
        error: data[6],
        liar: data[7]
    );
  }

  List<dynamic> tolist(){
    return [success, transactionID, timestamp, collateral, result, error, liar];
  }
}
class DataRequestResult{

  DataRequestResult({
    required this.accepted,
    required this.value,
});

  final bool accepted;
  final dynamic value;

  factory DataRequestResult.fromList(List<dynamic> data){
    return DataRequestResult(accepted: data[0], value: data[1]);
  }

  List<dynamic> toList(){
    return [accepted, value];
  }

}
