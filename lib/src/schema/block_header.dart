part of 'schema.dart';

class BlockHeader extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Block.BlockHeader',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<int>(1, 'signals', PbFieldType.OU3)
    ..aOM<CheckpointBeacon>(2, 'beacon', subBuilder: CheckpointBeacon.create)
    ..aOM<BlockMerkleRoots>(3, 'merkleRoots',
        subBuilder: BlockMerkleRoots.create)
    ..aOM<BlockEligibilityClaim>(4, 'proof',
        subBuilder: BlockEligibilityClaim.create)
    ..aOM<Bn256PublicKey>(5, 'bn256PublicKey',
        subBuilder: Bn256PublicKey.create)
    ..hasRequiredFields = false;

  static BlockHeader create() => BlockHeader._();

  static PbList<BlockHeader> createRepeated() => PbList<BlockHeader>();

  static BlockHeader getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<BlockHeader>(create);

  static BlockHeader? _defaultInstance;

  BlockHeader._() : super();

  @override
  BlockHeader createEmptyInstance() => create();

  @override
  GeneratedMessage clone() => BlockHeader()..mergeFromMessage(this);

  @override
  BuilderInfo get info_ => _i;

  factory BlockHeader({
    int? signals,
    CheckpointBeacon? beacon,
    BlockMerkleRoots? merkleRoots,
    BlockEligibilityClaim? proof,
    Bn256PublicKey? bn256PublicKey,
  }) {
    final _result = create();
    if (signals != null) _result.signals = signals;
    if (beacon != null) _result.beacon = beacon;
    if (merkleRoots != null) _result.merkleRoots = merkleRoots;
    if (proof != null) _result.proof = proof;
    if (bn256PublicKey != null) _result.bn256PublicKey = bn256PublicKey;
    return _result;
  }

  factory BlockHeader.fromRawJson(String str) =>
      BlockHeader.fromJson(json.decode(str));

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory BlockHeader.fromJson(Map<String, dynamic> json) => BlockHeader(
        beacon: CheckpointBeacon.fromJson(json["beacon"]),
        bn256PublicKey: (json["bn256_public_key"] == null)
            ? Bn256PublicKey(publicKey: [])
            : Bn256PublicKey.fromJson(json["bn256_public_key"]),
        merkleRoots: BlockMerkleRoots.fromJson(json["merkle_roots"]),
        proof: BlockEligibilityClaim.fromJson(json["proof"]),
        signals: json["signals"],
      );

  factory BlockHeader.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  Map<String, dynamic> jsonMap({bool asHex = false}) {
    return {
      "beacon": beacon.jsonMap(asHex: asHex),
      "bn256_public_key": bn256PublicKey.jsonMap(asHex: asHex),
      "merkle_roots": merkleRoots.jsonMap(asHex: asHex),
      "proof": proof.jsonMap(asHex: asHex),
      "signals": signals,
    };
  }

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  int get signals => $_getIZ(0);
  @TagNumber(1)
  set signals(int v) {
    $_setUnsignedInt32(0, v);
  }

  @TagNumber(1)
  bool hasSignals() => $_has(0);
  @TagNumber(1)
  void clearSignals() => clearField(1);

  @TagNumber(2)
  CheckpointBeacon get beacon => $_getN(1);
  @TagNumber(2)
  set beacon(CheckpointBeacon v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasBeacon() => $_has(1);
  @TagNumber(2)
  void clearBeacon() => clearField(2);
  @TagNumber(2)
  CheckpointBeacon ensureBeacon() => $_ensure(1);

  @TagNumber(3)
  BlockMerkleRoots get merkleRoots => $_getN(2);
  @TagNumber(3)
  set merkleRoots(BlockMerkleRoots v) {
    setField(3, v);
  }

  @TagNumber(3)
  bool hasMerkleRoots() => $_has(2);
  @TagNumber(3)
  void clearMerkleRoots() => clearField(3);
  @TagNumber(3)
  BlockMerkleRoots ensureMerkleRoots() => $_ensure(2);

  @TagNumber(4)
  BlockEligibilityClaim get proof => $_getN(3);
  @TagNumber(4)
  set proof(BlockEligibilityClaim v) {
    setField(4, v);
  }

  @TagNumber(4)
  bool hasProof() => $_has(3);
  @TagNumber(4)
  void clearProof() => clearField(4);
  @TagNumber(4)
  BlockEligibilityClaim ensureProof() => $_ensure(3);

  @TagNumber(5)
  Bn256PublicKey get bn256PublicKey => $_getN(4);
  @TagNumber(5)
  set bn256PublicKey(Bn256PublicKey v) {
    setField(5, v);
  }

  @TagNumber(5)
  bool hasBn256PublicKey() => $_has(4);
  @TagNumber(5)
  void clearBn256PublicKey() => clearField(5);
  @TagNumber(5)
  Bn256PublicKey ensureBn256PublicKey() => $_ensure(4);
}
