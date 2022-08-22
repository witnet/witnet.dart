part of 'schema.dart';

class CommitTransaction {
  CommitTransaction({
    required this.body,
    required this.signatures,
  });

  CommitBody body;
  List<KeyedSignature> signatures;

  factory CommitTransaction.fromRawJson(String str) => CommitTransaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory CommitTransaction.fromJson(Map<String, dynamic> json) => CommitTransaction(
        body: CommitBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
        "body": body.jsonMap(asHex: asHex),
        "signatures": List<dynamic>.from(signatures.map((x) => x.jsonMap(asHex: asHex))),
      };
}
