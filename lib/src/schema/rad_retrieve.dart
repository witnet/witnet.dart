part of 'schema.dart';

class RADRetrieve extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
      'DataRequestOutput.RADRequest.RADRetrieve',
      package: const PackageName('witnet'),
      createEmptyInstance: create)
    ..e<RADType>(1, 'kind', PbFieldType.OE,
        defaultOrMaker: RADType.Unknown,
        valueOf: RADType.valueOf,
        enumValues: RADType.values)
    ..aOS(2, 'url')
    ..a<List<int>>(3, 'script', PbFieldType.OY)
    ..a<List<int>>(4, 'body', PbFieldType.OY)
    ..pc<StringPair>(5, 'headers', PbFieldType.PM,
        subBuilder: StringPair.create)
    ..hasRequiredFields = false;

  static RADRetrieve create() => RADRetrieve._();
  static PbList<RADRetrieve> createRepeated() => PbList<RADRetrieve>();
  static RADRetrieve getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<RADRetrieve>(create);
  static RADRetrieve? _defaultInstance;

  RADRetrieve._() : super();
  factory RADRetrieve({
    RADType? kind,
    String? url,
    List<int>? script,
    List<int>? body = null,
    Iterable<StringPair>? headers,
  }) {
    final _result = create();
    if (kind != null) {
      _result.kind = kind;
    }
    if (url != null) {
      _result.url = url;
    }
    if (script != null) {
      _result.script = script;
    }
    if (body != null) {
      _result.body = body;
    }
    if (headers != null) {
      _result.headers.addAll(headers);
    }
    return _result;
  }

  @override
  RADRetrieve clone() => RADRetrieve()..mergeFromMessage(this);

  @override
  RADRetrieve createEmptyInstance() => create();

  @override
  factory RADRetrieve.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory RADRetrieve.fromRawJson(String str) =>
      RADRetrieve.fromJson(json.decode(str));

  @override
  factory RADRetrieve.fromJson(Map<String, dynamic> json) => RADRetrieve(
        kind: RADType.valueOf(json["kind"]),
        script: List<int>.from(json["script"].map((x) => x)),
        url: json["url"],
        body: (json["body"] != null)
            ? List<int>.from(json["body"].map((x) => x))
            : null,
        headers: (json["headers"] != null)
            ? List<StringPair>.from((json["headers"] as Map<String, String>)
                .entries
                .map((e) => StringPair(left: e.key, right: e.value)))
            : null,
      );

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  @override
  Map<String, dynamic> jsonMap({bool asHex = false}) {
    Map<String, dynamic> _map = {
      "kind": kind.value,
      "script": (asHex)
          ? bytesToHex(Uint8List.fromList(script))
          : List<int>.from(script.map((x) => x)),
      "url": url,
    };
    if (body.isNotEmpty)
      _map["body"] = (asHex) ? bytesToHex(Uint8List.fromList(body)) : body;
    if (headers.isNotEmpty)
      _map["headers"] = Map<String, String>.from(headers
          .asMap()
          .map((key, value) => MapEntry(value.left, value.right)));

    return _map;
  }

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  int get weight {
    // RADType: 1 byte
    return script.length + url.codeUnits.length + 1;
  }

  @override
  String toString() {
    return '${this.kind}\n${this.url}';
  }

  @TagNumber(1)
  RADType get kind => $_getN(0);
  @TagNumber(1)
  set kind(RADType v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasKind() => $_has(0);
  @TagNumber(1)
  void clearKind() => clearField(1);

  @TagNumber(2)
  String get url => $_getSZ(1);
  @TagNumber(2)
  set url(String v) {
    $_setString(1, v);
  }

  @TagNumber(2)
  bool hasUrl() => $_has(1);
  @TagNumber(2)
  void clearUrl() => clearField(2);

  @TagNumber(3)
  List<int> get script => $_getN(2);
  @TagNumber(3)
  set script(List<int> v) {
    $_setBytes(2, v);
  }

  @TagNumber(3)
  bool hasScript() => $_has(2);
  @TagNumber(3)
  void clearScript() => clearField(3);

  @TagNumber(4)
  List<int> get body => $_getN(3);
  @TagNumber(4)
  set body(List<int> v) {
    $_setBytes(3, v);
  }

  @TagNumber(4)
  bool hasBody() => $_has(3);
  @TagNumber(4)
  void clearBody() => clearField(4);

  @TagNumber(5)
  List<StringPair> get headers => $_getList(4);
}
