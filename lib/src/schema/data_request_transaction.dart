part of 'schema.dart';

class DRTransaction extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('DRTransaction',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<DRTransactionBody>(1, 'body', subBuilder: DRTransactionBody.create)
    ..pc<KeyedSignature>(2, 'signatures', PbFieldType.PM,
        subBuilder: KeyedSignature.create)
    ..hasRequiredFields = false;

  static DRTransaction create() => DRTransaction._();
  static PbList<DRTransaction> createRepeated() => PbList<DRTransaction>();
  static DRTransaction getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<DRTransaction>(create);
  static DRTransaction? _defaultInstance;

  DRTransaction._() : super();

  @override
  DRTransaction clone() => DRTransaction()..mergeFromMessage(this);

  @override
  DRTransaction createEmptyInstance() => create();

  factory DRTransaction({
    DRTransactionBody? body,
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

  factory DRTransaction.fromRawJson(String str) =>
      DRTransaction.fromJson(json.decode(str));

  @override
  factory DRTransaction.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory DRTransaction.fromJson(Map<String, dynamic> json) => DRTransaction(
        body: DRTransactionBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false, bool testnet = false}) {
    return {
      "DataRequest": {
        "body": body.jsonMap(asHex: asHex, testnet: testnet),
        "signatures":
            List<dynamic>.from(signatures.map((x) => x.jsonMap(asHex: asHex))),
      }
    };
  }

  @override
  BuilderInfo get info_ => _i;

  String get transactionID => bytesToHex(body.hash);
  int get weight => body.weight;
  void printDebug() {
    body.drOutput.dataRequest.retrieve.forEach((element) {
      print(element.url);
    });
  }

  @TagNumber(1)
  DRTransactionBody get body => $_getN(0);
  @TagNumber(1)
  set body(DRTransactionBody v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasBody() => $_has(0);
  @TagNumber(1)
  void clearBody() => clearField(1);
  @TagNumber(1)
  DRTransactionBody ensureBody() => $_ensure(0);

  @TagNumber(2)
  List<KeyedSignature> get signatures => $_getList(1);
}
