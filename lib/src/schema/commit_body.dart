

part of 'schema.dart';

class CommitBody {
  CommitBody({
    required this.bn256PublicKey,
    required this.collateral,
    required this.commitment,
    required this.drPointer,
    required this.outputs,
    required this.proof,
  });

  Bn256PublicKey? bn256PublicKey;
  List<Input> collateral;
  Hash commitment;
  Hash drPointer;
  List<ValueTransferOutput> outputs;
  DataRequestEligibilityClaim proof;

  factory CommitBody.fromRawJson(String str) =>
      CommitBody.fromJson(json.decode(str));

  String get rawJson => json.encode(jsonMap());

  factory CommitBody.fromJson(Map<String, dynamic> json) => CommitBody(
        bn256PublicKey: json["bn256_public_key"] == null
            ? null
            : Bn256PublicKey.fromJson(json["bn256_public_key"]),
        collateral:
            List<Input>.from(json["collateral"].map((x) => Input.fromJson(x))),
        commitment: Hash.fromString(json["commitment"]),
        drPointer: Hash.fromString(json["dr_pointer"]),
        outputs: List<ValueTransferOutput>.from(
            json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
        proof: DataRequestEligibilityClaim.fromJson(json["proof"]),
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
        "bn256_public_key":
            bn256PublicKey == null ? null : bn256PublicKey!.jsonMap(),
        "collateral": List<dynamic>.from(collateral.map((x) => x.jsonMap())),
        "commitment": commitment.toString(),
        "dr_pointer": drPointer.toString(),
        "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap())),
        "proof": proof.jsonMap(),
      };
}
