part of 'schema.dart';

class PublicKeyHash extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('PublicKeyHash',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<List<int>>(1, 'hash', PbFieldType.OY)
    ..hasRequiredFields = false;

  static PublicKeyHash create() => PublicKeyHash._();
  static PbList<PublicKeyHash> createRepeated() => PbList<PublicKeyHash>();
  static PublicKeyHash getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<PublicKeyHash>(create);
  static PublicKeyHash? _defaultInstance;

  PublicKeyHash._() : super();

  @override
  PublicKeyHash clone() => PublicKeyHash()..mergeFromMessage(this);

  @override
  PublicKeyHash createEmptyInstance() => create();

  factory PublicKeyHash({List<int>? hash}) {
    final _result = create();
    if (hash != null) {
      _result.hash = hash;
    }
    return _result;
  }

  factory PublicKeyHash.fromAddress(String address) =>
      PublicKeyHash(hash: Uint8List.fromList(bech32.decodeAddress(address)));

  @override
  factory PublicKeyHash.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  BuilderInfo get info_ => _i;

  String get hex => bytesToHex(Uint8List.fromList(hash));

  String get address => bech32.encodeAddress('wit', hash);
  String get testnetAddress => bech32.encodeAddress('twit', hash);
  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  List<int> get hash => $_getN(0);
  @TagNumber(1)
  set hash(List<int> v) {
    $_setBytes(0, v);
  }

  @TagNumber(1)
  bool hasHash() => $_has(0);
  @TagNumber(1)
  void clearHash() => clearField(1);
}
