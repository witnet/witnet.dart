part of 'schema.dart';

class StakeOutput extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('StakeOutput',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<Int64>(1, 'value', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..aOM<KeyedSignature>(2, 'authorization', subBuilder: KeyedSignature.create)
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
    KeyedSignature? authorization,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = Int64(value);
    }
    if (authorization != null) {
      _result.authorization = authorization;
    }
    return _result;
  }

  factory StakeOutput.fromRawJson(String str) =>
      StakeOutput.fromJson(json.decode(str));

  @override
  factory StakeOutput.fromJson(Map<String, dynamic> json) => StakeOutput(
        value: json["value"],
        authorization: KeyedSignature.fromJson(json["authorization"]),
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "value": value.toInt(),
        "authorization": authorization.jsonMap(asHex: asHex),
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  Int64 get value => $_getI64(1);
  @TagNumber(1)
  set value(Int64 v) {
    $_setInt64(0, v);
  }

  @TagNumber(1)
  bool hasValue() => $_has(0);
  @TagNumber(1)
  void clearValue() => clearField(1);

  @TagNumber(2)
  KeyedSignature get authorization => $_getN(2);
  @TagNumber(2)
  set authorization(KeyedSignature v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasAuthorization() => $_has(1);
  @TagNumber(2)
  void clearAuthorization() => clearField(2);
  @TagNumber(2)
  PublicKeyHash ensureAuthorization() => $_ensure(1);
}
