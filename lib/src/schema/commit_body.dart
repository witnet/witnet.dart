part of 'schema.dart';

class CommitBody extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'CommitTransactionBody',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..aOM<Hash>(1, 'drPointer', subBuilder: Hash.create)
      ..aOM<Hash>(2, 'commitment', subBuilder: Hash.create)
      ..aOM<DataRequestEligibilityClaim>(3, 'proof', subBuilder: DataRequestEligibilityClaim.create)
      ..pc<Input>(4, 'collateral', PbFieldType.PM, subBuilder: Input.create)
      ..pc<ValueTransferOutput>(5, 'outputs', PbFieldType.PM, subBuilder: ValueTransferOutput.create)
      ..aOM<Bn256PublicKey>(6, 'bn256PublicKey', subBuilder: Bn256PublicKey.create)
      ..hasRequiredFields = false;

  static CommitBody create() => CommitBody._();
  static PbList<CommitBody> createRepeated() => PbList<CommitBody>();
  static CommitBody getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<CommitBody>(create);
  static CommitBody? _defaultInstance;

  CommitBody._() : super();

  @override
  CommitBody createEmptyInstance() => create();

  @override
  CommitBody clone() => CommitBody()..mergeFromMessage(this);

  factory CommitBody({
    Hash? drPointer,
    Hash? commitment,
    DataRequestEligibilityClaim? proof,
    Iterable<Input>? collateral,
    Iterable<ValueTransferOutput>? outputs,
    Bn256PublicKey? bn256PublicKey,
  }) {
    final _result = create();
    if (drPointer != null) {
      _result.drPointer = drPointer;
    }
    if (commitment != null) {
      _result.commitment = commitment;
    }
    if (proof != null) {
      _result.proof = proof;
    }
    if (collateral != null) {
      _result.collateral.addAll(collateral);
    }
    if (outputs != null) {
      _result.outputs.addAll(outputs);
    }
    if (bn256PublicKey != null) {
      _result.bn256PublicKey = bn256PublicKey;
    }
    return _result;
  }

  @override
  factory CommitBody.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  factory CommitBody.fromRawJson(String str) => CommitBody.fromJson(json.decode(str));

  @override
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

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
        "bn256_public_key": bn256PublicKey.jsonMap(asHex: asHex),
        "collateral": List<dynamic>.from(collateral.map((x) => x.jsonMap(asHex: asHex))),
        "commitment": (asHex) ? commitment.hex : commitment.bytes,
        "dr_pointer": (asHex) ? drPointer.hex : drPointer.bytes,
        "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap(asHex: asHex))),
        "proof": proof.jsonMap(asHex: asHex),
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  Hash get drPointer => $_getN(0);
  @TagNumber(1)
  set drPointer(Hash v) { setField(1, v); }
  @TagNumber(1)
  bool hasDrPointer() => $_has(0);
  @TagNumber(1)
  void clearDrPointer() => clearField(1);
  @TagNumber(1)
  Hash ensureDrPointer() => $_ensure(0);

  @TagNumber(2)
  Hash get commitment => $_getN(1);
  @TagNumber(2)
  set commitment(Hash v) { setField(2, v); }
  @TagNumber(2)
  bool hasCommitment() => $_has(1);
  @TagNumber(2)
  void clearCommitment() => clearField(2);
  @TagNumber(2)
  Hash ensureCommitment() => $_ensure(1);

  @TagNumber(3)
  DataRequestEligibilityClaim get proof => $_getN(2);
  @TagNumber(3)
  set proof(DataRequestEligibilityClaim v) { setField(3, v); }
  @TagNumber(3)
  bool hasProof() => $_has(2);
  @TagNumber(3)
  void clearProof() => clearField(3);
  @TagNumber(3)
  DataRequestEligibilityClaim ensureProof() => $_ensure(2);

  @TagNumber(4)
  List<Input> get collateral => $_getList(3);

  @TagNumber(5)
  List<ValueTransferOutput> get outputs => $_getList(4);

  @TagNumber(6)
  Bn256PublicKey get bn256PublicKey => $_getN(5);
  @TagNumber(6)
  set bn256PublicKey(Bn256PublicKey v) { setField(6, v); }
  @TagNumber(6)
  bool hasBn256PublicKey() => $_has(5);
  @TagNumber(6)
  void clearBn256PublicKey() => clearField(6);
  @TagNumber(6)
  Bn256PublicKey ensureBn256PublicKey() => $_ensure(5);
}