part of 'schema.dart';

class VTTransactionBody extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('VTTransactionBody',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..pc<Input>(1, 'inputs', PbFieldType.PM, subBuilder: Input.create)
    ..pc<ValueTransferOutput>(2, 'outputs', PbFieldType.PM,
        subBuilder: ValueTransferOutput.create)
    ..hasRequiredFields = false;

  static VTTransactionBody create() => VTTransactionBody._();
  static PbList<VTTransactionBody> createRepeated() =>
      PbList<VTTransactionBody>();
  static VTTransactionBody getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<VTTransactionBody>(create);
  static VTTransactionBody? _defaultInstance;

  VTTransactionBody._() : super();

  @override
  VTTransactionBody clone() => VTTransactionBody()..mergeFromMessage(this);

  @override
  VTTransactionBody copyWith(void Function(VTTransactionBody) updates) =>
      super.copyWith((message) => updates(message as VTTransactionBody))
          as VTTransactionBody; // ignore: deprecated_member_use

  @override
  VTTransactionBody createEmptyInstance() => create();

  factory VTTransactionBody({
    Iterable<Input>? inputs,
    Iterable<ValueTransferOutput>? outputs,
  }) {
    final _result = create();
    if (inputs != null) {
      _result.inputs.addAll(inputs);
    }
    if (outputs != null) {
      _result.outputs.addAll(outputs);
    }
    return _result;
  }

  factory VTTransactionBody.fromRawJson(String str) =>
      VTTransactionBody.fromJson(json.decode(str));

  @override
  factory VTTransactionBody.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory VTTransactionBody.fromJson(Map<String, dynamic> json) =>
      VTTransactionBody(
        inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
        outputs: List<ValueTransferOutput>.from(
            json["outputs"].map((x) => ValueTransferOutput.fromJson(x))),
      );

  factory VTTransactionBody.fromPbBytes(Uint8List buffer) =>
      create()..mergeFromBuffer(buffer, ExtensionRegistry.EMPTY);

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "inputs":
            List<dynamic>.from(inputs.map((x) => x.jsonMap(asHex: asHex))),
        "outputs":
            List<dynamic>.from(outputs.map((x) => x.jsonMap(asHex: asHex))),
      };

  Uint8List get pbBytes => writeToBuffer();

  Uint8List get hash => sha256(data: pbBytes);

  // VT_weight = N*INPUT_SIZE + M*OUTPUT_SIZE*gamma
  int get weight =>
      (inputs.length * INPUT_SIZE) + (outputs.length * OUTPUT_SIZE * GAMMA);

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  List<Input> get inputs => $_getList(0);

  @TagNumber(2)
  List<ValueTransferOutput> get outputs => $_getList(1);
}
