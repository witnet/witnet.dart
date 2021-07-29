import 'dart:convert';

import '../transaction.dart';

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

  factory TransactionResponse.fromRawJson(String str) => TransactionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
    blockHash: json["blockHash"],
    confirmed: json["confirmed"],
    transaction: Transaction.fromJson(json["transaction"]),
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "blockHash": blockHash,
    "confirmed": confirmed,
    "transaction": transaction.toJson(),
    "weight": weight,
  };
}
