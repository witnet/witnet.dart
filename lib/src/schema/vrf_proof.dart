part of 'schema.dart';

class VrfProof extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('VrfProof',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<List<int>>(1, 'proof', PbFieldType.OY)
    ..aOM<PublicKey>(2, 'publicKey', subBuilder: PublicKey.create)
    ..hasRequiredFields = false;

  static VrfProof create() => VrfProof._();
  static PbList<VrfProof> createRepeated() => PbList<VrfProof>();
  static VrfProof getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<VrfProof>(create);
  static VrfProof? _defaultInstance;

  VrfProof._() : super();

  @override
  VrfProof clone() => VrfProof()..mergeFromMessage(this);

  @override
  VrfProof createEmptyInstance() => create();

  factory VrfProof({
    List<int>? proof,
    PublicKey? publicKey,
  }) {
    final _result = create();
    if (proof != null) {
      _result.proof = proof;
    }
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    return _result;
  }

  factory VrfProof.fromRawJson(String str) =>
      VrfProof.fromJson(json.decode(str));

  @override
  factory VrfProof.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory VrfProof.fromJson(Map<String, dynamic> json) => VrfProof(
        proof: (json["proof"].runtimeType == String)
            ? hexToBytes(json["proof"])
            : List<int>.from(json["proof"].map((x) => x)),
        publicKey: PublicKey.fromJson(json["public_key"]),
      );

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "proof": (asHex)
            ? bytesToHex(Uint8List.fromList(proof))
            : List<dynamic>.from(proof.map((x) => x)),
        "public_key": publicKey.jsonMap(asHex: asHex),
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  List<int> get proof => $_getN(0);
  @TagNumber(1)
  set proof(List<int> v) {
    $_setBytes(0, v);
  }

  @TagNumber(1)
  bool hasProof() => $_has(0);
  @TagNumber(1)
  void clearProof() => clearField(1);

  @TagNumber(2)
  PublicKey get publicKey => $_getN(1);
  @TagNumber(2)
  set publicKey(PublicKey v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasPublicKey() => $_has(1);
  @TagNumber(2)
  void clearPublicKey() => clearField(2);
  @TagNumber(2)
  PublicKey ensurePublicKey() => $_ensure(1);
}
