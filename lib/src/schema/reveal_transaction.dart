import 'dart:convert' show json;
import 'keyed_signature.dart' show KeyedSignature;
import 'reveal_body.dart' show RevealBody;
class RevealTransaction {
  RevealTransaction({
    required this.body,
    required this.signatures,
  });

  RevealBody body;
  List<KeyedSignature> signatures;

  factory RevealTransaction.fromRawJson(String str) => RevealTransaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap);

  factory RevealTransaction.fromJson(Map<String, dynamic> json) => RevealTransaction(
    body: RevealBody.fromJson(json["body"]),
    signatures: List<KeyedSignature>.from(
        json["signatures"].map((x) => KeyedSignature.fromJson(x))),
  );

  Map<String, dynamic> get jsonMap => {
    "body": body.jsonMap,
    "signatures": List<dynamic>.from(signatures.map((x) => x.jsonMap)),
  };
}
