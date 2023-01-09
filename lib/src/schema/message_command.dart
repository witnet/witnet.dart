part of 'schema.dart';

enum Message_Command_Kind {
  version,
  verack,
  getPeers,
  peers,
  block,
  inventoryAnnouncement,
  inventoryRequest,
  lastBeacon,
  transaction,
  superBlockVote,
  superBlock,
  notSet
}

const Map<int, Message_Command_Kind> _Message_Command_KindByTag = {
  1: Message_Command_Kind.version,
  2: Message_Command_Kind.verack,
  3: Message_Command_Kind.getPeers,
  4: Message_Command_Kind.peers,
  5: Message_Command_Kind.block,
  6: Message_Command_Kind.inventoryAnnouncement,
  7: Message_Command_Kind.inventoryRequest,
  8: Message_Command_Kind.lastBeacon,
  9: Message_Command_Kind.transaction,
  10: Message_Command_Kind.superBlockVote,
  11: Message_Command_Kind.superBlock,
  0: Message_Command_Kind.notSet
};

class Message_Command extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Message.Command',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    ..aOM<Version>(1, 'Version',
        protoName: 'Version', subBuilder: Version.create)
    ..aOM<Verack>(2, 'Verack', protoName: 'Verack', subBuilder: Verack.create)
    ..aOM<GetPeers>(3, 'GetPeers',
        protoName: 'GetPeers', subBuilder: GetPeers.create)
    ..aOM<Peers>(4, 'Peers', protoName: 'Peers', subBuilder: Peers.create)
    ..aOM<Block>(5, 'Block', protoName: 'Block', subBuilder: Block.create)
    ..aOM<InventoryAnnouncement>(6, 'InventoryAnnouncement',
        protoName: 'InventoryAnnouncement',
        subBuilder: InventoryAnnouncement.create)
    ..aOM<InventoryRequest>(7, 'InventoryRequest',
        protoName: 'InventoryRequest', subBuilder: InventoryRequest.create)
    ..aOM<LastBeacon>(8, 'LastBeacon',
        protoName: 'LastBeacon', subBuilder: LastBeacon.create)
    ..aOM<Transaction>(9, 'Transaction',
        protoName: 'Transaction', subBuilder: Transaction.create)
    ..aOM<SuperBlockVote>(10, 'SuperBlockVote',
        protoName: 'SuperBlockVote', subBuilder: SuperBlockVote.create)
    ..aOM<SuperBlock>(11, 'SuperBlock',
        protoName: 'SuperBlock', subBuilder: SuperBlock.create)
    ..hasRequiredFields = false;

  static Message_Command create() => Message_Command._();
  static PbList<Message_Command> createRepeated() => PbList<Message_Command>();
  static Message_Command getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<Message_Command>(create);
  static Message_Command? _defaultInstance;

  Message_Command._() : super();

  @override
  Message_Command clone() => Message_Command()..mergeFromMessage(this);

  @override
  Message_Command createEmptyInstance() => create();

  factory Message_Command({
    Version? version,
    Verack? verack,
    GetPeers? getPeers,
    Peers? peers,
    Block? block,
    InventoryAnnouncement? inventoryAnnouncement,
    InventoryRequest? inventoryRequest,
    LastBeacon? lastBeacon,
    Transaction? transaction,
    SuperBlockVote? superBlockVote,
    SuperBlock? superBlock,
  }) {
    final _result = create();

    if (version != null) {
      _result.version = version;
    }

    if (verack != null) {
      _result.verack = verack;
    }

    if (getPeers != null) {
      _result.getPeers = getPeers;
    }

    if (peers != null) {
      _result.peers = peers;
    }
    if (block != null) {
      _result.block = block;
    }
    if (inventoryAnnouncement != null) {
      _result.inventoryAnnouncement = inventoryAnnouncement;
    }
    if (inventoryRequest != null) {
      _result.inventoryRequest = inventoryRequest;
    }
    if (lastBeacon != null) {
      _result.lastBeacon = lastBeacon;
    }
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (superBlockVote != null) {
      _result.superBlockVote = superBlockVote;
    }
    if (superBlock != null) {
      _result.superBlock = superBlock;
    }
    return _result;
  }

  @override
  factory Message_Command.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory Message_Command.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  Message_Command_Kind whichKind() =>
      _Message_Command_KindByTag[$_whichOneof(0)]!;
  void clearKind() => clearField($_whichOneof(0));

  @TagNumber(1)
  Version get version => $_getN(0);
  @TagNumber(1)
  set version(Version v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasVersion() => $_has(0);
  @TagNumber(1)
  void clearVersion() => clearField(1);
  @TagNumber(1)
  Version ensureVersion() => $_ensure(0);

  @TagNumber(2)
  Verack get verack => $_getN(1);
  @TagNumber(2)
  set verack(Verack v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasVerack() => $_has(1);
  @TagNumber(2)
  void clearVerack() => clearField(2);
  @TagNumber(2)
  Verack ensureVerack() => $_ensure(1);

  @TagNumber(3)
  GetPeers get getPeers => $_getN(2);
  @TagNumber(3)
  set getPeers(GetPeers v) {
    setField(3, v);
  }

  @TagNumber(3)
  bool hasGetPeers() => $_has(2);
  @TagNumber(3)
  void clearGetPeers() => clearField(3);
  @TagNumber(3)
  GetPeers ensureGetPeers() => $_ensure(2);

  @TagNumber(4)
  Peers get peers => $_getN(3);
  @TagNumber(4)
  set peers(Peers v) {
    setField(4, v);
  }

  @TagNumber(4)
  bool hasPeers() => $_has(3);
  @TagNumber(4)
  void clearPeers() => clearField(4);
  @TagNumber(4)
  Peers ensurePeers() => $_ensure(3);

  @TagNumber(5)
  Block get block => $_getN(4);
  @TagNumber(5)
  set block(Block v) {
    setField(5, v);
  }

  @TagNumber(5)
  bool hasBlock() => $_has(4);
  @TagNumber(5)
  void clearBlock() => clearField(5);
  @TagNumber(5)
  Block ensureBlock() => $_ensure(4);

  @TagNumber(6)
  InventoryAnnouncement get inventoryAnnouncement => $_getN(5);
  @TagNumber(6)
  set inventoryAnnouncement(InventoryAnnouncement v) {
    setField(6, v);
  }

  @TagNumber(6)
  bool hasInventoryAnnouncement() => $_has(5);
  @TagNumber(6)
  void clearInventoryAnnouncement() => clearField(6);
  @TagNumber(6)
  InventoryAnnouncement ensureInventoryAnnouncement() => $_ensure(5);

  @TagNumber(7)
  InventoryRequest get inventoryRequest => $_getN(6);
  @TagNumber(7)
  set inventoryRequest(InventoryRequest v) {
    setField(7, v);
  }

  @TagNumber(7)
  bool hasInventoryRequest() => $_has(6);
  @TagNumber(7)
  void clearInventoryRequest() => clearField(7);
  @TagNumber(7)
  InventoryRequest ensureInventoryRequest() => $_ensure(6);

  @TagNumber(8)
  LastBeacon get lastBeacon => $_getN(7);
  @TagNumber(8)
  set lastBeacon(LastBeacon v) {
    setField(8, v);
  }

  @TagNumber(8)
  bool hasLastBeacon() => $_has(7);
  @TagNumber(8)
  void clearLastBeacon() => clearField(8);
  @TagNumber(8)
  LastBeacon ensureLastBeacon() => $_ensure(7);

  @TagNumber(9)
  Transaction get transaction => $_getN(8);
  @TagNumber(9)
  set transaction(Transaction v) {
    setField(9, v);
  }

  @TagNumber(9)
  bool hasTransaction() => $_has(8);
  @TagNumber(9)
  void clearTransaction() => clearField(9);
  @TagNumber(9)
  Transaction ensureTransaction() => $_ensure(8);

  @TagNumber(10)
  SuperBlockVote get superBlockVote => $_getN(9);
  @TagNumber(10)
  set superBlockVote(SuperBlockVote v) {
    setField(10, v);
  }

  @TagNumber(10)
  bool hasSuperBlockVote() => $_has(9);
  @TagNumber(10)
  void clearSuperBlockVote() => clearField(10);
  @TagNumber(10)
  SuperBlockVote ensureSuperBlockVote() => $_ensure(9);

  @TagNumber(11)
  SuperBlock get superBlock => $_getN(10);
  @TagNumber(11)
  set superBlock(SuperBlock v) {
    setField(11, v);
  }

  @TagNumber(11)
  bool hasSuperBlock() => $_has(10);
  @TagNumber(11)
  void clearSuperBlock() => clearField(11);
  @TagNumber(11)
  SuperBlock ensureSuperBlock() => $_ensure(10);
}
