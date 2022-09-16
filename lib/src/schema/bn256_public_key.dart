part of 'schema.dart';

class Bn256PublicKey extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'Bn256PublicKey',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..a<List<int>>(1, 'publicKey', PbFieldType.OY)
      ..hasRequiredFields = false;

  static Bn256PublicKey create() => Bn256PublicKey._();
  static PbList<Bn256PublicKey> createRepeated() => PbList<Bn256PublicKey>();
  static Bn256PublicKey getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<Bn256PublicKey>(create);
  static Bn256PublicKey? _defaultInstance;



  Bn256PublicKey._() : super();

  @override
  Bn256PublicKey clone() => Bn256PublicKey()..mergeFromMessage(this);

  @override
  Bn256PublicKey createEmptyInstance() => create();

  factory Bn256PublicKey({List<int>? publicKey}) {
    final _result = create();
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    return _result;
  }

  @override
  factory Bn256PublicKey.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  @override
  factory Bn256PublicKey.fromRawJson(String str) => Bn256PublicKey.fromJson(json.decode(str));

  @override
  factory Bn256PublicKey.fromJson(Map<String, dynamic> json) => Bn256PublicKey(
        publicKey: (json["public_key"].runtimeType == String)
            ? hexToBytes(json["public_key"])
            : List<int>.from(json["public_key"].map((x) => x)),
      );


  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));
  Map<String, dynamic> jsonMap({bool asHex = false}) {
    print('Bn256PublicKey');
    return {
      "public_key": (asHex)
          ? bytesToHex(Uint8List.fromList(publicKey))
          : List<dynamic>.from(publicKey.map((x) => x)),
    };
  }

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  List<int> get publicKey => $_getN(0);
  @TagNumber(1)
  set publicKey(List<int> v) { $_setBytes(0, v); }
  @TagNumber(1)
  bool hasPublicKey() => $_has(0);
  @TagNumber(1)
  void clearPublicKey() => clearField(1);
}