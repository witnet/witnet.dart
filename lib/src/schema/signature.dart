part of 'schema.dart';

enum SignatureKind { secp256k1, notSet }

class Signature extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Signature',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<Secp256k1Signature>(1, 'Secp256k1',
        protoName: 'Secp256k1', subBuilder: Secp256k1Signature.create)
    ..hasRequiredFields = false;

  static Signature create() => Signature._();
  static PbList<Signature> createRepeated() => PbList<Signature>();
  static Signature getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<Signature>(create);
  static Signature? _defaultInstance;

  Signature._() : super();

  @override
  Signature clone() => Signature()..mergeFromMessage(this);

  @override
  Signature createEmptyInstance() => create();

  factory Signature({
    Secp256k1Signature? secp256k1,
  }) {
    final _result = create();
    if (secp256k1 != null) {
      _result.secp256k1 = secp256k1;
    }
    return _result;
  }

  factory Signature.fromRawJson(String str) =>
      Signature.fromJson(json.decode(str));

  @override
  factory Signature.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory Signature.fromJson(Map<String, dynamic> json) => Signature(
        secp256k1: Secp256k1Signature.fromJson(json["Secp256k1"]),
      );

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));
  Map<String, dynamic> jsonMap({bool asHex = false}) {
    if (secp256k1.pbBytes.isNotEmpty)
      return {
        "Secp256k1": secp256k1.jsonMap(asHex: asHex),
      };
    return {};
  }

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  Secp256k1Signature get secp256k1 => $_getN(0);
  @TagNumber(1)
  set secp256k1(Secp256k1Signature v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasSecp256k1() => $_has(0);
  @TagNumber(1)
  void clearSecp256k1() => clearField(1);
  @TagNumber(1)
  Secp256k1Signature ensureSecp256k1() => $_ensure(0);
}
