import 'dart:convert';
import 'package:witnet/schema.dart';

import 'mint.dart';

class Transactions {
  Transactions({
    required this.commitTxns,
    required this.dataRequestTxns,
    required this.mint,
    required this.revealTxns,
    required this.tallyTxns,
    required this.valueTransferTxns,
  });

  final List<dynamic> commitTxns;
  final List<dynamic> dataRequestTxns;
  final Mint mint;
  final List<dynamic> revealTxns;
  final List<dynamic> tallyTxns;
  final List<VTTransaction> valueTransferTxns;

  factory Transactions.fromRawJson(String str) =>
      Transactions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        commitTxns: List<dynamic>.from(json["commit_txns"].map((x) => x)),
        dataRequestTxns:
            List<dynamic>.from(json["data_request_txns"].map((x) => x)),
        mint: Mint.fromJson(json["mint"]),
        revealTxns: List<dynamic>.from(json["reveal_txns"].map((x) => x)),
        tallyTxns: List<dynamic>.from(json["tally_txns"].map((x) => x)),
        valueTransferTxns:
            List<VTTransaction>.from(json["value_transfer_txns"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "commit_txns": List<dynamic>.from(commitTxns.map((x) => x)),
        "data_request_txns": List<dynamic>.from(dataRequestTxns.map((x) => x)),
        "mint": mint.toJson(),
        "reveal_txns": List<dynamic>.from(revealTxns.map((x) => x)),
        "tally_txns": List<dynamic>.from(tallyTxns.map((x) => x)),
        "value_transfer_txns":
            List<dynamic>.from(valueTransferTxns.map((x) => x)),
      };
}
