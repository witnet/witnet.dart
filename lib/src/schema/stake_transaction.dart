part of 'schema.dart';

class StakeTransaction extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('StakeTransaction',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<StakeBody>(1, 'body', subBuilder: StakeBody.create)
    ..pc<KeyedSignature>(2, 'signatures', PbFieldType.PM,
        subBuilder: KeyedSignature.create)
    ..hasRequiredFields = false;

  static StakeTransaction create() => StakeTransaction._();
  static PbList<StakeTransaction> createRepeated() =>
      PbList<StakeTransaction>();
  static StakeTransaction getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<StakeTransaction>(create);
  static StakeTransaction? _defaultInstance;

  StakeTransaction._() : super();

  @override
  StakeTransaction clone() => StakeTransaction()..mergeFromMessage(this);

  @override
  StakeTransaction createEmptyInstance() => create();

  factory StakeTransaction({
    StakeBody? body,
    Iterable<KeyedSignature>? signatures,
  }) {
    final _result = create();
    if (body != null) {
      _result.body = body;
    }
    if (signatures != null) {
      _result.signatures.addAll(signatures);
    }
    return _result;
  }

  factory StakeTransaction.fromRawJson(String str) =>
      StakeTransaction.fromJson(json.decode(str));

  @override
  factory StakeTransaction.fromJson(Map<String, dynamic> json) =>
      StakeTransaction(
        body: StakeBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  @override
  factory StakeTransaction.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false, bool testnet = false}) => {
        "body": body.jsonMap(asHex: asHex, testnet: testnet),
        "signatures":
            List<dynamic>.from(signatures.map((x) => x.jsonMap(asHex: asHex))),
      };

  String get transactionID => bytesToHex(body.hash);

  int get weight => body.weight;

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  StakeBody get body => $_getN(0);
  @TagNumber(1)
  set body(StakeBody v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasBody() => $_has(0);
  @TagNumber(1)
  void clearBody() => clearField(1);
  @TagNumber(1)
  StakeBody ensureBody() => $_ensure(0);

  @TagNumber(2)
  List<KeyedSignature> get signatures => $_getList(1);
}
