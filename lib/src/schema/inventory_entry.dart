part of 'schema.dart';

enum InventoryEntryKind { block, tx, superBlock, notSet }

class InventoryEntry extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('InventoryEntry',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<Hash>(1, 'Block', protoName: 'Block', subBuilder: Hash.create)
    ..aOM<Hash>(2, 'Tx', protoName: 'Tx', subBuilder: Hash.create)
    ..a<int>(3, 'SuperBlock', PbFieldType.OU3, protoName: 'SuperBlock')
    ..hasRequiredFields = false;

  static const Map<int, InventoryEntryKind> _InventoryEntry_KindByTag = {
    1: InventoryEntryKind.block,
    2: InventoryEntryKind.tx,
    3: InventoryEntryKind.superBlock,
    0: InventoryEntryKind.notSet
  };

  static InventoryEntry create() => InventoryEntry._();
  static PbList<InventoryEntry> createRepeated() => PbList<InventoryEntry>();
  static InventoryEntry getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<InventoryEntry>(create);
  static InventoryEntry? _defaultInstance;

  InventoryEntry._() : super();

  @override
  InventoryEntry clone() => InventoryEntry()..mergeFromMessage(this);

  @override
  InventoryEntry createEmptyInstance() => create();

  factory InventoryEntry({
    Hash? block,
    Hash? tx,
    int? superBlock,
  }) {
    final _result = create();
    if (block != null) {
      _result.block = block;
    }
    if (tx != null) {
      _result.tx = tx;
    }
    if (superBlock != null) {
      _result.superBlock = superBlock;
    }
    return _result;
  }

  @override
  factory InventoryEntry.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory InventoryEntry.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  InventoryEntryKind whichKind() => _InventoryEntry_KindByTag[$_whichOneof(0)]!;
  void clearKind() => clearField($_whichOneof(0));

  @TagNumber(1)
  Hash get block => $_getN(0);
  @TagNumber(1)
  set block(Hash v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasBlock() => $_has(0);
  @TagNumber(1)
  void clearBlock() => clearField(1);
  @TagNumber(1)
  Hash ensureBlock() => $_ensure(0);

  @TagNumber(2)
  Hash get tx => $_getN(1);
  @TagNumber(2)
  set tx(Hash v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasTx() => $_has(1);
  @TagNumber(2)
  void clearTx() => clearField(2);
  @TagNumber(2)
  Hash ensureTx() => $_ensure(1);

  @TagNumber(3)
  int get superBlock => $_getIZ(2);
  @TagNumber(3)
  set superBlock(int v) {
    $_setUnsignedInt32(2, v);
  }

  @TagNumber(3)
  bool hasSuperBlock() => $_has(2);
  @TagNumber(3)
  void clearSuperBlock() => clearField(3);
}
