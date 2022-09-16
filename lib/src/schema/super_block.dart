part of 'schema.dart';

class SuperBlock extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'SuperBlock',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..a<int>(1, 'signingCommitteeLength', PbFieldType.OU3)
      ..aOM<Hash>(2, 'arsRoot', subBuilder: Hash.create)
      ..aOM<Hash>(3, 'dataRequestRoot', subBuilder: Hash.create)
      ..a<int>(4, 'index', PbFieldType.OU3)
      ..aOM<Hash>(5, 'lastBlock', subBuilder: Hash.create)
      ..aOM<Hash>(6, 'lastBlockInPreviousSuperblock', subBuilder: Hash.create)
      ..aOM<Hash>(7, 'tallyRoot', subBuilder: Hash.create)
      ..hasRequiredFields = false;

  static SuperBlock create() => SuperBlock._();
  static PbList<SuperBlock> createRepeated() => PbList<SuperBlock>();
  static SuperBlock getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<SuperBlock>(create);
  static SuperBlock? _defaultInstance;

  SuperBlock._() : super();

  @override
  SuperBlock clone() => SuperBlock()..mergeFromMessage(this);

  @override
  SuperBlock copyWith(void Function(SuperBlock) updates) => super.copyWith((message) => updates(message as SuperBlock)) as SuperBlock; // ignore: deprecated_member_use

  @override
  SuperBlock createEmptyInstance() => create();

  factory SuperBlock({
    int? signingCommitteeLength,
    Hash? arsRoot,
    Hash? dataRequestRoot,
    int? index,
    Hash? lastBlock,
    Hash? lastBlockInPreviousSuperblock,
    Hash? tallyRoot,
  }) {
    final _result = create();
    if (signingCommitteeLength != null) {
      _result.signingCommitteeLength = signingCommitteeLength;
    }
    if (arsRoot != null) {
      _result.arsRoot = arsRoot;
    }
    if (dataRequestRoot != null) {
      _result.dataRequestRoot = dataRequestRoot;
    }
    if (index != null) {
      _result.index = index;
    }
    if (lastBlock != null) {
      _result.lastBlock = lastBlock;
    }
    if (lastBlockInPreviousSuperblock != null) {
      _result.lastBlockInPreviousSuperblock = lastBlockInPreviousSuperblock;
    }
    if (tallyRoot != null) {
      _result.tallyRoot = tallyRoot;
    }
    return _result;
  }

  @override
  factory SuperBlock.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  @override
  factory SuperBlock.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  int get signingCommitteeLength => $_getIZ(0);
  @TagNumber(1)
  set signingCommitteeLength(int v) { $_setUnsignedInt32(0, v); }
  @TagNumber(1)
  bool hasSigningCommitteeLength() => $_has(0);
  @TagNumber(1)
  void clearSigningCommitteeLength() => clearField(1);

  @TagNumber(2)
  Hash get arsRoot => $_getN(1);
  @TagNumber(2)
  set arsRoot(Hash v) { setField(2, v); }
  @TagNumber(2)
  bool hasArsRoot() => $_has(1);
  @TagNumber(2)
  void clearArsRoot() => clearField(2);
  @TagNumber(2)
  Hash ensureArsRoot() => $_ensure(1);

  @TagNumber(3)
  Hash get dataRequestRoot => $_getN(2);
  @TagNumber(3)
  set dataRequestRoot(Hash v) { setField(3, v); }
  @TagNumber(3)
  bool hasDataRequestRoot() => $_has(2);
  @TagNumber(3)
  void clearDataRequestRoot() => clearField(3);
  @TagNumber(3)
  Hash ensureDataRequestRoot() => $_ensure(2);

  @TagNumber(4)
  int get index => $_getIZ(3);
  @TagNumber(4)
  set index(int v) { $_setUnsignedInt32(3, v); }
  @TagNumber(4)
  bool hasIndex() => $_has(3);
  @TagNumber(4)
  void clearIndex() => clearField(4);

  @TagNumber(5)
  Hash get lastBlock => $_getN(4);
  @TagNumber(5)
  set lastBlock(Hash v) { setField(5, v); }
  @TagNumber(5)
  bool hasLastBlock() => $_has(4);
  @TagNumber(5)
  void clearLastBlock() => clearField(5);
  @TagNumber(5)
  Hash ensureLastBlock() => $_ensure(4);

  @TagNumber(6)
  Hash get lastBlockInPreviousSuperblock => $_getN(5);
  @TagNumber(6)
  set lastBlockInPreviousSuperblock(Hash v) { setField(6, v); }
  @TagNumber(6)
  bool hasLastBlockInPreviousSuperblock() => $_has(5);
  @TagNumber(6)
  void clearLastBlockInPreviousSuperblock() => clearField(6);
  @TagNumber(6)
  Hash ensureLastBlockInPreviousSuperblock() => $_ensure(5);

  @TagNumber(7)
  Hash get tallyRoot => $_getN(6);
  @TagNumber(7)
  set tallyRoot(Hash v) { setField(7, v); }
  @TagNumber(7)
  bool hasTallyRoot() => $_has(6);
  @TagNumber(7)
  void clearTallyRoot() => clearField(7);
  @TagNumber(7)
  Hash ensureTallyRoot() => $_ensure(6);
}