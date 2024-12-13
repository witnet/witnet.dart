part of 'schema.dart';

class UnstakeTransaction extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('UnstakeTransaction',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<UnstakeBody>(1, 'body', subBuilder: UnstakeBody.create)
    ..aOM<KeyedSignature>(2, 'signature', subBuilder: KeyedSignature.create)
    ..hasRequiredFields = false;

  static UnstakeTransaction create() => UnstakeTransaction._();
  static PbList<UnstakeTransaction> createRepeated() =>
      PbList<UnstakeTransaction>();
  static UnstakeTransaction getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<UnstakeTransaction>(create);
  static UnstakeTransaction? _defaultInstance;

  UnstakeTransaction._() : super();

  @override
  UnstakeTransaction clone() => UnstakeTransaction()..mergeFromMessage(this);

  @override
  UnstakeTransaction createEmptyInstance() => create();

  factory UnstakeTransaction({
    UnstakeBody? body,
    KeyedSignature? signature,
  }) {
    final _result = create();
    if (body != null) {
      _result.body = body;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }

  factory UnstakeTransaction.fromRawJson(String str) =>
      UnstakeTransaction.fromJson(json.decode(str));

  @override
  factory UnstakeTransaction.fromJson(Map<String, dynamic> json) =>
      UnstakeTransaction(
        body: UnstakeBody.fromJson(json["body"]),
        signature: KeyedSignature.fromJson(json["signature"]),
      );

  @override
  factory UnstakeTransaction.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  String rawJson({bool asHex = false, bool testnet = false}) =>
      json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "body": body.jsonMap(asHex: asHex),
        "signature": signature.jsonMap(asHex: asHex)
      };

  String get transactionID => bytesToHex(body.hash);

  int get weight => body.weight;

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  UnstakeBody get body => $_getN(0);
  @TagNumber(1)
  set body(UnstakeBody v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasBody() => $_has(0);
  @TagNumber(1)
  void clearBody() => clearField(1);
  @TagNumber(1)
  UnstakeBody ensureBody() => $_ensure(0);

  @TagNumber(2)
  KeyedSignature get signature => $_getN(1);

  @TagNumber(2)
  bool hasSignature() => $_has(1);
  @TagNumber(2)
  void clearSignature() => clearField(2);
  @TagNumber(2)
  UnstakeBody ensureSignature() => $_ensure(1);
  @TagNumber(2)
  set signature(KeyedSignature v) {
    setField(2, v);
  }
}
