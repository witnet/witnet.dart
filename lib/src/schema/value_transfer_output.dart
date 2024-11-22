part of 'schema.dart';

class ValueTransferOutput extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('ValueTransferOutput',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<PublicKeyHash>(1, 'pkh', subBuilder: PublicKeyHash.create)
    ..a<Int64>(2, 'value', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..a<Int64>(3, 'timeLock', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..hasRequiredFields = false;

  static ValueTransferOutput create() => ValueTransferOutput._();
  static PbList<ValueTransferOutput> createRepeated() =>
      PbList<ValueTransferOutput>();
  static ValueTransferOutput getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<ValueTransferOutput>(create);
  static ValueTransferOutput? _defaultInstance;

  ValueTransferOutput._() : super();

  @override
  ValueTransferOutput clone() => ValueTransferOutput()..mergeFromMessage(this);

  @override
  ValueTransferOutput createEmptyInstance() => create();

  factory ValueTransferOutput({PublicKeyHash? pkh, int? value, int? timeLock}) {
    final _result = create();
    if (pkh != null) {
      _result.pkh = pkh;
    }
    if (value != null) {
      _result.value = Int64(value);
    }
    if (timeLock != null) {
      _result.timeLock = Int64(timeLock);
    }
    return _result;
  }

  factory ValueTransferOutput.fromRawJson(String str) =>
      ValueTransferOutput.fromJson(json.decode(str));

  @override
  factory ValueTransferOutput.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory ValueTransferOutput.fromJson(Map<String, dynamic> json) =>
      ValueTransferOutput(
        pkh: PublicKeyHash.fromAddress(json["pkh"]),
        timeLock: json["time_lock"],
        value: json["value"],
      );

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false, testnet = false}) => {
        "pkh": testnet ? pkh.testnetAddress : pkh.address,
        "time_lock": timeLock.toInt(),
        "value": value.toInt(),
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  PublicKeyHash get pkh => $_getN(0);
  @TagNumber(1)
  set pkh(PublicKeyHash v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasPkh() => $_has(0);
  @TagNumber(1)
  void clearPkh() => clearField(1);
  @TagNumber(1)
  PublicKeyHash ensurePkh() => $_ensure(0);

  @TagNumber(2)
  Int64 get value => $_getI64(1);
  @TagNumber(2)
  set value(Int64 v) {
    $_setInt64(1, v);
  }

  @TagNumber(2)
  bool hasValue() => $_has(1);
  @TagNumber(2)
  void clearValue() => clearField(2);

  @TagNumber(3)
  Int64 get timeLock => $_getI64(2);
  @TagNumber(3)
  set timeLock(Int64 v) {
    (v == Int64.ZERO) ? null : $_setInt64(2, v);
  }

  @TagNumber(3)
  bool hasTimeLock() => $_has(2);
  @TagNumber(3)
  void clearTimeLock() => clearField(3);
}
