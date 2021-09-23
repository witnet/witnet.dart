

import 'dart:convert' show json;
import 'dart:typed_data' show Uint8List;

import 'package:witnet/radon.dart';

import 'value_transfer_output.dart' show ValueTransferOutput;
import 'public_key_hash.dart' show PublicKeyHash;
import 'hash.dart' show Hash;


class TallyTransaction{

  TallyTransaction({
    required this.drPointer,
    required this.tally,
    required this.outputs,
    required this.outOfConsensus,
    required this.errorCommitters
  });

  final Hash drPointer;
  final List<PublicKeyHash> errorCommitters;
  final List<PublicKeyHash> outOfConsensus;
  final List<ValueTransferOutput> outputs;
  final Uint8List tally;

  factory TallyTransaction.fromRawJson(String str) => TallyTransaction.fromJson(json.decode(str));
  dynamic get decodeTally => cborToRad(tally.toList());

  String toRawJson() => json.encode(jsonMap);
  factory TallyTransaction.fromJson(Map<String, dynamic> json) => TallyTransaction(
    drPointer: Hash.fromString(json["dr_pointer"]),
    outputs: List<ValueTransferOutput>.from(json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
    outOfConsensus: List<PublicKeyHash>.from(json["out_of_consensus"].map((x) => PublicKeyHash.fromAddress(x))),
    errorCommitters: List<PublicKeyHash>.from(json["error_committers"].map((x) => PublicKeyHash.fromAddress(x))),
    tally: Uint8List.fromList(List<int>.from(json["tally"].map((x) => x))),
  );

  Map<String, dynamic> get jsonMap => {
    "dr_pointer": drPointer,
    "error_committers": List<dynamic>.from(errorCommitters.map((x) => x.address)),
    "out_of_consensus": List<dynamic>.from(outOfConsensus.map((x) => x.address)),
    "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap)),
    "tally": tally.toList(),
  };

}