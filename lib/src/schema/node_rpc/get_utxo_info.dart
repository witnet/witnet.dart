import 'dart:convert' show json;

import '../input.dart' show Input;
import '../output_pointer.dart' show OutputPointer;
import 'package:witnet/data_structures.dart' show Utxo;
class UtxoInfo {
  UtxoInfo({
    required this.collateralMin,
    required this.utxos,
  });

  int collateralMin;
  List<Utxo> utxos;

  factory UtxoInfo.fromRawJson(String str) =>
      UtxoInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UtxoInfo.fromJson(Map<String, dynamic> json) => UtxoInfo(
        collateralMin: json["collateral_min"],
        utxos: List<Utxo>.from(json["utxos"].map((x) => Utxo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "collateral_min": collateralMin,
        "utxos": List<dynamic>.from(utxos.map((x) => x.toJson())),
      };
}

