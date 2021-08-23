import 'dart:convert' show json;
import 'commit_body.dart' show CommitBody;
import 'keyed_signature.dart' show KeyedSignature;

class CommitTransaction {
  CommitTransaction({
    required this.body,
    required this.signatures,
  });

  CommitBody body;
  List<KeyedSignature> signatures;

  factory CommitTransaction.fromRawJson(String str) => CommitTransaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap);

  factory CommitTransaction.fromJson(Map<String, dynamic> json) => CommitTransaction(
        body: CommitBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  Map<String, dynamic> get jsonMap => {
        "body": body.jsonMap,
        "signatures": List<dynamic>.from(signatures.map((x) => x.jsonMap)),
      };
}
