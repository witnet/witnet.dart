part of 'schema.dart';

class StakeOutput extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('StakeOutput',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<Int64>(1, 'value', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..aOM<StakeKey>(2, 'key', subBuilder: StakeKey.create)
    ..aOM<KeyedSignature>(3, 'authorization', subBuilder: KeyedSignature.create)
    ..hasRequiredFields = false;

  static StakeOutput create() => StakeOutput._();
  static PbList<StakeOutput> createRepeated() => PbList<StakeOutput>();
  static StakeOutput getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<StakeOutput>(create);
  static StakeOutput? _defaultInstance;
  StakeOutput._() : super();

  @override
  GeneratedMessage clone() => StakeOutput()..mergeFromMessage(this);

  @override
  GeneratedMessage createEmptyInstance() => create();

  factory StakeOutput({
    int? value,
    StakeKey? key,
    KeyedSignature? authorization,
  }) {
    final _result = create();
    print('result >>>>***** $value');
    print('result >>>>***** $key');
    print('result >>>>***** $authorization');
    if (value != null) {
      _result.value = Int64(value);
    }

    if (key != null) {
      _result.key = key;
    }

    if (authorization != null) {
      _result.authorization = authorization;
    }
    print('result >>>>***** $_result');
    return _result;
  }

  factory StakeOutput.fromRawJson(String str) =>
      StakeOutput.fromJson(json.decode(str));

  @override
  factory StakeOutput.fromJson(Map<String, dynamic> json) => StakeOutput(
        value: json["value"],
        key: StakeKey.fromJson(json["key"]),
        authorization: json["authorization"] != null
            ? KeyedSignature.fromJson(json["authorization"])
            : null,
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "value": value.toInt(),
        "key": key.jsonMap(asHex: asHex),
        "authorization":
            authorization != null ? authorization!.jsonMap(asHex: asHex) : null,
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  Int64 get value => $_getI64(0);
  @TagNumber(1)
  set value(Int64 v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasValue() => $_has(0);
  @TagNumber(1)
  void clearValue() => clearField(1);

  @TagNumber(2)
  StakeKey get key => $_getN(1);
  @TagNumber(2)
  set key(StakeKey v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasKey() => $_has(1);
  @TagNumber(2)
  void clearKey() => clearField(2);
  @TagNumber(2)
  StakeKey ensureKey() => $_ensure(1);

  @TagNumber(3)
  KeyedSignature? get authorization => $_getN(2);
  @TagNumber(3)
  set authorization(KeyedSignature? v) {
    if (v != null) {
      setField(3, v);
    }
  }

  @TagNumber(3)
  bool hasAuthorization() => $_has(2);
  @TagNumber(3)
  void clearAuthorization() => clearField(3);
  @TagNumber(3)
  KeyedSignature? ensureAuthorization() => $_ensure(2);
}
