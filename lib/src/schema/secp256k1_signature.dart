import 'dart:convert' show json;

import 'dart:typed_data' show Uint8List;

import 'package:witnet/src/utils/transformations/transformations.dart';

class Secp256k1Signature {
  Secp256k1Signature({
    required this.der,
  });

  List<int> der;

  factory Secp256k1Signature.fromRawJson(String str) =>
      Secp256k1Signature.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap);

  factory Secp256k1Signature.fromJson(Map<String, dynamic> json) =>
      Secp256k1Signature(
        der: List<int>.from(json["der"].map((x) => x)),
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) {
    List<int> _der = List<int>.from(der.map((x) => x));
    return {
      "der": (asHex) ? bytesToHex(Uint8List.fromList(_der)) : _der,
    };
  }

  Uint8List get pbBytes {
    throw Exception('Not Implemented');
  }
}
