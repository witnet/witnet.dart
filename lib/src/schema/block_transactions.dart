part of 'schema.dart';

class BlockTransactions extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Block.BlockTransactions',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<MintTransaction>(1, 'mint', subBuilder: MintTransaction.create)
    ..pc<VTTransaction>(2, 'valueTransferTxns', PbFieldType.PM,
        subBuilder: VTTransaction.create)
    ..pc<DRTransaction>(3, 'dataRequestTxns', PbFieldType.PM,
        subBuilder: DRTransaction.create)
    ..pc<CommitTransaction>(4, 'commitTxns', PbFieldType.PM,
        subBuilder: CommitTransaction.create)
    ..pc<RevealTransaction>(5, 'revealTxns', PbFieldType.PM,
        subBuilder: RevealTransaction.create)
    ..pc<TallyTransaction>(6, 'tallyTxns', PbFieldType.PM,
        subBuilder: TallyTransaction.create)
    ..hasRequiredFields = false;

  static BlockTransactions create() => BlockTransactions._();

  static PbList<BlockTransactions> createRepeated() =>
      PbList<BlockTransactions>();

  static BlockTransactions getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<BlockTransactions>(create);

  static BlockTransactions? _defaultInstance;

  BlockTransactions._() : super();

  @override
  BlockTransactions clone() => BlockTransactions()..mergeFromMessage(this);

  @override
  BlockTransactions createEmptyInstance() => create();

  factory BlockTransactions({
    MintTransaction? mint,
    Iterable<VTTransaction>? valueTransferTxns,
    Iterable<DRTransaction>? dataRequestTxns,
    Iterable<CommitTransaction>? commitTxns,
    Iterable<RevealTransaction>? revealTxns,
    Iterable<TallyTransaction>? tallyTxns,
  }) {
    final _result = create();
    if (mint != null) _result.mint = mint;
    if (valueTransferTxns != null)
      _result.valueTransferTxns.addAll(valueTransferTxns);
    if (dataRequestTxns != null)
      _result.dataRequestTxns.addAll(dataRequestTxns);
    if (commitTxns != null) _result.commitTxns.addAll(commitTxns);
    if (revealTxns != null) _result.revealTxns.addAll(revealTxns);
    if (tallyTxns != null) _result.tallyTxns.addAll(tallyTxns);
    return _result;
  }

  factory BlockTransactions.fromRawJson(String str) =>
      BlockTransactions.fromJson(json.decode(str));

  @override
  factory BlockTransactions.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory BlockTransactions.fromJson(Map<String, dynamic> json) =>
      BlockTransactions(
        commitTxns: List<CommitTransaction>.from(
            json["commit_txns"].map((x) => CommitTransaction.fromJson(x))),
        dataRequestTxns: List<DRTransaction>.from(
            json["data_request_txns"].map((x) => DRTransaction.fromJson(x))),
        mint: MintTransaction.fromJson(json["mint"]),
        revealTxns: List<RevealTransaction>.from(
            json["reveal_txns"].map((x) => RevealTransaction.fromJson(x))),
        tallyTxns: List<TallyTransaction>.from(
            json["tally_txns"].map((x) => TallyTransaction.fromJson(x))),
        valueTransferTxns: List<VTTransaction>.from(
            json["value_transfer_txns"].map((x) => VTTransaction.fromJson(x))),
      );

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) {
    print('Block Transactions');
    return {
      "commit_txns":
          List<dynamic>.from(commitTxns.map((x) => x.jsonMap(asHex: asHex))),
      "data_request_txns": List<dynamic>.from(
          dataRequestTxns.map((x) => x.jsonMap(asHex: asHex))),
      "mint": mint.jsonMap(asHex: asHex),
      "reveal_txns":
          List<dynamic>.from(revealTxns.map((x) => x.jsonMap(asHex: asHex))),
      "tally_txns":
          List<dynamic>.from(tallyTxns.map((x) => x.jsonMap(asHex: asHex))),
      "value_transfer_txns": List<dynamic>.from(
          valueTransferTxns.map((x) => x.jsonMap(asHex: asHex))),
    };
  }

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  MintTransaction get mint => $_getN(0);
  @TagNumber(1)
  set mint(MintTransaction v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasMint() => $_has(0);
  @TagNumber(1)
  void clearMint() => clearField(1);
  @TagNumber(1)
  MintTransaction ensureMint() => $_ensure(0);

  @TagNumber(2)
  List<VTTransaction> get valueTransferTxns => $_getList(1);

  @TagNumber(3)
  List<DRTransaction> get dataRequestTxns => $_getList(2);

  @TagNumber(4)
  List<CommitTransaction> get commitTxns => $_getList(3);

  @TagNumber(5)
  List<RevealTransaction> get revealTxns => $_getList(4);

  @TagNumber(6)
  List<TallyTransaction> get tallyTxns => $_getList(5);
}
