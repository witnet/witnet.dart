part of 'schema.dart';

class DRTransaction {
  DRTransaction({
    required this.body,
    required this.signatures,
  });

  DRTransactionBody body;
  List<KeyedSignature> signatures;

  factory DRTransaction.fromRawJson(String str) =>
      DRTransaction.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap());

  factory DRTransaction.fromJson(Map<String, dynamic> json) =>
      DRTransaction(
        body: DRTransactionBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  Map<String, dynamic> jsonMap([bool asHex = false]) {
    return {
      "DataRequest": {
        "body": body.jsonMap(asHex: asHex),
        "signatures": List<dynamic>.from(signatures.map((x) => x.jsonMap(asHex: asHex))),
      }
    };
  }

  String get transactionID => bytesToHex(body.hash);
}
