import 'dart:convert';
class ChainBeacon {
  ChainBeacon({
    this.checkpoint,
    this.hashPrevBlock,
  });

  final int checkpoint;
  final String hashPrevBlock;

  factory ChainBeacon.fromRawJson(String str) => ChainBeacon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChainBeacon.fromJson(Map<String, dynamic> json) => ChainBeacon(
    checkpoint: json["checkpoint"],
    hashPrevBlock: json["hashPrevBlock"],
  );

  Map<String, dynamic> toJson() => {
    "checkpoint": checkpoint,
    "hashPrevBlock": hashPrevBlock,
  };
}
