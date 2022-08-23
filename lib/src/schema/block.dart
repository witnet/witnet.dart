part of 'schema.dart';

class Block {
  Block({
    required this.blockHeader,
    required this.blockSig,
    required this.confirmed,
    required this.txns,
    required this.txnsHashes,
  });

  final BlockHeader blockHeader;
  final KeyedSignature blockSig;
  final bool confirmed;
  final Transactions txns;
  final TransactionsHashes txnsHashes;

  factory Block.fromRawJson(String str) => Block.fromJson(json.decode(str));

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory Block.fromJson(Map<String, dynamic> json) => Block(
    blockHeader: BlockHeader.fromJson(json["block_header"]),
    blockSig: KeyedSignature.fromJson(json["block_sig"]),
    confirmed: json["confirmed"],
    txns: Transactions.fromJson(json["txns"]),
    txnsHashes: TransactionsHashes.fromJson(json["txns_hashes"]),
  );

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
    "block_header": blockHeader.jsonMap(asHex: asHex),
    "block_sig": blockSig.jsonMap(asHex: asHex),
    "confirmed": confirmed,
    "txns": txns.jsonMap(asHex: asHex),
    "txns_hashes": txnsHashes.jsonMap(asHex: asHex),
  };

  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, LENGTH_DELIMITED, blockHeader.pbBytes),
      pbField(2, LENGTH_DELIMITED, blockSig.pbBytes),
      pbField(3, LENGTH_DELIMITED, txns.pbBytes),
    ]);
  }

}

