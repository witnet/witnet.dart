part of 'schema.dart';

class CommitTransaction extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('CommitTransaction',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<CommitBody>(1, 'body', subBuilder: CommitBody.create)
    ..pc<KeyedSignature>(2, 'signatures', PbFieldType.PM,
        subBuilder: KeyedSignature.create)
    ..hasRequiredFields = false;

  static CommitTransaction create() => CommitTransaction._();
  static PbList<CommitTransaction> createRepeated() =>
      PbList<CommitTransaction>();
  static CommitTransaction getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<CommitTransaction>(create);
  static CommitTransaction? _defaultInstance;

  CommitTransaction._() : super();

  @override
  CommitTransaction clone() => CommitTransaction()..mergeFromMessage(this);

  @override
  CommitTransaction createEmptyInstance() => create();

  factory CommitTransaction({
    CommitBody? body,
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

  factory CommitTransaction.fromRawJson(String str) =>
      CommitTransaction.fromJson(json.decode(str));

  @override
  factory CommitTransaction.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory CommitTransaction.fromJson(Map<String, dynamic> json) =>
      CommitTransaction(
        body: CommitBody.fromJson(json["body"]),
        signatures: List<KeyedSignature>.from(
            json["signatures"].map((x) => KeyedSignature.fromJson(x))),
      );

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "body": body.jsonMap(asHex: asHex),
        "signatures":
            List<dynamic>.from(signatures.map((x) => x.jsonMap(asHex: asHex))),
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  CommitBody get body => $_getN(0);
  @TagNumber(1)
  set body(CommitBody v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasBody() => $_has(0);
  @TagNumber(1)
  void clearBody() => clearField(1);
  @TagNumber(1)
  CommitBody ensureBody() => $_ensure(0);

  @TagNumber(2)
  List<KeyedSignature> get signatures => $_getList(1);
}
