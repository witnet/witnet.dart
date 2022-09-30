part of 'schema.dart';


class KeyedSignature {
  KeyedSignature({required this.publicKey, required this.signature});

  PublicKey publicKey;
  Signature signature;

  factory KeyedSignature.fromRawJson(String str) =>
      KeyedSignature.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap());

  factory KeyedSignature.fromJson(Map<String, dynamic> json) => KeyedSignature(
        publicKey: PublicKey.fromJson(json["public_key"]),
        signature: Signature.fromJson(json["signature"]),
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) {
    return {
      "public_key": publicKey.jsonMap(asHex: asHex),
      "signature": signature.jsonMap(asHex: asHex),
    };
  }

  Uint8List get pbBytes {

    return concatBytes([
      pbField(1, LENGTH_DELIMITED, publicKey.pbBytes)
    ]);
  }
}
