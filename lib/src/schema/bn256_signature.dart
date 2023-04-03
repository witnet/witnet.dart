part of 'schema.dart';

class Bn256Signature extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Bn256Signature',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<List<int>>(1, 'signature', PbFieldType.OY)
    ..hasRequiredFields = false;

  static Bn256Signature create() => Bn256Signature._();
  static PbList<Bn256Signature> createRepeated() => PbList<Bn256Signature>();
  static Bn256Signature getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<Bn256Signature>(create);
  static Bn256Signature? _defaultInstance;

  Bn256Signature._() : super();

  @override
  Bn256Signature clone() => Bn256Signature()..mergeFromMessage(this);

  @override
  Bn256Signature createEmptyInstance() => create();

  factory Bn256Signature({
    List<int>? signature,
  }) {
    final _result = create();
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }

  @override
  factory Bn256Signature.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory Bn256Signature.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  List<int> get signature => $_getN(0);
  @TagNumber(1)
  set signature(List<int> v) {
    $_setBytes(0, v);
  }

  @TagNumber(1)
  bool hasSignature() => $_has(0);
  @TagNumber(1)
  void clearSignature() => clearField(1);
}
