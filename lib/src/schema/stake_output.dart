part of 'schema.dart';

class StakeOutput extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('StakeOutput',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<Int64>(1, 'value', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..aOM<PublicKeyHash>(2, 'key', subBuilder: PublicKeyHash.create)
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
    PublicKeyHash? key,
    KeyedSignature? authorization,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = Int64(value);
    }

    if (key != null) {
      _result.key = key;
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

        key: PublicKeyHash.fromAddress(json["key"]),
        authorization: KeyedSignature.fromJson(json["authorization"]),
      );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "value": value.toInt(),
        "key": key.address,
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
  PublicKeyHash get key => $_getN(2);
  @TagNumber(2)
  set key(PublicKeyHash v) {

    setField(2, v);
  }

  @TagNumber(2)
  bool hasKey() => $_has(1);
  @TagNumber(2)
  void clearKey() => clearField(2);
  @TagNumber(2)
  PublicKeyHash ensureKey() => $_ensure(1);

  @TagNumber(3)
  KeyedSignature get authorization => $_getN(3);
  @TagNumber(3)
  set authorization(KeyedSignature v) {
    setField(3, v);
  }

  @TagNumber(3)
  bool hasAuthorization() => $_has(2);
  @TagNumber(3)
  void clearAuthorization() => clearField(3);
  @TagNumber(3)
  PublicKeyHash ensureAuthorization() => $_ensure(2);

}
