part of 'schema.dart';

class RADAggregate extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
      'DataRequestOutput.RADRequest.RADAggregate',
      package: const PackageName('witnet'),
      createEmptyInstance: create)
    ..pc<RADFilter>(1, 'filters', PbFieldType.PM, subBuilder: RADFilter.create)
    ..a<int>(2, 'reducer', PbFieldType.OU3)
    ..hasRequiredFields = false;

  static RADAggregate create() => RADAggregate._();
  static PbList<RADAggregate> createRepeated() => PbList<RADAggregate>();
  static RADAggregate getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<RADAggregate>(create);
  static RADAggregate? _defaultInstance;

  RADAggregate._() : super();

  @override
  RADAggregate clone() => RADAggregate()..mergeFromMessage(this);

  @override
  RADAggregate copyWith(void Function(RADAggregate) updates) =>
      super.copyWith((message) => updates(message as RADAggregate))
          as RADAggregate; // ignore: deprecated_member_use

  @override
  RADAggregate createEmptyInstance() => create();

  factory RADAggregate({
    Iterable<RADFilter>? filters,
    int? reducer,
  }) {
    final _result = create();
    if (filters != null) {
      _result.filters.addAll(filters);
    }
    if (reducer != null) {
      _result.reducer = reducer;
    }
    return _result;
  }

  @override
  factory RADAggregate.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory RADAggregate.fromRawJson(String str) =>
      RADAggregate.fromJson(json.decode(str));

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  @override
  factory RADAggregate.fromJson(Map<String, dynamic> json) => RADAggregate(
        filters: List<RADFilter>.from(
            json["filters"].map((x) => RADFilter.fromJson(x))),
        reducer: json["reducer"],
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "filters":
            List<dynamic>.from(filters.map((x) => x.jsonMap(asHex: asHex))),
        "reducer": reducer,
      };

  RADAggregate addFilter(int op, dynamic args) {
    filters.add(RADFilter.fromJson({'op': op, 'args': radToCbor(args)}));
    return this;
  }

  RADAggregate setReducer(
    int reducer,
  ) {
    this.reducer = reducer;
    return this;
  }

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  int get weight {
    // reducer 4 bytes
    var filtersWeight = 0;
    for (var filter in filters) filtersWeight += filter.weight;
    return filtersWeight + 4;
  }

  @TagNumber(1)
  List<RADFilter> get filters => $_getList(0);

  @TagNumber(2)
  int get reducer => $_getIZ(1);
  @TagNumber(2)
  set reducer(int v) {
    $_setUnsignedInt32(1, v);
  }

  @TagNumber(2)
  bool hasReducer() => $_has(1);
  @TagNumber(2)
  void clearReducer() => clearField(2);
}
