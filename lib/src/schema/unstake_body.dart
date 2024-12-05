part of 'schema.dart';

class UnstakeBody extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('UnstakeBody',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<PublicKeyHash>(1, 'operator', subBuilder: PublicKeyHash.create)
    ..aOM<ValueTransferOutput>(2, 'withdrawal',
        subBuilder: ValueTransferOutput.create)
    ..a<Int64>(3, 'fee', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..a<Int64>(4, 'nonce', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..hasRequiredFields = false;

  static UnstakeBody create() => UnstakeBody._();
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
    int? fee,
    int? nonce,
  }) {
    final _result = create();
    if (operator != null) {
      _result.operator = operator;
    }
    if (withdrawal != null) {
      _result.withdrawal = withdrawal;
    }
    if (fee != null) {
      _result.fee = Int64(fee);
    }
    if (nonce != null) {
      _result.nonce = Int64(nonce);
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
        fee: int.parse(json["fee"]),
        nonce: int.parse(json["nonce"]),
      );

  factory UnstakeBody.fromPbBytes(Uint8List buffer) =>
      create()..mergeFromBuffer(buffer, ExtensionRegistry.EMPTY);

  String toRawJson({bool asHex = false, bool testnet = false}) =>
      json.encode(jsonMap(
        asHex: asHex,
        testnet: testnet,
      ));

  Map<String, dynamic> jsonMap({bool asHex = false, bool testnet = false}) => {
        "operator": testnet ? operator.testnetAddress : operator.address,
        "withdrawal": withdrawal.jsonMap(asHex: asHex, testnet: testnet),
        "fee": fee.toInt(),
        "nonce": nonce.toInt(),
      };

  Uint8List get pbBytes => writeToBuffer();

  Uint8List get hash => sha256(data: pbBytes);

  // VT_weight = 153
  int get weight => UNSTAKE_OUTPUT_WEIGHT;

  @override
  BuilderInfo get info_ => _i;

  /// operator
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

  /// withdrawal
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

  @TagNumber(3)
  Int64 get fee => $_getI64(2);
  @TagNumber(3)
  set fee(Int64 v) {
    (v == Int64.ZERO) ? null : $_setInt64(2, v);
  }

  @TagNumber(3)
  bool hasFee() => $_has(2);
  @TagNumber(3)
  void clearFee() => clearField(3);

  @TagNumber(4)
  Int64 get nonce => $_getI64(3);
  @TagNumber(4)
  set nonce(Int64 v) {
    $_setInt64(3, v);
  }

  @TagNumber(4)
  bool hasNonce() => $_has(3);
  @TagNumber(4)
  void clearNonce() => clearField(4);
}
