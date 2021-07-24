import 'dart:convert';
import 'bn256_public_key.dart';
import 'value_transfer_output.dart';
import 'data_request_eligibility_claim.dart';
import 'hash.dart';
import 'input.dart';
class CommitBody {
  CommitBody({
    this.bn256PublicKey,
    this.collateral,
    this.commitment,
    this.drPointer,
    this.outputs,
    this.proof,
  });

  Bn256PublicKey bn256PublicKey;
  List<Input> collateral;
  Hash commitment;
  Hash drPointer;
  List<ValueTransferOutput> outputs;
  DataRequestEligibilityClaim proof;

  factory CommitBody.fromRawJson(String str) => CommitBody.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap);

  factory CommitBody.fromJson(Map<String, dynamic> json) => CommitBody(
    bn256PublicKey: json["bn256_public_key"] == null ? null : Bn256PublicKey.fromJson(json["bn256_public_key"]),
    collateral: List<Input>.from(json["collateral"].map((x) => Input.fromJson(x))),
    commitment: Hash.fromString(json["commitment"]),
    drPointer: Hash.fromString(json["dr_pointer"]),
    outputs: List<ValueTransferOutput>.from(json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
    proof: DataRequestEligibilityClaim.fromJson(json["proof"]),
  );

  Map<String, dynamic> get jsonMap => {
    "bn256_public_key": bn256PublicKey == null ? null : bn256PublicKey.toJson(),
    "collateral": List<dynamic>.from(collateral.map((x) => x.jsonMap)),
    "commitment": commitment.toString(),
    "dr_pointer": drPointer.toString(),
    "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap)),
    "proof": proof.jsonMap,
  };
}