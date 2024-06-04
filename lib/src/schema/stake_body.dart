part of 'schema.dart';

class StakeBody extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('StakeBody',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..pc<Input>(1, 'inputs', PbFieldType.PM, subBuilder: Input.create)
    ..aOM<StakeOutput>(2, 'output', subBuilder: StakeOutput.create)
    ..aOM<ValueTransferOutput>(3, 'change',
        subBuilder: ValueTransferOutput.create)
    ..hasRequiredFields = false;

  static StakeBody create() => StakeBody._();
  static PbList<StakeBody> createRepeated() => PbList<StakeBody>();
  static StakeBody getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<StakeBody>(create);
  static StakeBody? _defaultInstance;

  StakeBody._() : super();

  @override
  StakeBody clone() => StakeBody()..mergeFromMessage(this);

  @override
  StakeBody createEmptyInstance() => create();

  factory StakeBody({
    Iterable<Input>? inputs,
    StakeOutput? output,
    ValueTransferOutput? change,
  }) {
    final _result = create();
    if (inputs != null) {
      _result.inputs.addAll(inputs);
    }
    if (output != null) {
      _result.output = output;
    }
    if (change != null) {
      _result.change = change;
    }
    return _result;
  }

  factory StakeBody.fromRawJson(String str) =>
      StakeBody.fromJson(json.decode(str));

  @override
  factory StakeBody.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory StakeBody.fromJson(Map<String, dynamic> json) => StakeBody(
        inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
        output: StakeOutput.fromJson(json["output"]),
        change: ValueTransferOutput.fromJson(json["change"]),
      );

  factory StakeBody.fromPbBytes(Uint8List buffer) =>
      create()..mergeFromBuffer(buffer, ExtensionRegistry.EMPTY);

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "inputs":
            List<dynamic>.from(inputs.map((x) => x.jsonMap(asHex: asHex))),
        "output": output.jsonMap(asHex: asHex),
        "change": change.jsonMap(asHex: asHex),
      };

  Uint8List get pbBytes => writeToBuffer();

  Uint8List get hash => sha256(data: pbBytes);

  String get transactionId => bytesToHex(hash);
  // VT_weight = N * INPUT_SIZE + M * OUTPUT_SIZE + STAKE_OUTPUT_WEIGHT
  int get weight =>
      (inputs.length * INPUT_SIZE) + OUTPUT_SIZE + STAKE_OUTPUT_WEIGHT;

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  List<Input> get inputs => $_getList(0);

  @TagNumber(2)
  StakeOutput get output => $_getN(1);
  @TagNumber(2)
  set output(StakeOutput v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasOutput() => $_has(1);
  @TagNumber(2)
  void clearOutput() => clearField(2);
  @TagNumber(2)
  StakeOutput ensureOutput() => $_ensure(1);

  @TagNumber(3)
  ValueTransferOutput get change => $_getN(2);
  @TagNumber(3)
  set change(ValueTransferOutput v) {
    setField(3, v);
  }

  @TagNumber(3)
  bool hasChange() => $_has(2);
  @TagNumber(3)
  void clearChange() => clearField(3);
  @TagNumber(3)
  VTTransactionBody ensureChange() => $_ensure(2);
}
