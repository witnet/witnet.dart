part of 'schema.dart';

class RADFilter extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
      'DataRequestOutput.RADRequest.RADFilter',
      package: const PackageName('witnet'),
      createEmptyInstance: create)
    ..a<int>(1, 'op', PbFieldType.OU3)
    ..a<List<int>>(2, 'args', PbFieldType.OY)
    ..hasRequiredFields = false;

  static RADFilter create() => RADFilter._();
  static PbList<RADFilter> createRepeated() => PbList<RADFilter>();
  static RADFilter getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<RADFilter>(create);
  static RADFilter? _defaultInstance;

  RADFilter._() : super();

  @override
  RADFilter clone() => RADFilter()..mergeFromMessage(this);

  @override
  RADFilter createEmptyInstance() => create();

  factory RADFilter({int? op, List<int>? args}) {
    final _result = create();
    if (op != null) {
      _result.op = op;
    }
    if (args != null) {
      _result.args = args;
    }
    return _result;
  }

  @override
  factory RADFilter.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory RADFilter.fromRawJson(String str) =>
      RADFilter.fromJson(json.decode(str));

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  @override
  factory RADFilter.fromJson(Map<String, dynamic> json) => RADFilter(
        op: json['op'],
        args: List<int>.from(json["args"].map((x) => x)),
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "op": op,
        "args": (asHex) ? bytesToHex(Uint8List.fromList(args)) : args,
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  // op: 4 bytes
  int get weight => args.length + 4;

  String toString() => '{"op": $op, "args": [$args]}';

  @TagNumber(1)
  int get op => $_getIZ(0);
  @TagNumber(1)
  set op(int v) {
    $_setUnsignedInt32(0, v);
  }

  @TagNumber(1)
  bool hasOp() => $_has(0);
  @TagNumber(1)
  void clearOp() => clearField(1);

  @TagNumber(2)
  List<int> get args => $_getN(1);
  @TagNumber(2)
  set args(List<int> v) {
    $_setBytes(1, v);
  }

  @TagNumber(2)
  bool hasArgs() => $_has(1);
  @TagNumber(2)
  void clearArgs() => clearField(2);
}
