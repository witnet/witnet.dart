part of 'schema.dart';

class Bn256KeyedSignature extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'Bn256KeyedSignature',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..aOM<Bn256Signature>(1, 'signature', subBuilder: Bn256Signature.create)
      ..aOM<Bn256PublicKey>(2, 'publicKey', subBuilder: Bn256PublicKey.create)
      ..hasRequiredFields = false;
  static Bn256KeyedSignature create() => Bn256KeyedSignature._();
  static PbList<Bn256KeyedSignature> createRepeated() => PbList<Bn256KeyedSignature>();
  static Bn256KeyedSignature getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<Bn256KeyedSignature>(create);
  static Bn256KeyedSignature? _defaultInstance;

  Bn256KeyedSignature._() : super();

  @override
  Bn256KeyedSignature createEmptyInstance() => create();

  @override
  Bn256KeyedSignature clone() => Bn256KeyedSignature()..mergeFromMessage(this);

  @override
  Bn256KeyedSignature copyWith(void Function(Bn256KeyedSignature) updates) => super.copyWith((message) => updates(message as Bn256KeyedSignature)) as Bn256KeyedSignature; // ignore: deprecated_member_use

  factory Bn256KeyedSignature({
    Bn256Signature? signature,
    Bn256PublicKey? publicKey,
  }) {
    final _result = create();
    if (signature != null) {
      _result.signature = signature;
    }
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    return _result;
  }

  @override
  factory Bn256KeyedSignature.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  @override
  factory Bn256KeyedSignature.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  Bn256Signature get signature => $_getN(0);
  @TagNumber(1)
  set signature(Bn256Signature v) { setField(1, v); }
  @TagNumber(1)
  bool hasSignature() => $_has(0);
  @TagNumber(1)
  void clearSignature() => clearField(1);
  @TagNumber(1)
  Bn256Signature ensureSignature() => $_ensure(0);

  @TagNumber(2)
  Bn256PublicKey get publicKey => $_getN(1);
  @TagNumber(2)
  set publicKey(Bn256PublicKey v) { setField(2, v); }
  @TagNumber(2)
  bool hasPublicKey() => $_has(1);
  @TagNumber(2)
  void clearPublicKey() => clearField(2);
  @TagNumber(2)
  Bn256PublicKey ensurePublicKey() => $_ensure(1);
}