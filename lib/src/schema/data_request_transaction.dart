import 'dart:convert' show json;

import 'package:witnet/utils.dart' show bytesToHex;
import 'keyed_signature.dart' show KeyedSignature;
import 'data_request_body.dart' show DRTransactionBody;

class DRTransaction {
  DRTransaction({
    required this.body,
    required this.signatures,
  });

  DRTransactionBody body;
  List<KeyedSignature> signatures;

  factory DRTransaction.fromRawJson(String str) =>
      DRTransaction.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap);

  factory DRTransaction.fromJson(Map<String, dynamic> json) =>
      DRTransaction(
        body: DRTransactionBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  Map<String, dynamic> get jsonMap => {
    "DataRequest": {
      "body": body.jsonMap,
      "signatures": List<dynamic>.from(signatures.map((x) => x.jsonMap)),
    }
  };

  String get transactionID => bytesToHex(body.hash);
}
