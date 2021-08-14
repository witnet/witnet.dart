import 'dart:convert' show json;
import 'commit_body.dart' show CommitBody;
import 'keyed_signature.dart' show KeyedSignature;

class Commit {
  Commit({
    required this.body,
    required this.signatures,
  });

  CommitBody body;
  List<KeyedSignature> signatures;

  factory Commit.fromRawJson(String str) => Commit.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap);

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        body: CommitBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  Map<String, dynamic> get jsonMap => {
        "body": body.jsonMap,
        "signatures": List<dynamic>.from(signatures.map((x) => x.jsonMap)),
      };
}
