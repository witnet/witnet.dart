part of 'schema.dart';

class RevealBody extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('RevealTransactionBody',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<Hash>(1, 'drPointer', subBuilder: Hash.create)
    ..a<List<int>>(2, 'reveal', PbFieldType.OY)
    ..aOM<PublicKeyHash>(3, 'pkh', subBuilder: PublicKeyHash.create)
    ..hasRequiredFields = false;

  static RevealBody create() => RevealBody._();
  static PbList<RevealBody> createRepeated() => PbList<RevealBody>();
  static RevealBody getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<RevealBody>(create);
  static RevealBody? _defaultInstance;

  RevealBody._() : super();

  @override
  RevealBody clone() => RevealBody()..mergeFromMessage(this);

  @override
  RevealBody createEmptyInstance() => create();

  factory RevealBody({
    Hash? drPointer,
    List<int>? reveal,
    PublicKeyHash? pkh,
  }) {
    final _result = create();
    if (drPointer != null) {
      _result.drPointer = drPointer;
    }
    if (reveal != null) {
      _result.reveal = reveal;
    }
    if (pkh != null) {
      _result.pkh = pkh;
    }
    return _result;
  }

  factory RevealBody.fromRawJson(String str) =>
      RevealBody.fromJson(json.decode(str));

  @override
  factory RevealBody.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory RevealBody.fromJson(Map<String, dynamic> json) => RevealBody(
        drPointer: (json["dr_pointer"].runtimeType == String)
            ? Hash.fromString((json["dr_pointer"]))
            : Hash(SHA256: json["dr_pointer"]),
        pkh: PublicKeyHash.fromAddress(json["pkh"]),
        reveal:
            Uint8List.fromList(List<int>.from(json["reveal"].map((x) => x))),
      );

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "dr_pointer": (asHex) ? drPointer.hex : drPointer.bytes,
        "pkh": pkh.address,
        "reveal": (asHex)
            ? bytesToHex(
                Uint8List.fromList(List<int>.from(reveal.map((x) => x))))
            : List<int>.from(reveal.map((x) => x))
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  Hash get drPointer => $_getN(0);
  @TagNumber(1)
  set drPointer(Hash v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasDrPointer() => $_has(0);
  @TagNumber(1)
  void clearDrPointer() => clearField(1);
  @TagNumber(1)
  Hash ensureDrPointer() => $_ensure(0);

  @TagNumber(2)
  List<int> get reveal => $_getN(1);
  @TagNumber(2)
  set reveal(List<int> v) {
    $_setBytes(1, v);
  }

  @TagNumber(2)
  bool hasReveal() => $_has(1);
  @TagNumber(2)
  void clearReveal() => clearField(2);

  @TagNumber(3)
  PublicKeyHash get pkh => $_getN(2);
  @TagNumber(3)
  set pkh(PublicKeyHash v) {
    setField(3, v);
  }

  @TagNumber(3)
  bool hasPkh() => $_has(2);
  @TagNumber(3)
  void clearPkh() => clearField(3);
  @TagNumber(3)
  PublicKeyHash ensurePkh() => $_ensure(2);
}
