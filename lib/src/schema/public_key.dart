part of 'schema.dart';

class PublicKey extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('PublicKey',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<List<int>>(1, 'publicKey', PbFieldType.OY)
    ..hasRequiredFields = false;

  static PublicKey create() => PublicKey._();
  static PbList<PublicKey> createRepeated() => PbList<PublicKey>();
  static PublicKey getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<PublicKey>(create);
  static PublicKey? _defaultInstance;

  PublicKey._() : super();

  @override
  PublicKey clone() => PublicKey()..mergeFromMessage(this);

  @override
  PublicKey copyWith(void Function(PublicKey) updates) =>
      super.copyWith((message) => updates(message as PublicKey))
          as PublicKey; // ignore: deprecated_member_use

  @override
  PublicKey createEmptyInstance() => create();

  factory PublicKey({
    List<int>? bytes,
  }) {
    final _result = create();
    _result.publicKey = concatBytes([
      (bytes != null) ? Uint8List.fromList([bytes[0]]) : Uint8List.fromList([]),
      Uint8List.fromList(bytes!)
    ]);
    return _result;
  }

  factory PublicKey.fromRawJson(String str) =>
      PublicKey.fromJson(json.decode(str));

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  @override
  factory PublicKey.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory PublicKey.fromJson(Map<String, dynamic> json) => PublicKey(
      bytes: Uint8List.fromList(List<int>.from(json["bytes"].map((x) => x))));

  Map<String, dynamic> jsonMap({bool asHex = false}) {

    if (publicKey.isNotEmpty)
      return {
        "bytes": (asHex)
            ? bytesToHex(Uint8List.fromList(publicKey.sublist(2)))
            : publicKey.sublist(2),
        "compressed": publicKey[0],
      };
    return {};
  }

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  List<int> get publicKey => $_getN(0);
  @TagNumber(1)
  set publicKey(List<int> v) {
    $_setBytes(0, v);
  }

  @TagNumber(1)
  bool hasPublicKey() => $_has(0);
  @TagNumber(1)
  void clearPublicKey() => clearField(1);
}
