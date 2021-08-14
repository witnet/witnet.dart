import 'dart:convert' show json;

import 'package:witnet/node_rpc.dart' show SyncStatus;

class ExplorerStatus {
  ExplorerStatus({
    required this.databaseLastConfirmed,
    required this.databaseLastUnconfirmed,
    required this.databaseMessage,
    required this.syncStatus,
    required this.nodePoolMessage,
  });

  final List<dynamic> databaseLastConfirmed;
  final List<dynamic> databaseLastUnconfirmed;
  final String databaseMessage;
  final SyncStatus syncStatus;
  final String nodePoolMessage;

  factory ExplorerStatus.fromRawJson(String str) =>
      ExplorerStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExplorerStatus.fromJson(Map<String, dynamic> json) => ExplorerStatus(
        databaseLastConfirmed:
            List<dynamic>.from(json["database_last_confirmed"].map((x) => x)),
        databaseLastUnconfirmed:
            List<dynamic>.from(json["database_last_unconfirmed"].map((x) => x)),
        databaseMessage: json["database_message"],
        syncStatus: SyncStatus.fromJson(json["node_pool"]),
        nodePoolMessage: json["node_pool_message"],
      );

  Map<String, dynamic> toJson() => {
        "database_last_confirmed":
            List<dynamic>.from(databaseLastConfirmed.map((x) => x)),
        "database_last_unconfirmed":
            List<dynamic>.from(databaseLastUnconfirmed.map((x) => x)),
        "database_message": databaseMessage,
        "node_pool": syncStatus.toJson(),
        "node_pool_message": nodePoolMessage,
      };
}
