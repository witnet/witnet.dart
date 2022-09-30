part of 'schema.dart';


class VrfProof {
  VrfProof({
    required this.proof,
    required this.publicKey,
  });

  List<int> proof;
  PublicKey publicKey;

  factory VrfProof.fromRawJson(String str) =>
      VrfProof.fromJson(json.decode(str));

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory VrfProof.fromJson(Map<String, dynamic> json) => VrfProof(
        proof: List<int>.from(json["proof"].map((x) => x)),
        publicKey: PublicKey.fromJson(json["public_key"]),
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
    "proof": (asHex) ? bytesToHex(Uint8List.fromList(proof)) : List<dynamic>.from(proof.map((x) => x)),
    "public_key": publicKey.jsonMap(asHex: asHex),
  };

  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, LENGTH_DELIMITED, Uint8List.fromList(proof)),
      pbField(2, LENGTH_DELIMITED, publicKey.pbBytes),
    ]);
  }
}
