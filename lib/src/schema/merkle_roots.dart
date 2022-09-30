part of 'schema.dart';

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

  String toRawJson() => json.encode(jsonMap());

  factory MerkleRoots.fromJson(Map<String, dynamic> json) => MerkleRoots(
        commitHashMerkleRoot: json["commit_hash_merkle_root"],
        drHashMerkleRoot: json["dr_hash_merkle_root"],
        mintHash: json["mint_hash"],
        revealHashMerkleRoot: json["reveal_hash_merkle_root"],
        tallyHashMerkleRoot: json["tally_hash_merkle_root"],
        vtHashMerkleRoot: json["vt_hash_merkle_root"],
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
        "commit_hash_merkle_root": (asHex) ? commitHashMerkleRoot : stringToBytes(commitHashMerkleRoot),
        "dr_hash_merkle_root": drHashMerkleRoot,
        "mint_hash": mintHash,
        "reveal_hash_merkle_root": revealHashMerkleRoot,
        "tally_hash_merkle_root": tallyHashMerkleRoot,
        "vt_hash_merkle_root": vtHashMerkleRoot,
      };

  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, LENGTH_DELIMITED, stringToBytes(mintHash)),
      pbField(2, LENGTH_DELIMITED, stringToBytes(vtHashMerkleRoot)),
      pbField(3, LENGTH_DELIMITED, stringToBytes(drHashMerkleRoot)),
      pbField(4, LENGTH_DELIMITED, stringToBytes(commitHashMerkleRoot)),
      pbField(5, LENGTH_DELIMITED, stringToBytes(revealHashMerkleRoot)),
      pbField(6, LENGTH_DELIMITED, stringToBytes(tallyHashMerkleRoot)),
    ]);
  }
}
