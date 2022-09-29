part of 'schema.dart';

enum TransactionKind {
  valueTransfer,
  dataRequest,
  commit,
  reveal,
  tally,
  mint,
  notSet
}

const Map<int, TransactionKind> _Transaction_KindByTag = {
  1: TransactionKind.valueTransfer,
  2: TransactionKind.dataRequest,
  3: TransactionKind.commit,
  4: TransactionKind.reveal,
  5: TransactionKind.tally,
  6: TransactionKind.mint,
  0: TransactionKind.notSet
};

class Transaction extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Transaction',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..aOM<VTTransaction>(1, 'ValueTransfer',
        protoName: 'ValueTransfer', subBuilder: VTTransaction.create)
    ..aOM<DRTransaction>(2, 'DataRequest',
        protoName: 'DataRequest', subBuilder: DRTransaction.create)
    ..aOM<CommitTransaction>(3, 'Commit',
        protoName: 'Commit', subBuilder: CommitTransaction.create)
    ..aOM<RevealTransaction>(4, 'Reveal',
        protoName: 'Reveal', subBuilder: RevealTransaction.create)
    ..aOM<TallyTransaction>(5, 'Tally',
        protoName: 'Tally', subBuilder: TallyTransaction.create)
    ..aOM<MintTransaction>(6, 'Mint',
        protoName: 'Mint', subBuilder: MintTransaction.create)
    ..hasRequiredFields = false;

  static Transaction create() => Transaction._();
  static PbList<Transaction> createRepeated() => PbList<Transaction>();
  static Transaction getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  Transaction._() : super();

  @override
  Transaction clone() => Transaction()..mergeFromMessage(this);

  @override
  Transaction copyWith(void Function(Transaction) updates) =>
      super.copyWith((message) => updates(message as Transaction))
          as Transaction; // ignore: deprecated_member_use

  @override
  Transaction createEmptyInstance() => create();

  factory Transaction({
    VTTransaction? valueTransfer,
    DRTransaction? dataRequest,
    CommitTransaction? commit,
    RevealTransaction? reveal,
    TallyTransaction? tally,
    MintTransaction? mint,
  }) {
    final _result = create();
    if (valueTransfer != null) {
      _result.valueTransfer = valueTransfer;
    }
    if (dataRequest != null) {
      _result.dataRequest = dataRequest;
    }
    if (commit != null) {
      _result.commit = commit;
    }
    if (reveal != null) {
      _result.reveal = reveal;
    }
    if (tally != null) {
      _result.tally = tally;
    }
    if (mint != null) {
      _result.mint = mint;
    }
    return _result;
  }

  factory Transaction.fromRawJson(String str) =>
      Transaction.fromJson(json.decode(str));

  @override
  factory Transaction.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory Transaction.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('transaction')) {
      Map<String, dynamic> _txn = json['transaction'];
      var type = _txn.keys.first;
      switch (type) {
        case 'ValueTransfer':
          return Transaction(
              valueTransfer: VTTransaction.fromJson(_txn['ValueTransfer']));
        case 'Mint':
          return Transaction(mint: MintTransaction.fromJson(_txn['Mint']));
        case 'DataRequest':
          return Transaction(
              dataRequest: DRTransaction.fromJson(_txn['DataRequest']));
        case 'Commit':
          return Transaction(
              commit: CommitTransaction.fromJson(_txn['Commit']));
        case 'Reveal':
          return Transaction(
              reveal: RevealTransaction.fromJson(_txn['Reveal']));

        case 'Tally':
          return Transaction(tally: TallyTransaction.fromJson(_txn['Tally']));
      }
    } else {
      throw ArgumentError('Invalid json');
    }
    return Transaction();
  }

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) =>
      {"transaction": transaction.jsonMap()};

  @override
  BuilderInfo get info_ => _i;

  int get weight {
    if (hasDataRequest()) {
      int _weight = dataRequest.body.weight;
      return _weight;
    }

    if (hasValueTransfer()) {
      int _weight = 0;
      int numInputs = valueTransfer.body.inputs.length;
      int numOutputs = valueTransfer.body.outputs.length;
      _weight = 1 * numInputs * 3 * numOutputs * GAMMA;
      return _weight;
    }
    return 0;
  }

  dynamic get transaction {
    if (hasValueTransfer()) return valueTransfer;
    if (hasDataRequest()) return dataRequest;
    if (hasCommit()) return commit;
    if (hasReveal()) return reveal;
    if (hasTally()) return tally;
    if (hasMint()) return mint;
  }

  TransactionKind whichKind() => _Transaction_KindByTag[$_whichOneof(0)]!;

  void clearKind() => clearField($_whichOneof(0));

  @TagNumber(1)
  VTTransaction get valueTransfer => $_getN(0);
  @TagNumber(1)
  set valueTransfer(VTTransaction v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasValueTransfer() => $_has(0);
  @TagNumber(1)
  void clearValueTransfer() => clearField(1);
  @TagNumber(1)
  VTTransaction ensureValueTransfer() => $_ensure(0);

  @TagNumber(2)
  DRTransaction get dataRequest => $_getN(1);
  @TagNumber(2)
  set dataRequest(DRTransaction v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasDataRequest() => $_has(1);
  @TagNumber(2)
  void clearDataRequest() => clearField(2);
  @TagNumber(2)
  DRTransaction ensureDataRequest() => $_ensure(1);

  @TagNumber(3)
  CommitTransaction get commit => $_getN(2);
  @TagNumber(3)
  set commit(CommitTransaction v) {
    setField(3, v);
  }

  @TagNumber(3)
  bool hasCommit() => $_has(2);
  @TagNumber(3)
  void clearCommit() => clearField(3);
  @TagNumber(3)
  CommitTransaction ensureCommit() => $_ensure(2);

  @TagNumber(4)
  RevealTransaction get reveal => $_getN(3);
  @TagNumber(4)
  set reveal(RevealTransaction v) {
    setField(4, v);
  }

  @TagNumber(4)
  bool hasReveal() => $_has(3);
  @TagNumber(4)
  void clearReveal() => clearField(4);
  @TagNumber(4)
  RevealTransaction ensureReveal() => $_ensure(3);

  @TagNumber(5)
  TallyTransaction get tally => $_getN(4);
  @TagNumber(5)
  set tally(TallyTransaction v) {
    setField(5, v);
  }

  @TagNumber(5)
  bool hasTally() => $_has(4);
  @TagNumber(5)
  void clearTally() => clearField(5);
  @TagNumber(5)
  TallyTransaction ensureTally() => $_ensure(4);

  @TagNumber(6)
  MintTransaction get mint => $_getN(5);
  @TagNumber(6)
  set mint(MintTransaction v) {
    setField(6, v);
  }

  @TagNumber(6)
  bool hasMint() => $_has(5);
  @TagNumber(6)
  void clearMint() => clearField(6);
  @TagNumber(6)
  MintTransaction ensureMint() => $_ensure(5);
}
