import 'dart:convert' show json;

class Beacon {
  Beacon({
    required this.checkpoint,
    required this.hashPrevBlock,
  });

  final int checkpoint;
  final String hashPrevBlock;

  factory Beacon.fromRawJson(String str) => Beacon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Beacon.fromJson(Map<String, dynamic> json) => Beacon(
        checkpoint: json["checkpoint"],
        hashPrevBlock: json["hashPrevBlock"],
      );

  Map<String, dynamic> toJson() => {
        "checkpoint": checkpoint,
        "hashPrevBlock": hashPrevBlock,
      };
}
