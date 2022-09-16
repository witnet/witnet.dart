part of 'schema.dart';


class RADTally extends GeneratedMessage {

  static final BuilderInfo _i = BuilderInfo(
    'DataRequestOutput.RADRequest.RADTally',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..pc<RADFilter>(1, 'filters', PbFieldType.PM, subBuilder: RADFilter.create)
      ..a<int>(2, 'reducer', PbFieldType.OU3)
      ..hasRequiredFields = false;

  static RADTally create() => RADTally._();
  static PbList<RADTally> createRepeated() => PbList<RADTally>();
  static RADTally getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<RADTally>(create);
  static RADTally? _defaultInstance;

  RADTally._() : super();

  @override
  RADTally clone() => RADTally()..mergeFromMessage(this);

  @override
  RADTally copyWith(void Function(RADTally) updates) => super.copyWith((message) => updates(message as RADTally)) as RADTally; // ignore: deprecated_member_use

  @override
  RADTally createEmptyInstance() => create();

  factory RADTally({Iterable<RADFilter>? filters, int? reducer,}) {
    final _result = create();
    if (filters != null) {
      _result.filters.addAll(filters.toList());
    }
    if (reducer != null) {
      _result.reducer = reducer;
    }
    return _result;
  }

  @override
  factory RADTally.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  factory RADTally.fromRawJson(String str) => RADTally.fromJson(json.decode(str));

  @override
  factory RADTally.fromJson(Map<String, dynamic> json) => RADTally(
    filters: List<RADFilter>.from(json["filters"].map((x) => RADFilter.fromJson(x))),
    reducer: json["reducer"],
  );

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
    "filters": List<dynamic>.from(filters.map((x) => x.jsonMap(asHex: asHex))),
    "reducer": reducer,
  };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  RADTally addFilter(int op, dynamic args){
    filters.add(RADFilter.fromJson({'op': op, 'args': radToCbor(args)} ));
    return this;
  }

  RADTally setReducer(int reducer, ){
    this.reducer = reducer;
    return this;
  }

  int get weight {
    // reducer: 4 bytes
    var filtersWeight = 0;
    for (var filter in filters) filtersWeight += filter.weight;
    return filtersWeight + 4;
  }

  @TagNumber(1)
  List<RADFilter> get filters => $_getList(0);

  @TagNumber(2)
  int get reducer => $_getIZ(1);
  @TagNumber(2)
  set reducer(int v) { $_setUnsignedInt32(1, v); }
  @TagNumber(2)
  bool hasReducer() => $_has(1);
  @TagNumber(2)
  void clearReducer() => clearField(2);
}
