part of 'schema.dart';

class TallyTransaction extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('TallyTransaction',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<Hash>(1, 'drPointer', subBuilder: Hash.create)
    ..a<List<int>>(2, 'tally', PbFieldType.OY)
    ..pc<ValueTransferOutput>(3, 'outputs', PbFieldType.PM,
        subBuilder: ValueTransferOutput.create)
    ..pc<PublicKeyHash>(4, 'outOfConsensus', PbFieldType.PM,
        subBuilder: PublicKeyHash.create)
    ..pc<PublicKeyHash>(5, 'errorCommitters', PbFieldType.PM,
        subBuilder: PublicKeyHash.create)
    ..hasRequiredFields = false;

  static TallyTransaction create() => TallyTransaction._();
  static PbList<TallyTransaction> createRepeated() =>
      PbList<TallyTransaction>();
  static TallyTransaction getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<TallyTransaction>(create);
  static TallyTransaction? _defaultInstance;

  TallyTransaction._() : super();

  @override
  TallyTransaction clone() => TallyTransaction()..mergeFromMessage(this);

  @override
  TallyTransaction copyWith(void Function(TallyTransaction) updates) =>
      super.copyWith((message) => updates(message as TallyTransaction))
          as TallyTransaction; // ignore: deprecated_member_use

  @override
  TallyTransaction createEmptyInstance() => create();

  factory TallyTransaction({
    Hash? drPointer,
    List<int>? tally,
    Iterable<ValueTransferOutput>? outputs,
    Iterable<PublicKeyHash>? outOfConsensus,
    Iterable<PublicKeyHash>? errorCommitters,
  }) {
    final _result = create();
    if (drPointer != null) {
      _result.drPointer = drPointer;
    }
    if (tally != null) {
      _result.tally = tally;
    }
    if (outputs != null) {
      _result.outputs.addAll(outputs);
    }
    if (outOfConsensus != null) {
      _result.outOfConsensus.addAll(outOfConsensus);
    }
    if (errorCommitters != null) {
      _result.errorCommitters.addAll(errorCommitters);
    }
    return _result;
  }

  factory TallyTransaction.fromRawJson(String str) =>
      TallyTransaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap);

  @override
  factory TallyTransaction.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory TallyTransaction.fromJson(Map<String, dynamic> json) =>
      TallyTransaction(
        drPointer: Hash.fromString(json["dr_pointer"]),
        outputs: List<ValueTransferOutput>.from(
            json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
        outOfConsensus: List<PublicKeyHash>.from(
            json["out_of_consensus"].map((x) => PublicKeyHash.fromAddress(x))),
        errorCommitters: List<PublicKeyHash>.from(
            json["error_committers"].map((x) => PublicKeyHash.fromAddress(x))),
        tally: Uint8List.fromList(List<int>.from(json["tally"].map((x) => x))),
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) {
    return {
      "dr_pointer": (asHex) ? drPointer.hex : drPointer.bytes,
      "error_committers":
          List<dynamic>.from(errorCommitters.map((x) => x.address)),
      "out_of_consensus":
          List<dynamic>.from(outOfConsensus.map((x) => x.address)),
      "outputs":
          List<dynamic>.from(outputs.map((x) => x.jsonMap(asHex: asHex))),
      "tally": (asHex) ? bytesToHex(Uint8List.fromList(tally)) : tally.toList(),
    };
  }

  @override
  BuilderInfo get info_ => _i;

  dynamic get decodeTally => cborToRad(tally.toList());

  @TagNumber(1)
  Hash get drPointer => $_getN(0);
  @TagNumber(1)
  set drPointer(Hash v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasDrPointer() => $_has(0);
  @TagNumber(1)
  void clearDrPointer() => clearField(1);
  @TagNumber(1)
  Hash ensureDrPointer() => $_ensure(0);

  @TagNumber(2)
  List<int> get tally => $_getN(1);
  @TagNumber(2)
  set tally(List<int> v) {
    $_setBytes(1, v);
  }

  @TagNumber(2)
  bool hasTally() => $_has(1);
  @TagNumber(2)
  void clearTally() => clearField(2);

  @TagNumber(3)
  List<ValueTransferOutput> get outputs => $_getList(2);

  @TagNumber(4)
  List<PublicKeyHash> get outOfConsensus => $_getList(3);

  @TagNumber(5)
  List<PublicKeyHash> get errorCommitters => $_getList(4);
}
