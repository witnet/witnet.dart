// To parse this JSON data, do
//
//     final syncStatusResponse = syncStatusResponseFromJson(jsonString);

import 'dart:convert';
import 'chain_beacon.dart';
import 'node_response.dart';

class SyncStatus extends NodeResponse {
  SyncStatus({
    this.chainBeacon,
    this.currentEpoch,
    this.nodeState,
  });

  final ChainBeacon chainBeacon;
  final int currentEpoch;
  final String nodeState;

  factory SyncStatus.fromRawJson(String str) => SyncStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SyncStatus.fromJson(Map<String, dynamic> json) => SyncStatus(
    chainBeacon: ChainBeacon.fromJson(json["chain_beacon"]),
    currentEpoch: json["current_epoch"],
    nodeState: json["node_state"],
  );

  Map<String, dynamic> toJson() => {
    "chain_beacon": chainBeacon.toJson(),
    "current_epoch": currentEpoch,
    "node_state": nodeState,
  };
}
