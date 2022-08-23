part of 'schema.dart';

class Bn256PublicKey {
  Bn256PublicKey({
    required this.publicKey,
  });

  List<int> publicKey;

  factory Bn256PublicKey.fromRawJson(String str) =>
      Bn256PublicKey.fromJson(json.decode(str));

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory Bn256PublicKey.fromJson(Map<String, dynamic> json) => Bn256PublicKey(
        publicKey: List<int>.from(json["public_key"].map((x) => x)),
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "public_key": (asHex)
            ? bytesToHex(Uint8List.fromList(publicKey))
            : List<dynamic>.from(publicKey.map((x) => x)),
      };
}
