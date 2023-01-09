part of 'schema.dart';

class Secp256k1Signature extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Secp256k1Signature',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<List<int>>(1, 'der', PbFieldType.OY)
    ..hasRequiredFields = false;

  static Secp256k1Signature create() => Secp256k1Signature._();
  static PbList<Secp256k1Signature> createRepeated() =>
      PbList<Secp256k1Signature>();
  static Secp256k1Signature getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<Secp256k1Signature>(create);
  static Secp256k1Signature? _defaultInstance;

  Secp256k1Signature._() : super();

  @override
  Secp256k1Signature clone() => Secp256k1Signature()..mergeFromMessage(this);

  @override
  Secp256k1Signature createEmptyInstance() => create();

  factory Secp256k1Signature({
    List<int>? der,
  }) {
    final _result = create();
    if (der != null) {
      _result.der = der;
    }
    return _result;
  }

  factory Secp256k1Signature.fromRawJson(String str) =>
      Secp256k1Signature.fromJson(json.decode(str));

  @override
  factory Secp256k1Signature.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory Secp256k1Signature.fromJson(Map<String, dynamic> json) =>
      Secp256k1Signature(
        der: (json["der"].runtimeType == String)
            ? hexToBytes(json["der"])
            : List<int>.from(json["der"].map((x) => x)),
      );

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "der": (asHex) ? bytesToHex(Uint8List.fromList(der)) : der.toList(),
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  List<int> get der => $_getN(0);
  @TagNumber(1)
  set der(List<int> v) {
    $_setBytes(0, v);
  }

  @TagNumber(1)
  bool hasDer() => $_has(0);
  @TagNumber(1)
  void clearDer() => clearField(1);
}
