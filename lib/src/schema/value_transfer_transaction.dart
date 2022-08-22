part of 'schema.dart';


class VTTransaction {
  VTTransaction({
    required this.body,
    required this.signatures,
  });

  VTTransactionBody body;
  List<KeyedSignature> signatures;

  factory VTTransaction.fromRawJson(String str) =>
      VTTransaction.fromJson(json.decode(str));

  String rawJson({bool asHex=false}) => json.encode(jsonMap(asHex: asHex));

  factory VTTransaction.fromJson(Map<String, dynamic> json) => VTTransaction(
        body: VTTransactionBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) {
      return {
          "body": body.jsonMap(),
          "signatures": List<dynamic>.from(
              signatures.map((x) => x.jsonMap(asHex: asHex))),
    };
  }

  String get transactionID => bytesToHex(body.hash);

  int get weight => body.weight;

  Uint8List get pbBytes {
    final sigBytes = concatBytes(List<Uint8List>.from(signatures.map((e) =>  pbField(1, LENGTH_DELIMITED, e.pbBytes))));

    return concatBytes([
      pbField(1, LENGTH_DELIMITED, body.pbBytes),
      sigBytes
    ]);


  }

}
