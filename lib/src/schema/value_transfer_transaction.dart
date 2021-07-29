import 'dart:convert';

import '../utils/transformations/transformations.dart';

import 'keyed_signature.dart';
import 'value_transfer_body.dart';



class VTTransaction {

  VTTransaction({
    required this.body,
    required this.signatures,
  });

  VTTransactionBody body;
  List<KeyedSignature> signatures;

  factory VTTransaction.fromRawJson(String str) => VTTransaction.fromJson(json.decode(str));
  String get rawJson => json.encode(jsonMap);

  factory VTTransaction.fromJson(Map<String, dynamic> json) => VTTransaction(
    body: VTTransactionBody.fromJson(json["body"]),
    signatures: List<KeyedSignature>.from(json["signatures"].map((x) => KeyedSignature.fromJson(x))),
  );

  Map<String, dynamic> get jsonMap => {
    "ValueTransfer": {
      "body": body.toJson(),
      "signatures": List<dynamic>.from(signatures.map((x) => x.jsonMap)),
    },
  };

  String get transactionID => bytesToHex(body.hash);
  int get weight {
    return 0;
  }
}
