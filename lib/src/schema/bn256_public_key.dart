import 'dart:convert';

class Bn256PublicKey {
  Bn256PublicKey({
    required this.publicKey,
  });

  List<int> publicKey;

  factory Bn256PublicKey.fromRawJson(String str) =>
      Bn256PublicKey.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bn256PublicKey.fromJson(Map<String, dynamic> json) => Bn256PublicKey(
        publicKey: List<int>.from(json["public_key"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "public_key": List<dynamic>.from(publicKey.map((x) => x)),
      };
}
