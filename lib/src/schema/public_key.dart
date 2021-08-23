import 'dart:convert' show json;
import 'dart:typed_data';

import 'package:witnet/src/utils/transformations/transformations.dart';

class PublicKey {
  PublicKey({
    required this.bytes,
    required this.compressed,
  });

  List<int> bytes;
  int compressed;

  factory PublicKey.fromRawJson(String str) =>
      PublicKey.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap);

  factory PublicKey.fromJson(Map<String, dynamic> json) =>
      PublicKey(
        bytes: List<int>.from(json["bytes"].map((x) => x)),
        compressed: json["compressed"],
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) {
    return {
      "bytes": (asHex) ? bytesToHex(Uint8List.fromList(bytes)) : bytes,
      "compressed": compressed,
    };
  }
}
