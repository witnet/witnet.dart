part of 'schema.dart';

class BlockEligibilityClaim extends GeneratedMessage {

  static final BuilderInfo _i = BuilderInfo(
    'Block.BlockEligibilityClaim',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..aOM<VrfProof>(1, 'proof', subBuilder: VrfProof.create)
      ..hasRequiredFields = false;


  static BlockEligibilityClaim create() => BlockEligibilityClaim._();

  static PbList<BlockEligibilityClaim> createRepeated() =>
      PbList<BlockEligibilityClaim>();

  static BlockEligibilityClaim getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<BlockEligibilityClaim>(create);

  static BlockEligibilityClaim? _defaultInstance;

  BlockEligibilityClaim._() : super();

  @override
  BlockEligibilityClaim createEmptyInstance() => create();

  @override
  BlockEligibilityClaim clone() => BlockEligibilityClaim()..mergeFromMessage(this);

  @override
  BuilderInfo get info_ => _i;

  factory BlockEligibilityClaim({
    VrfProof? proof,
  }) {
    final _result = create();
    if (proof != null) _result.proof = proof;
    return _result;
  }

  @override
  factory BlockEligibilityClaim.fromBuffer(
    List<int> i,
    [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory BlockEligibilityClaim.fromPbBytes(Uint8List bytes) =>
      BlockEligibilityClaim.fromBuffer(bytes.toList());

  @override
  factory BlockEligibilityClaim.fromJson(Map<String, dynamic> json) =>
      BlockEligibilityClaim(proof: VrfProof.fromJson(json["proof"]));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
    "proof": proof.jsonMap(asHex: asHex),
  };

  @TagNumber(1)
  VrfProof get proof => $_getN(0);
  @TagNumber(1)
  set proof(VrfProof v) {setField(1, v);}
  @TagNumber(1)
  bool hasProof() => $_has(0);
  @TagNumber(1)
  void clearProof() => clearField(1);
  @TagNumber(1)
  VrfProof ensureProof() => $_ensure(0);
}