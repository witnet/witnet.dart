part of 'schema.dart';

class UnstakeBody extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('UnstakeBody',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<PublicKeyHash>(1, 'operator', subBuilder: PublicKeyHash.create)
    ..aOM<ValueTransferOutput>(2, 'withdrawal',
        subBuilder: ValueTransferOutput.create)
    ..hasRequiredFields = false;

  static UnstakeBody create() => UnstakeBody._();
  static PbList<UnstakeBody> createRepeated() => PbList<UnstakeBody>();
  static UnstakeBody getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<UnstakeBody>(create);
  static UnstakeBody? _defaultInstance;

  UnstakeBody._() : super();

  @override
  UnstakeBody clone() => UnstakeBody()..mergeFromMessage(this);

  @override
  UnstakeBody createEmptyInstance() => create();

  factory UnstakeBody({
    PublicKeyHash? operator,
    ValueTransferOutput? withdrawal,
  }) {
    final _result = create();
    if (operator != null) {
      _result.operator = operator;
    }
    if (withdrawal != null) {
      _result.withdrawal = withdrawal;
    }

    return _result;
  }

  factory UnstakeBody.fromRawJson(String str) =>
      UnstakeBody.fromJson(json.decode(str));

  @override
  factory UnstakeBody.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory UnstakeBody.fromJson(Map<String, dynamic> json) => UnstakeBody(
        operator: PublicKeyHash.fromAddress(json["operator"]),
        withdrawal: ValueTransferOutput.fromJson(json["withdrawal"]),
      );

  factory UnstakeBody.fromPbBytes(Uint8List buffer) =>
      create()..mergeFromBuffer(buffer, ExtensionRegistry.EMPTY);

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "operator": operator.address,
        "withdrawal": withdrawal.jsonMap(asHex: asHex),
      };

  Uint8List get pbBytes => writeToBuffer();

  Uint8List get hash => sha256(data: pbBytes);

  // VT_weight = 153
  int get weight => UNSTAKE_OUTPUT_WEIGHT;

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  PublicKeyHash get operator => $_getN(0);
  @TagNumber(1)
  set operator(PublicKeyHash v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasOperator() => $_has(0);
  @TagNumber(1)
  void clearOperator() => clearField(1);
  @TagNumber(1)
  PublicKeyHash ensureOperator() => $_ensure(0);

  @TagNumber(2)
  ValueTransferOutput get withdrawal => $_getN(1);
  @TagNumber(2)
  set withdrawal(ValueTransferOutput v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasWithdrawal() => $_has(1);
  @TagNumber(2)
  void clearWithdrawal() => clearField(2);
  @TagNumber(2)
  ValueTransferOutput ensureWithdrawal() => $_ensure(1);
}
