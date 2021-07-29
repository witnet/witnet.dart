import 'dart:convert';

import 'public_key.dart';

class VrfProof {
  VrfProof({
    required this.proof,
    required this.publicKey,
  });

  List<int> proof;
  PublicKey publicKey;

  factory VrfProof.fromRawJson(String str) => VrfProof.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap);

  factory VrfProof.fromJson(Map<String, dynamic> json) => VrfProof(
    proof: List<int>.from(json["proof"].map((x) => x)),
    publicKey: PublicKey.fromJson(json["public_key"]),
  );

  Map<String, dynamic> get jsonMap => {
    "proof": List<dynamic>.from(proof.map((x) => x)),
    "public_key": publicKey.jsonMap,
  };
}