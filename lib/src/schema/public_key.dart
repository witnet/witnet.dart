import 'dart:convert';

class PublicKey {
  PublicKey({
    this.bytes,
    this.compressed,
  });
  List<int> bytes;
  int compressed;
  factory PublicKey.fromRawJson(String str) => PublicKey.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap);

  factory PublicKey.fromJson(Map<String, dynamic> json) => PublicKey(
    bytes: List<int>.from(json["bytes"].map((x) => x)),
    compressed: json["compressed"],
  );

  Map<String, dynamic> get jsonMap => {
    "bytes": List<dynamic>.from(bytes.map((x) => x)),
    "compressed": compressed,
  };
}