part of 'schema.dart';

class Block extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'Block',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..aOM<BlockHeader>(1, 'blockHeader', subBuilder: BlockHeader.create)
      ..aOM<KeyedSignature>(2, 'blockSig', subBuilder: KeyedSignature.create)
      ..aOM<BlockTransactions>(3, 'txns', subBuilder: BlockTransactions.create)
      ..hasRequiredFields = false;

  static Block create() => Block._();
  static PbList<Block> createRepeated() => PbList<Block>();
  static Block getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<Block>(create);
  static Block? _defaultInstance;

  Block._() : super();

  @override
  Block clone() => Block()..mergeFromMessage(this);

  @override
  Block createEmptyInstance() => create();

  factory Block({
    BlockHeader? blockHeader,
    KeyedSignature? blockSig,
    BlockTransactions? txns,
  }) {
    final _result = create();
    if (blockHeader != null) _result.blockHeader = blockHeader;
    if (blockSig != null) _result.blockSig = blockSig;
    if (txns != null) _result.txns = txns;
    return _result;
  }

  factory Block.fromRawJson(String str) => Block.fromJson(json.decode(str));

  factory Block.fromPbBytes(Uint8List bytes) => Block.fromBuffer(bytes.toList());

  @override
  factory Block.fromBuffer(
    List<int> i,
    [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory Block.fromJson(Map<String, dynamic> json) => Block(
    blockHeader: BlockHeader.fromJson(json["block_header"]),
    blockSig: (json["signature"] != null)
      ? KeyedSignature.fromJson(json["signature"])
      : null,
    txns: BlockTransactions.fromJson(json["txns"]),
    // txnsHashes: TransactionsHashes.fromJson(json["txns_hashes"]),
  );

  @override
  BuilderInfo get info_ => _i;

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) {
    return {
      "header": blockHeader.jsonMap(asHex: asHex),
      "sig": blockSig.jsonMap(asHex: asHex),
      "txns": txns.jsonMap(asHex: asHex),
    };
  }

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  BlockHeader get blockHeader => $_getN(0);
  @TagNumber(1)
  set blockHeader(BlockHeader v) {setField(1, v);}

  @TagNumber(1)
  bool hasBlockHeader() => $_has(0);
  @TagNumber(1)
  void clearBlockHeader() => clearField(1);
  @TagNumber(1)
  BlockHeader ensureBlockHeader() => $_ensure(0);

  @TagNumber(2)
  KeyedSignature get blockSig => $_getN(1);
  @TagNumber(2)
  set blockSig(KeyedSignature v) {setField(2, v);}

  @TagNumber(2)
  bool hasBlockSig() => $_has(1);
  @TagNumber(2)
  void clearBlockSig() => clearField(2);
  @TagNumber(2)
  KeyedSignature ensureBlockSig() => $_ensure(1);

  @TagNumber(3)
  BlockTransactions get txns => $_getN(2);
  @TagNumber(3)
  set txns(BlockTransactions v) {setField(3, v);}

  @TagNumber(3)
  bool hasTxns() => $_has(2);
  @TagNumber(3)
  void clearTxns() => clearField(3);
  @TagNumber(3)
  BlockTransactions ensureTxns() => $_ensure(2);
}
