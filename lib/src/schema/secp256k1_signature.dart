part of 'schema.dart';


class Secp256k1Signature {
  Secp256k1Signature({
    required this.der,
  });

  List<int> der;

  factory Secp256k1Signature.fromRawJson(String str) =>
      Secp256k1Signature.fromJson(json.decode(str));

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory Secp256k1Signature.fromJson(Map<String, dynamic> json) =>
      Secp256k1Signature(
        der: List<int>.from(json["der"].map((x) => x)),
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) {
    return {
      "der": (asHex)
          ? bytesToHex(Uint8List.fromList(List<int>.from(der.map((x) => x))))
          : List<int>.from(der.map((x) => x)),
    };
  }

  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, LENGTH_DELIMITED, der)
    ]);
  }
}
