import 'dart:convert';

import 'beacon.dart';
import 'bn256_public_key.dart';
import 'merkle_roots.dart';
import 'public_key.dart';

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

  String toRawJson() => json.encode(toJson());

  factory BlockHeader.fromJson(Map<String, dynamic> json) => BlockHeader(
        beacon: Beacon.fromJson(json["beacon"]),
        bn256PublicKey: Bn256PublicKey.fromJson(json["bn256_public_key"]),
        merkleRoots: MerkleRoots.fromJson(json["merkle_roots"]),
        proof: BlockHeaderProof.fromJson(json["proof"]),
        signals: json["signals"],
      );

  Map<String, dynamic> toJson() => {
        "beacon": beacon.toJson(),
        "bn256_public_key": bn256PublicKey.toJson(),
        "merkle_roots": merkleRoots.toJson(),
        "proof": proof.toJson(),
        "signals": signals,
      };
}

class BlockHeaderProof {
  BlockHeaderProof({
    required this.proof,
  });

  final ProofProof proof;

  factory BlockHeaderProof.fromRawJson(String str) =>
      BlockHeaderProof.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockHeaderProof.fromJson(Map<String, dynamic> json) =>
      BlockHeaderProof(
        proof: ProofProof.fromJson(json["proof"]),
      );

  Map<String, dynamic> toJson() => {
        "proof": proof.toJson(),
      };
}

class ProofProof {
  ProofProof({
    required this.proof,
    required this.publicKey,
  });

  final List<int> proof;
  final PublicKey publicKey;

  factory ProofProof.fromRawJson(String str) =>
      ProofProof.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProofProof.fromJson(Map<String, dynamic> json) => ProofProof(
        proof: List<int>.from(json["proof"].map((x) => x)),
        publicKey: PublicKey.fromJson(json["public_key"]),
      );

  Map<String, dynamic> toJson() => {
        "proof": List<dynamic>.from(proof.map((x) => x)),
        "public_key": publicKey.jsonMap,
      };
}
