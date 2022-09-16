part of 'schema.dart';

class OutputPointer extends GeneratedMessage {

  static final BuilderInfo _i = BuilderInfo(
    'OutputPointer',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..aOM<Hash>(1, 'transactionId', subBuilder: Hash.create)
      ..a<int>(2, 'outputIndex', PbFieldType.OU3)
      ..hasRequiredFields = false;

  static OutputPointer create() => OutputPointer._();
  static PbList<OutputPointer> createRepeated() => PbList<OutputPointer>();
  static OutputPointer getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<OutputPointer>(create);
  static OutputPointer? _defaultInstance;

  OutputPointer._() : super();

  @override
  OutputPointer clone() => OutputPointer()..mergeFromMessage(this);

  @override
  OutputPointer copyWith(void Function(OutputPointer) updates) => super.copyWith((message) => updates(message as OutputPointer)) as OutputPointer; // ignore: deprecated_member_use

  @override
  OutputPointer createEmptyInstance() => create();

  factory OutputPointer({
    Hash? transactionId,
    int? outputIndex,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (outputIndex != null) {
      _result.outputIndex = outputIndex;
    }
    return _result;
  }

  factory OutputPointer.fromString(String str) => OutputPointer(
    transactionId: Hash.fromString(str.split(':')[0]),
        outputIndex: int.parse(str.split(':')[1]),
      );

  @override
  factory OutputPointer.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);


  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex=false}) =>
      {'output_pointer': '${transactionId.hex}:$outputIndex'};

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  String toString() => 'OuputPointer(transactionID: $transactionId, index: $outputIndex)';

  @TagNumber(1)
  Hash get transactionId => $_getN(0);
  @TagNumber(1)
  set transactionId(Hash v) { setField(1, v); }
  @TagNumber(1)
  bool hasTransactionId() => $_has(0);
  @TagNumber(1)
  void clearTransactionId() => clearField(1);
  @TagNumber(1)
  Hash ensureTransactionId() => $_ensure(0);

  @TagNumber(2)
  int get outputIndex => $_getIZ(1);
  @TagNumber(2)
  set outputIndex(int v) { $_setUnsignedInt32(1, v); }
  @TagNumber(2)
  bool hasOutputIndex() => $_has(1);
  @TagNumber(2)
  void clearOutputIndex() => clearField(2);
}

