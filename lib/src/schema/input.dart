part of 'schema.dart';

class Input extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Input',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<OutputPointer>(1, 'outputPointer', subBuilder: OutputPointer.create)
    ..hasRequiredFields = false;

  static Input create() => Input._();
  static PbList<Input> createRepeated() => PbList<Input>();
  static Input getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<Input>(create);
  static Input? _defaultInstance;

  Input._() : super();

  @override
  Input clone() => Input()..mergeFromMessage(this);

  @override
  Input createEmptyInstance() => create();

  factory Input({
    OutputPointer? outputPointer,
  }) {
    final _result = create();
    if (outputPointer != null) {
      _result.outputPointer = outputPointer;
    }
    return _result;
  }

  @override
  factory Input.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory Input.fromRawJson(String str) => Input.fromJson(json.decode(str));

  @override
  factory Input.fromJson(Map<String, dynamic> json) =>
      Input(outputPointer: OutputPointer.fromString(json["output_pointer"]));

  String get rawJson => json.encode(jsonMap());

  Map<String, dynamic> jsonMap({bool asHex = false}) => outputPointer.jsonMap();

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  String toString() => 'Input(outputPointer: $outputPointer)';

  @TagNumber(1)
  OutputPointer get outputPointer => $_getN(0);
  @TagNumber(1)
  set outputPointer(OutputPointer v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasOutputPointer() => $_has(0);
  @TagNumber(1)
  void clearOutputPointer() => clearField(1);
  @TagNumber(1)
  OutputPointer ensureOutputPointer() => $_ensure(0);
}
