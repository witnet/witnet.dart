import 'dart:convert';
import 'public_key.dart';
import 'signature.dart';

class KeyedSignature {
  KeyedSignature({
    required this.publicKey,
    required this.signature
  });
  PublicKey publicKey;
  Signature signature;

  factory KeyedSignature.fromRawJson(String str) => KeyedSignature.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap);

  factory KeyedSignature.fromJson(Map<String, dynamic> json) => KeyedSignature(
    publicKey: PublicKey.fromJson(json["public_key"]),
    signature: Signature.fromJson(json["signature"]),
  );

  Map<String, dynamic> get jsonMap => {
    "public_key": publicKey.jsonMap,
    "signature": signature.jsonMap,
  };
}