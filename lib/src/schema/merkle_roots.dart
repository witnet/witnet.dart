import 'dart:convert' show json;

class MerkleRoots {
  MerkleRoots({
    required this.commitHashMerkleRoot,
    required this.drHashMerkleRoot,
    required this.mintHash,
    required this.revealHashMerkleRoot,
    required this.tallyHashMerkleRoot,
    required this.vtHashMerkleRoot,
  });

  final String commitHashMerkleRoot;
  final String drHashMerkleRoot;
  final String mintHash;
  final String revealHashMerkleRoot;
  final String tallyHashMerkleRoot;
  final String vtHashMerkleRoot;

  factory MerkleRoots.fromRawJson(String str) =>
      MerkleRoots.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MerkleRoots.fromJson(Map<String, dynamic> json) => MerkleRoots(
        commitHashMerkleRoot: json["commit_hash_merkle_root"],
        drHashMerkleRoot: json["dr_hash_merkle_root"],
        mintHash: json["mint_hash"],
        revealHashMerkleRoot: json["reveal_hash_merkle_root"],
        tallyHashMerkleRoot: json["tally_hash_merkle_root"],
        vtHashMerkleRoot: json["vt_hash_merkle_root"],
      );

  Map<String, dynamic> toJson() => {
        "commit_hash_merkle_root": commitHashMerkleRoot,
        "dr_hash_merkle_root": drHashMerkleRoot,
        "mint_hash": mintHash,
        "reveal_hash_merkle_root": revealHashMerkleRoot,
        "tally_hash_merkle_root": tallyHashMerkleRoot,
        "vt_hash_merkle_root": vtHashMerkleRoot,
      };
}
