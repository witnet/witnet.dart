part of 'schema.dart';

class SuperBlockVote extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('SuperBlockVote',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<Bn256Signature>(1, 'bn256Signature',
        subBuilder: Bn256Signature.create)
    ..aOM<KeyedSignature>(2, 'secp256k1Signature',
        subBuilder: KeyedSignature.create)
    ..aOM<Hash>(3, 'superblockHash', subBuilder: Hash.create)
    ..a<int>(4, 'superblockIndex', PbFieldType.OF3)
    ..hasRequiredFields = false;

  static SuperBlockVote create() => SuperBlockVote._();
  static PbList<SuperBlockVote> createRepeated() => PbList<SuperBlockVote>();
  static SuperBlockVote getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<SuperBlockVote>(create);
  static SuperBlockVote? _defaultInstance;

  SuperBlockVote._() : super();

  @override
  SuperBlockVote clone() => SuperBlockVote()..mergeFromMessage(this);

  @override
  SuperBlockVote copyWith(void Function(SuperBlockVote) updates) =>
      super.copyWith((message) => updates(message as SuperBlockVote))
          as SuperBlockVote; // ignore: deprecated_member_use

  @override
  SuperBlockVote createEmptyInstance() => create();

  factory SuperBlockVote({
    Bn256Signature? bn256Signature,
    KeyedSignature? secp256k1Signature,
    Hash? superblockHash,
    int? superblockIndex,
  }) {
    final _result = create();
    if (bn256Signature != null) {
      _result.bn256Signature = bn256Signature;
    }
    if (secp256k1Signature != null) {
      _result.secp256k1Signature = secp256k1Signature;
    }
    if (superblockHash != null) {
      _result.superblockHash = superblockHash;
    }
    if (superblockIndex != null) {
      _result.superblockIndex = superblockIndex;
    }
    return _result;
  }

  @override
  factory SuperBlockVote.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory SuperBlockVote.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  Bn256Signature get bn256Signature => $_getN(0);
  @TagNumber(1)
  set bn256Signature(Bn256Signature v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasBn256Signature() => $_has(0);
  @TagNumber(1)
  void clearBn256Signature() => clearField(1);
  @TagNumber(1)
  Bn256Signature ensureBn256Signature() => $_ensure(0);

  @TagNumber(2)
  KeyedSignature get secp256k1Signature => $_getN(1);
  @TagNumber(2)
  set secp256k1Signature(KeyedSignature v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasSecp256k1Signature() => $_has(1);
  @TagNumber(2)
  void clearSecp256k1Signature() => clearField(2);
  @TagNumber(2)
  KeyedSignature ensureSecp256k1Signature() => $_ensure(1);

  @TagNumber(3)
  Hash get superblockHash => $_getN(2);
  @TagNumber(3)
  set superblockHash(Hash v) {
    setField(3, v);
  }

  @TagNumber(3)
  bool hasSuperblockHash() => $_has(2);
  @TagNumber(3)
  void clearSuperblockHash() => clearField(3);
  @TagNumber(3)
  Hash ensureSuperblockHash() => $_ensure(2);

  @TagNumber(4)
  int get superblockIndex => $_getIZ(3);
  @TagNumber(4)
  set superblockIndex(int v) {
    $_setUnsignedInt32(3, v);
  }

  @TagNumber(4)
  bool hasSuperblockIndex() => $_has(3);
  @TagNumber(4)
  void clearSuperblockIndex() => clearField(4);
}
