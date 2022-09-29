part of 'schema.dart';

class TransactionsHashes {
  TransactionsHashes({
    required this.commit,
    required this.dataRequest,
    required this.mint,
    required this.reveal,
    required this.tally,
    required this.valueTransfer,
  });

  final List<dynamic> commit;
  final List<dynamic> dataRequest;
  final String mint;
  final List<dynamic> reveal;
  final List<dynamic> tally;
  final List<dynamic> valueTransfer;

  factory TransactionsHashes.fromRawJson(String str) =>
      TransactionsHashes.fromJson(json.decode(str));

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory TransactionsHashes.fromJson(Map<String, dynamic> json) =>
      TransactionsHashes(
        commit: List<dynamic>.from(json["commit"].map((x) => x)),
        dataRequest: List<dynamic>.from(json["data_request"].map((x) => x)),
        mint: json["mint"],
        reveal: List<dynamic>.from(json["reveal"].map((x) => x)),
        tally: List<dynamic>.from(json["tally"].map((x) => x)),
        valueTransfer: List<dynamic>.from(json["value_transfer"].map((x) => x)),
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "commit": List<dynamic>.from(commit.map((x) => x)),
        "data_request": List<dynamic>.from(dataRequest.map((x) => x)),
        "mint": mint,
        "reveal": List<dynamic>.from(reveal.map((x) => x)),
        "tally": List<dynamic>.from(tally.map((x) => x)),
        "value_transfer": List<dynamic>.from(valueTransfer.map((x) => x)),
      };
}
