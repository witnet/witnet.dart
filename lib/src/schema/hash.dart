part of 'schema.dart';

enum Hash_Kind { SHA256, notSet }

class Hash extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Hash',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..oo(0, [1])
    ..a<List<int>>(1, 'SHA256', PbFieldType.OY, protoName: 'SHA256')
    ..hasRequiredFields = false;

  static const Map<int, Hash_Kind> _Hash_KindByTag = {
    1: Hash_Kind.SHA256,
    0: Hash_Kind.notSet,
  };

  static Hash create() => Hash._();
  static PbList<Hash> createRepeated() => PbList<Hash>();
  static Hash getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<Hash>(create);
  static Hash? _defaultInstance;

  Hash._() : super();

  @override
  Hash createEmptyInstance() => create();

  @override
  Hash clone() {
    throw UnimplementedError();
  }

  factory Hash({
    List<int>? SHA256,
  }) {
    final _result = create();
    if (SHA256 != null) {
      _result.SHA256 = SHA256;
    }
    return _result;
  }

  @override
  factory Hash.fromString(String string) =>
      Hash(SHA256: hexToBytes(string).toList());

  @override
  factory Hash.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  BuilderInfo get info_ => _i;

  Uint8List get bytes => Uint8List.fromList(SHA256);

  Uint8List get pbBytes => writeToBuffer();

  String get hex => bytesToHex(this.bytes);

  String toString() => 'Hash(SHA256: ${this.bytes})';

  Hash_Kind whichKind() => _Hash_KindByTag[$_whichOneof(0)]!;

  void clearKind() => clearField($_whichOneof(0));

  @TagNumber(1)
  List<int> get SHA256 => $_getN(0);
  @TagNumber(1)
  set SHA256(List<int> v) {
    $_setBytes(0, v);
  }

  @TagNumber(1)
  bool hasSHA256() => $_has(0);
  @TagNumber(1)
  void clearSHA256() => clearField(1);
}
