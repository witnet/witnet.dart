part of 'schema.dart';

class VTTransaction extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('VTTransaction',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<VTTransactionBody>(1, 'body', subBuilder: VTTransactionBody.create)
    ..pc<KeyedSignature>(2, 'signatures', PbFieldType.PM,
        subBuilder: KeyedSignature.create)
    ..hasRequiredFields = false;

  static VTTransaction create() => VTTransaction._();
  static PbList<VTTransaction> createRepeated() => PbList<VTTransaction>();
  static VTTransaction getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<VTTransaction>(create);
  static VTTransaction? _defaultInstance;

  VTTransaction._() : super();

  @override
  VTTransaction clone() => VTTransaction()..mergeFromMessage(this);

  @override
  VTTransaction copyWith(void Function(VTTransaction) updates) =>
      super.copyWith((message) => updates(message as VTTransaction))
          as VTTransaction; // ignore: deprecated_member_use

  @override
  VTTransaction createEmptyInstance() => create();

  factory VTTransaction({
    VTTransactionBody? body,
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

  factory VTTransaction.fromRawJson(String str) =>
      VTTransaction.fromJson(json.decode(str));

  @override
  factory VTTransaction.fromJson(Map<String, dynamic> json) => VTTransaction(
        body: VTTransactionBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  @override
  factory VTTransaction.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "body": body.jsonMap(),
        "signatures":
            List<dynamic>.from(signatures.map((x) => x.jsonMap(asHex: asHex))),
      };

  String get transactionID => bytesToHex(body.hash);

  int get weight => body.weight;

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  VTTransactionBody get body => $_getN(0);
  @TagNumber(1)
  set body(VTTransactionBody v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasBody() => $_has(0);
  @TagNumber(1)
  void clearBody() => clearField(1);
  @TagNumber(1)
  VTTransactionBody ensureBody() => $_ensure(0);

  @TagNumber(2)
  List<KeyedSignature> get signatures => $_getList(1);
}
