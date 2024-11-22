part of 'schema.dart';

class StakeKey extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('StakeOutput',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<PublicKeyHash>(1, 'validator', subBuilder: PublicKeyHash.create)
    ..aOM<PublicKeyHash>(2, 'withdrawer', subBuilder: PublicKeyHash.create)
    ..hasRequiredFields = false;

  static StakeKey create() => StakeKey._();
  static PbList<StakeKey> createRepeated() => PbList<StakeKey>();
  static StakeKey getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<StakeKey>(create);
  static StakeKey? _defaultInstance;
  StakeKey._() : super();

  @override
  GeneratedMessage clone() => StakeKey()..mergeFromMessage(this);

  @override
  GeneratedMessage createEmptyInstance() => create();

  factory StakeKey({
    PublicKeyHash? validator,
    PublicKeyHash? withdrawer,
  }) {
    final _result = create();
    if (validator != null) {
      _result.validator = validator;
    }
    if (withdrawer != null) {
      _result.withdrawer = withdrawer;
    }
    return _result;
  }

  factory StakeKey.fromRawJson(String str) =>
      StakeKey.fromJson(json.decode(str));

  @override
  factory StakeKey.fromJson(Map<String, dynamic> json) => StakeKey(
        validator: PublicKeyHash.fromAddress(json["validator"]),
        withdrawer: PublicKeyHash.fromAddress(json["withdrawer"]),
      );

  Map<String, dynamic> jsonMap({bool asHex = false, bool testnet = false}) => {
        "validator": testnet ? validator.testnetAddress : validator.address,
        "withdrawer": testnet ? withdrawer.testnetAddress : withdrawer.address,
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  PublicKeyHash get validator => $_getN(0);
  @TagNumber(1)
  set validator(PublicKeyHash v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasValidator() => $_has(0);
  @TagNumber(1)
  void clearValidator() => clearField(1);
  @TagNumber(1)
  PublicKeyHash ensureValidator() => $_ensure(0);

  @TagNumber(2)
  PublicKeyHash get withdrawer => $_getN(1);
  @TagNumber(2)
  set withdrawer(PublicKeyHash v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasWithdrawer() => $_has(1);
  @TagNumber(2)
  void clearWithdrawer() => clearField(2);
  @TagNumber(2)
  PublicKeyHash ensureWithdrawer() => $_ensure(1);
}
