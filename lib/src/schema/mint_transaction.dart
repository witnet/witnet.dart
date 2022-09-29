part of 'schema.dart';

class MintTransaction extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('MintTransaction',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<int>(1, 'epoch', PbFieldType.OF3)
    ..pc<ValueTransferOutput>(2, 'outputs', PbFieldType.PM,
        subBuilder: ValueTransferOutput.create)
    ..hasRequiredFields = false;

  static MintTransaction create() => MintTransaction._();
  static PbList<MintTransaction> createRepeated() => PbList<MintTransaction>();
  static MintTransaction getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<MintTransaction>(create);
  static MintTransaction? _defaultInstance;

  MintTransaction._() : super();

  @override
  MintTransaction clone() => MintTransaction()..mergeFromMessage(this);

  @override
  MintTransaction createEmptyInstance() => create();

  factory MintTransaction({
    int? epoch,
    Iterable<ValueTransferOutput>? outputs,
  }) {
    final _result = create();
    if (epoch != null) {
      _result.epoch = epoch;
    }
    if (outputs != null) {
      _result.outputs.addAll(outputs);
    }
    return _result;
  }

  @override
  factory MintTransaction.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory MintTransaction.fromRawJson(String str) =>
      MintTransaction.fromJson(json.decode(str));

  @override
  factory MintTransaction.fromJson(Map<String, dynamic> json) =>
      MintTransaction(
        epoch: json['epoch'],
        outputs: List<ValueTransferOutput>.from(
            json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
      );

  String get rawJson => json.encode(jsonMap());

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "epoch": epoch,
        "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap())),
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  int get epoch => $_getIZ(0);
  @TagNumber(1)
  set epoch(int v) {
    $_setUnsignedInt32(0, v);
  }

  @TagNumber(1)
  bool hasEpoch() => $_has(0);
  @TagNumber(1)
  void clearEpoch() => clearField(1);

  @TagNumber(2)
  List<ValueTransferOutput> get outputs => $_getList(1);
}
