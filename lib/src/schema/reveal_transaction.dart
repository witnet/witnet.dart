part of 'schema.dart';

class RevealTransaction extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'RevealTransaction',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..aOM<RevealBody>(1, 'body', subBuilder: RevealBody.create)
      ..pc<KeyedSignature>(2, 'signatures', PbFieldType.PM, subBuilder: KeyedSignature.create)
      ..hasRequiredFields = false;

  static RevealTransaction create() => RevealTransaction._();
  static PbList<RevealTransaction> createRepeated() => PbList<RevealTransaction>();
  static RevealTransaction getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<RevealTransaction>(create);
  static RevealTransaction? _defaultInstance;

  RevealTransaction._() : super();

  @override
  RevealTransaction clone() => RevealTransaction()..mergeFromMessage(this);

  @override
  RevealTransaction copyWith(void Function(RevealTransaction) updates) => super.copyWith((message) => updates(message as RevealTransaction)) as RevealTransaction; // ignore: deprecated_member_use

  @override
  RevealTransaction createEmptyInstance() => create();

  factory RevealTransaction({RevealBody? body, Iterable<KeyedSignature>? signatures}) {
    final _result = create();
    if (body != null) {
      _result.body = body;
    }
    if (signatures != null) {
      _result.signatures.addAll(signatures);
    }
    return _result;
  }

  factory RevealTransaction.fromRawJson(String str) => RevealTransaction.fromJson(json.decode(str));

  @override
  factory RevealTransaction.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  @override
  factory RevealTransaction.fromJson(Map<String, dynamic> json) => RevealTransaction(
    body: RevealBody.fromJson(json["body"]),
    signatures: List<KeyedSignature>.from(
        json["signatures"].map((x) => KeyedSignature.fromJson(x))),
  );

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) {
    print('reveal');
    return {
      "body": body.jsonMap(asHex: asHex),
      "signatures": List<dynamic>.from(
          signatures.map((x) => x.jsonMap(asHex: asHex))),
    };
  }

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  RevealBody get body => $_getN(0);
  @TagNumber(1)
  set body(RevealBody v) { setField(1, v); }
  @TagNumber(1)
  bool hasBody() => $_has(0);
  @TagNumber(1)
  void clearBody() => clearField(1);
  @TagNumber(1)
  RevealBody ensureBody() => $_ensure(0);

  @TagNumber(2)
  List<KeyedSignature> get signatures => $_getList(1);
}
