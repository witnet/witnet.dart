import 'dart:convert' show json;

import 'keyed_signature.dart' show KeyedSignature;
import 'value_transfer_body.dart' show VTTransactionBody;
import 'package:witnet/utils.dart' show bytesToHex;


class VTTransaction {
  VTTransaction({
    required this.body,
    required this.signatures,
  });

  VTTransactionBody body;
  List<KeyedSignature> signatures;

  factory VTTransaction.fromRawJson(String str) =>
      VTTransaction.fromJson(json.decode(str));

  String rawJson({bool asHex=false}) => json.encode(jsonMap(asHex: asHex));

  factory VTTransaction.fromJson(Map<String, dynamic> json) => VTTransaction(
        body: VTTransactionBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) {
      return {
        "transaction": {
        "ValueTransfer": {
          "body": body.jsonMap(),
          "signatures": List<dynamic>.from(
              signatures.map((x) => x.jsonMap(asHex: asHex))),
        },
      }
    };
  }

  String get transactionID => bytesToHex(body.hash);

  int get weight => body.weight;

}
