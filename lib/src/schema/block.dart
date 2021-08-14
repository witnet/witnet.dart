import 'dart:convert' show json;

import 'block_header.dart' show BlockHeader;
import 'public_key.dart' show PublicKey;
import 'signature.dart' show Signature;
import 'transactions.dart' show Transactions;
import 'transaction_hashes.dart' show TransactionsHashes;

class Block {
  Block({
    required this.blockHeader,
    required this.blockSig,
    required this.confirmed,
    required this.txns,
    required this.txnsHashes,
  });

  final BlockHeader blockHeader;
  final BlockSig blockSig;
  final bool confirmed;
  final Transactions txns;
  final TransactionsHashes txnsHashes;

  factory Block.fromRawJson(String str) => Block.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Block.fromJson(Map<String, dynamic> json) => Block(
        blockHeader: BlockHeader.fromJson(json["block_header"]),
        blockSig: BlockSig.fromJson(json["block_sig"]),
        confirmed: json["confirmed"],
        txns: Transactions.fromJson(json["txns"]),
        txnsHashes: TransactionsHashes.fromJson(json["txns_hashes"]),
      );

  Map<String, dynamic> toJson() => {
        "block_header": blockHeader.toJson(),
        "block_sig": blockSig.toJson(),
        "confirmed": confirmed,
        "txns": txns.toJson(),
        "txns_hashes": txnsHashes.toJson(),
      };
}

class BlockSig {
  BlockSig({
    required this.publicKey,
    required this.signature,
  });

  final PublicKey publicKey;
  final Signature signature;

  factory BlockSig.fromRawJson(String str) =>
      BlockSig.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockSig.fromJson(Map<String, dynamic> json) => BlockSig(
        publicKey: PublicKey.fromJson(json["public_key"]),
        signature: Signature.fromJson(json["signature"]),
      );

  Map<String, dynamic> toJson() => {
        "public_key": publicKey.jsonMap,
        "signature": signature.jsonMap,
      };
}
