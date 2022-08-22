part of 'schema.dart';

class Beacon {
  Beacon({
    required this.checkpoint,
    required this.hashPrevBlock,
  });

  final int checkpoint;
  final String hashPrevBlock;

  factory Beacon.fromRawJson(String str) => Beacon.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory Beacon.fromJson(Map<String, dynamic> json) => Beacon(
        checkpoint: json["checkpoint"],
        hashPrevBlock: json["hashPrevBlock"],
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
    "checkpoint": checkpoint,
    "hashPrevBlock": (asHex) ? hashPrevBlock : hexToBytes(hashPrevBlock),
  };
  
  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, VARINT, checkpoint),
      pbField(2, LENGTH_DELIMITED, stringToBytes(hashPrevBlock)),
    ]);
  }


}
