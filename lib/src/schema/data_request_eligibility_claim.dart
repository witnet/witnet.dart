part of 'schema.dart';

class DataRequestEligibilityClaim extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('DataRequestEligibilityClaim',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<VrfProof>(1, 'proof', subBuilder: VrfProof.create)
    ..hasRequiredFields = false;

  static DataRequestEligibilityClaim create() =>
      DataRequestEligibilityClaim._();
  static PbList<DataRequestEligibilityClaim> createRepeated() =>
      PbList<DataRequestEligibilityClaim>();
  static DataRequestEligibilityClaim getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<DataRequestEligibilityClaim>(create);
  static DataRequestEligibilityClaim? _defaultInstance;

  DataRequestEligibilityClaim._() : super();

  @override
  DataRequestEligibilityClaim clone() =>
      DataRequestEligibilityClaim()..mergeFromMessage(this);

  @override
  DataRequestEligibilityClaim createEmptyInstance() => create();

  factory DataRequestEligibilityClaim({
    VrfProof? proof,
  }) {
    final _result = create();
    if (proof != null) {
      _result.proof = proof;
    }
    return _result;
  }

  factory DataRequestEligibilityClaim.fromRawJson(String str) =>
      DataRequestEligibilityClaim.fromJson(json.decode(str));

  @override
  factory DataRequestEligibilityClaim.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory DataRequestEligibilityClaim.fromJson(Map<String, dynamic> json) =>
      DataRequestEligibilityClaim(
        proof: VrfProof.fromJson(json["proof"]),
      );

  String get rawJson => json.encode(jsonMap());

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "proof": proof.jsonMap(asHex: asHex),
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  VrfProof get proof => $_getN(0);
  @TagNumber(1)
  set proof(VrfProof v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasProof() => $_has(0);
  @TagNumber(1)
  void clearProof() => clearField(1);
  @TagNumber(1)
  VrfProof ensureProof() => $_ensure(0);
}
