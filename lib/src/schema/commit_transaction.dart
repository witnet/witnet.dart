import 'dart:convert';
import 'commit_body.dart';
import 'keyed_signature.dart';

class Commit {
  Commit({
    this.body,
    this.signatures,
  });

  CommitBody body;
  List<KeyedSignature> signatures;

  factory Commit.fromRawJson(String str) => Commit.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap);

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
    body: CommitBody.fromJson(json["body"]),
    signatures: List<KeyedSignature>.from(json["signatures"].map((x) => KeyedSignature.fromJson(x))),
  );

  Map<String, dynamic> get jsonMap => {
    "body": body.jsonMap,
    "signatures": List<dynamic>.from(signatures.map((x) => x.jsonMap)),
  };
}