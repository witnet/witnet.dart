part of 'schema.dart';

class BlockHeader {
  BlockHeader({
    required this.beacon,
    required this.bn256PublicKey,
    required this.merkleRoots,
    required this.proof,
    required this.signals,
  });

  final Beacon beacon;
  final Bn256PublicKey bn256PublicKey;
  final MerkleRoots merkleRoots;
  final BlockHeaderProof proof;
  final int signals;

  factory BlockHeader.fromRawJson(String str) =>
      BlockHeader.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory BlockHeader.fromJson(Map<String, dynamic> json) => BlockHeader(
        beacon: Beacon.fromJson(json["beacon"]),
        bn256PublicKey: Bn256PublicKey.fromJson(json["bn256_public_key"]),
        merkleRoots: MerkleRoots.fromJson(json["merkle_roots"]),
        proof: BlockHeaderProof.fromJson(json["proof"]),
        signals: json["signals"],
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
    "beacon": beacon.jsonMap(asHex: asHex),
    "bn256_public_key": bn256PublicKey.jsonMap(asHex: asHex),
    "merkle_roots": merkleRoots.jsonMap(asHex: asHex),
    "proof": proof.jsonMap(asHex: asHex),
    "signals": signals,
  };

  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, VARINT, signals),
      pbField(2, LENGTH_DELIMITED, beacon.pbBytes),
      pbField(3, LENGTH_DELIMITED, merkleRoots.pbBytes),
      pbField(4, LENGTH_DELIMITED, proof.pbBytes),
    ]);
  }
}

class BlockHeaderProof {
  BlockHeaderProof({
    required this.proof,
  });

  final VrfProof proof;

  factory BlockHeaderProof.fromRawJson(String str) =>
      BlockHeaderProof.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory BlockHeaderProof.fromJson(Map<String, dynamic> json) =>
      BlockHeaderProof(
        proof: VrfProof.fromJson(json["proof"]),
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
    "proof": proof.jsonMap(asHex: asHex),
  };
  
  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, LENGTH_DELIMITED, proof.pbBytes)
    ]);
  }
}

