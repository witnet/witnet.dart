part of 'schema.dart';



class Transactions {
  Transactions({
    required this.commitTxns,
    required this.dataRequestTxns,
    required this.mint,
    required this.revealTxns,
    required this.tallyTxns,
    required this.valueTransferTxns,
  });

  final List<dynamic> commitTxns;
  final List<dynamic> dataRequestTxns;
  final MintTransaction mint;
  final List<dynamic> revealTxns;
  final List<dynamic> tallyTxns;
  final List<VTTransaction> valueTransferTxns;

  factory Transactions.fromRawJson(String str) =>
      Transactions.fromJson(json.decode(str));

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        commitTxns: List<dynamic>.from(json["commit_txns"].map((x) => x)),
        dataRequestTxns:
            List<dynamic>.from(json["data_request_txns"].map((x) => x)),
        mint: MintTransaction.fromJson(json["mint"]),
        revealTxns: List<dynamic>.from(json["reveal_txns"].map((x) => x)),
        tallyTxns: List<dynamic>.from(json["tally_txns"].map((x) => x)),
        valueTransferTxns:
            List<VTTransaction>.from(json["value_transfer_txns"].map((x) => VTTransaction.fromJson(x))),
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
    "commit_txns": List<dynamic>.from(commitTxns.map((x) => x)),
    "data_request_txns": List<dynamic>.from(dataRequestTxns.map((x) => x)),
    "mint": mint.jsonMap(asHex: asHex),
    "reveal_txns": List<dynamic>.from(revealTxns.map((x) => x)),
    "tally_txns": List<dynamic>.from(tallyTxns.map((x) => x)),
    "value_transfer_txns":
      List<dynamic>.from(valueTransferTxns.map((x) => x.jsonMap(asHex: asHex))),
  };

  Uint8List get pbBytes {
    Uint8List vttBytes = concatBytes(List<Uint8List>.from(valueTransferTxns.map((e) => pbField(2, LENGTH_DELIMITED, e.pbBytes))));
    Uint8List drBytes = concatBytes(List<Uint8List>.from(dataRequestTxns.map((e) => pbField(3, LENGTH_DELIMITED, e.pbBytes))));
    Uint8List commitBytes = concatBytes(List<Uint8List>.from(commitTxns.map((e) => pbField(4, LENGTH_DELIMITED, e.pbBytes))));
    Uint8List revealBytes = concatBytes(List<Uint8List>.from(revealTxns.map((e) => pbField(5, LENGTH_DELIMITED, e.pbBytes))));
    Uint8List tallyBytes = concatBytes(List<Uint8List>.from(tallyTxns.map((e) => pbField(6, LENGTH_DELIMITED, e.pbBytes))));

    return concatBytes([
      pbField(1, LENGTH_DELIMITED, mint.pbBytes),
      vttBytes,
      drBytes,
      commitBytes,
      revealBytes,
      tallyBytes,
    ]);
  }
}
