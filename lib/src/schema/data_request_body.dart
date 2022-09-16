part of 'schema.dart';

class DRTransactionBody extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'DRTransactionBody',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..pc<Input>(1, 'inputs', PbFieldType.PM, subBuilder: Input.create)
      ..pc<ValueTransferOutput>(2, 'outputs', PbFieldType.PM, subBuilder: ValueTransferOutput.create)
      ..aOM<DataRequestOutput>(3, 'drOutput', subBuilder: DataRequestOutput.create)
      ..hasRequiredFields = false;

  static DRTransactionBody create() => DRTransactionBody._();
  static PbList<DRTransactionBody> createRepeated() => PbList<DRTransactionBody>();
  static DRTransactionBody getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<DRTransactionBody>(create);
  static DRTransactionBody? _defaultInstance;

  DRTransactionBody._() : super();

  @override
  DRTransactionBody clone() => DRTransactionBody()..mergeFromMessage(this);

  @override
  DRTransactionBody createEmptyInstance() => create();

  factory DRTransactionBody({
    Iterable<Input>? inputs,
    Iterable<ValueTransferOutput>? outputs,
    DataRequestOutput? drOutput,
  }) {
    final _result = create();
    if (inputs != null) {
      _result.inputs.addAll(inputs);
    }
    if (outputs != null) {
      _result.outputs.addAll(outputs);
    }
    if (drOutput != null) {
      _result.drOutput = drOutput;
    }
    return _result;
  }



  factory DRTransactionBody.fromRawJson(String str) => DRTransactionBody.fromJson(json.decode(str));

  @override
  factory DRTransactionBody.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  @override
  factory DRTransactionBody.fromJson(Map<String, dynamic> json) =>
      DRTransactionBody(
        inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
        outputs: List<ValueTransferOutput>.from(
            json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
        drOutput: DataRequestOutput.fromJson(json['dr_output']),
      );

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "dr_output": drOutput.jsonMap(asHex: asHex),
        "inputs": List<dynamic>.from(inputs.map((x) => x.jsonMap(asHex: asHex))),
        "outputs": List<dynamic>.from(outputs.map((x) => x.jsonMap())),
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  /// Specified data to be divided in a new level in the proof of inclusion
  /// In this case data = dataRequestOutput.hash
  Uint8List get dataPoiHash => drOutput.hash;

  /// Rest of the transaction to be divided in a new level in the proof of inclusion
  /// In this case we choose the complete transaction
  Uint8List get restPoiHash => sha256(data: pbBytes);

  Uint8List get hash => sha256(data: concatBytes([dataPoiHash, restPoiHash]));

  int get weight {
    // DR_weight = DR_size*alpha + W*COMMIT + W*REVEAL*beta + TALLY*beta + W*OUTPUT_SIZE
    final int inputsWeight = inputs.length * INPUT_SIZE;
    final int outputsWeight = outputs.length * OUTPUT_SIZE;
    final drWeight = inputsWeight + outputsWeight + drOutput.weight * ALPHA;
    final drExtraWeight = drOutput.extraWeight;
    return drWeight + drExtraWeight;
  }

  @TagNumber(1)
  List<Input> get inputs => $_getList(0);

  @TagNumber(2)
  List<ValueTransferOutput> get outputs => $_getList(1);

  @TagNumber(3)
  DataRequestOutput get drOutput => $_getN(2);
  @TagNumber(3)
  set drOutput(DataRequestOutput v) { setField(3, v); }
  @TagNumber(3)
  bool hasDrOutput() => $_has(2);
  @TagNumber(3)
  void clearDrOutput() => clearField(3);
  @TagNumber(3)
  DataRequestOutput ensureDrOutput() => $_ensure(2);
}