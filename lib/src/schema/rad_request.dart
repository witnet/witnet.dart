part of 'schema.dart';

class RADRequest extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('DataRequestOutput.RADRequest',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<Int64>(1, 'timeLock', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..pc<RADRetrieve>(2, 'retrieve', PbFieldType.PM,
        subBuilder: RADRetrieve.create)
    ..aOM<RADAggregate>(3, 'aggregate', subBuilder: RADAggregate.create)
    ..aOM<RADTally>(4, 'tally', subBuilder: RADTally.create)
    ..hasRequiredFields = false;

  static RADRequest create() => RADRequest._();
  static PbList<RADRequest> createRepeated() => PbList<RADRequest>();
  static RADRequest getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<RADRequest>(create);
  static RADRequest? _defaultInstance;

  factory RADRequest({
    int? timeLock,
    Iterable<RADRetrieve>? retrieve,
    RADAggregate? aggregate,
    RADTally? tally,
  }) {
    final _result = create();
    if (timeLock != null) {
      _result.timeLock = Int64(timeLock);
    }
    if (retrieve != null) {
      _result.retrieve.addAll(retrieve);
    }
    if (aggregate != null) {
      _result.aggregate = aggregate;
    }
    if (tally != null) {
      _result.tally = tally;
    }
    return _result;
  }

  @override
  BuilderInfo get info_ => _i;

  RADRequest._() : super();

  @override
  RADRequest clone() => RADRequest()..mergeFromMessage(this);

  @override
  RADRequest copyWith(void Function(RADRequest) updates) =>
      super.copyWith((message) => updates(message as RADRequest))
          as RADRequest; // ignore: deprecated_member_use

  @override
  RADRequest createEmptyInstance() => create();

  @override
  factory RADRequest.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory RADRequest.fromRawJson(String str) =>
      RADRequest.fromJson(json.decode(str));

  get weight {
    // timeLock 8 bytes
    var retrievalsWeight = 0;
    for (var retrieval in retrieve) retrievalsWeight += retrieval.weight;
    return retrievalsWeight + aggregate.weight + tally.weight + 8;
  }

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  @override
  factory RADRequest.fromJson(Map<String, dynamic> json) => RADRequest(
        aggregate: RADAggregate.fromJson(json["aggregate"]),
        retrieve: List<RADRetrieve>.from(
            json["retrieve"].map((x) => RADRetrieve.fromJson(x))),
        tally: RADTally.fromJson(json["tally"]),
        timeLock: (json["time_lock"] > 0) ? json["time_lock"] : null,
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "aggregate": aggregate.jsonMap(asHex: asHex),
        "retrieve":
            List<dynamic>.from(retrieve.map((x) => x.jsonMap(asHex: asHex))),
        "tally": tally.jsonMap(asHex: asHex),
        "time_lock": timeLock.toInt(),
      };

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  Int64 get timeLock => $_getI64(0);
  @TagNumber(1)
  set timeLock(Int64 v) {
    (v > Int64.ZERO) ? $_setInt64(0, v) : null;
  }

  @TagNumber(1)
  bool hasTimeLock() => $_has(0);
  @TagNumber(1)
  void clearTimeLock() => clearField(1);

  @TagNumber(2)
  List<RADRetrieve> get retrieve => $_getList(1);

  @TagNumber(3)
  RADAggregate get aggregate => $_getN(2);
  @TagNumber(3)
  set aggregate(RADAggregate v) {
    setField(3, v);
  }

  @TagNumber(3)
  bool hasAggregate() => $_has(2);
  @TagNumber(3)
  void clearAggregate() => clearField(3);
  @TagNumber(3)
  RADAggregate ensureAggregate() => $_ensure(2);

  @TagNumber(4)
  RADTally get tally => $_getN(3);
  @TagNumber(4)
  set tally(RADTally v) {
    setField(4, v);
  }

  @TagNumber(4)
  bool hasTally() => $_has(3);
  @TagNumber(4)
  void clearTally() => clearField(4);
  @TagNumber(4)
  RADTally ensureTally() => $_ensure(3);
}
