part of 'schema.dart';

class BlockMerkleRoots extends GeneratedMessage {

  static final BuilderInfo _i = BuilderInfo(
    'Block.BlockHeader.BlockMerkleRoots',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..aOM<Hash>(1, 'mintHash', subBuilder: Hash.create)
      ..aOM<Hash>(2, 'vtHashMerkleRoot', subBuilder: Hash.create)
      ..aOM<Hash>(3, 'drHashMerkleRoot', subBuilder: Hash.create)
      ..aOM<Hash>(4, 'commitHashMerkleRoot', subBuilder: Hash.create)
      ..aOM<Hash>(5, 'revealHashMerkleRoot', subBuilder: Hash.create)
      ..aOM<Hash>(6, 'tallyHashMerkleRoot', subBuilder: Hash.create)
      ..hasRequiredFields = false;


  static BlockMerkleRoots create() => BlockMerkleRoots._();

  static PbList<BlockMerkleRoots> createRepeated() =>
      PbList<BlockMerkleRoots>();

  static BlockMerkleRoots getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<BlockMerkleRoots>(create);

  static BlockMerkleRoots? _defaultInstance;

  BlockMerkleRoots._() : super();

  @override
  BlockMerkleRoots createEmptyInstance() => create();

  @override
  BlockMerkleRoots clone() => BlockMerkleRoots()..mergeFromMessage(this);

  factory BlockMerkleRoots({
    Hash? mintHash,
    Hash? vtHashMerkleRoot,
    Hash? drHashMerkleRoot,
    Hash? commitHashMerkleRoot,
    Hash? revealHashMerkleRoot,
    Hash? tallyHashMerkleRoot,
  }) {
    final _result = create();
    if (mintHash != null) _result.mintHash = mintHash;
    if (vtHashMerkleRoot != null) _result.vtHashMerkleRoot = vtHashMerkleRoot;
    if (drHashMerkleRoot != null) _result.drHashMerkleRoot = drHashMerkleRoot;
    if (commitHashMerkleRoot != null) _result.commitHashMerkleRoot = commitHashMerkleRoot;
    if (revealHashMerkleRoot != null) _result.revealHashMerkleRoot = revealHashMerkleRoot;
    if (tallyHashMerkleRoot != null) _result.tallyHashMerkleRoot = tallyHashMerkleRoot;
    return _result;
  }

  @override
  factory BlockMerkleRoots.fromBuffer(
    List<int> i,
    [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory BlockMerkleRoots.fromRawJson(String str) => BlockMerkleRoots.fromJson(json.decode(str));

  @override
  factory BlockMerkleRoots.fromJson(Map<String, dynamic> json) => BlockMerkleRoots(
    commitHashMerkleRoot: Hash.fromString(json["commit_hash_merkle_root"]),
    drHashMerkleRoot: Hash.fromString(json["dr_hash_merkle_root"]),
    mintHash: Hash.fromString(json["mint_hash"]),
    revealHashMerkleRoot: Hash.fromString(json["reveal_hash_merkle_root"]),
    tallyHashMerkleRoot: Hash.fromString(json["tally_hash_merkle_root"]),
    vtHashMerkleRoot: Hash.fromString(json["vt_hash_merkle_root"]),
  );

  String toRawJson() => json.encode(jsonMap());

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
    "commit_hash_merkle_root": (asHex) ? commitHashMerkleRoot.hex : commitHashMerkleRoot.bytes,
    "dr_hash_merkle_root": (asHex) ? drHashMerkleRoot.hex : drHashMerkleRoot.bytes,
    "mint_hash": (asHex) ? mintHash.hex : mintHash.bytes,
    "reveal_hash_merkle_root": (asHex) ? revealHashMerkleRoot.hex : revealHashMerkleRoot.bytes,
    "tally_hash_merkle_root": (asHex) ? tallyHashMerkleRoot.hex : tallyHashMerkleRoot.bytes,
    "vt_hash_merkle_root": (asHex) ? vtHashMerkleRoot.hex : vtHashMerkleRoot.bytes
  };

  @override
  BuilderInfo get info_ => _i;
  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  Hash get mintHash => $_getN(0);
  @TagNumber(1)
  set mintHash(Hash v) { setField(1, v); }
  @TagNumber(1)
  bool hasMintHash() => $_has(0);
  @TagNumber(1)
  void clearMintHash() => clearField(1);
  @TagNumber(1)
  Hash ensureMintHash() => $_ensure(0);

  @TagNumber(2)
  Hash get vtHashMerkleRoot => $_getN(1);
  @TagNumber(2)
  set vtHashMerkleRoot(Hash v) { setField(2, v); }
  @TagNumber(2)
  bool hasVtHashMerkleRoot() => $_has(1);
  @TagNumber(2)
  void clearVtHashMerkleRoot() => clearField(2);
  @TagNumber(2)
  Hash ensureVtHashMerkleRoot() => $_ensure(1);

  @TagNumber(3)
  Hash get drHashMerkleRoot => $_getN(2);
  @TagNumber(3)
  set drHashMerkleRoot(Hash v) { setField(3, v); }
  @TagNumber(3)
  bool hasDrHashMerkleRoot() => $_has(2);
  @TagNumber(3)
  void clearDrHashMerkleRoot() => clearField(3);
  @TagNumber(3)
  Hash ensureDrHashMerkleRoot() => $_ensure(2);

  @TagNumber(4)
  Hash get commitHashMerkleRoot => $_getN(3);
  @TagNumber(4)
  set commitHashMerkleRoot(Hash v) { setField(4, v); }
  @TagNumber(4)
  bool hasCommitHashMerkleRoot() => $_has(3);
  @TagNumber(4)
  void clearCommitHashMerkleRoot() => clearField(4);
  @TagNumber(4)
  Hash ensureCommitHashMerkleRoot() => $_ensure(3);

  @TagNumber(5)
  Hash get revealHashMerkleRoot => $_getN(4);
  @TagNumber(5)
  set revealHashMerkleRoot(Hash v) { setField(5, v); }
  @TagNumber(5)
  bool hasRevealHashMerkleRoot() => $_has(4);
  @TagNumber(5)
  void clearRevealHashMerkleRoot() => clearField(5);
  @TagNumber(5)
  Hash ensureRevealHashMerkleRoot() => $_ensure(4);

  @TagNumber(6)
  Hash get tallyHashMerkleRoot => $_getN(5);
  @TagNumber(6)
  set tallyHashMerkleRoot(Hash v) { setField(6, v); }
  @TagNumber(6)
  bool hasTallyHashMerkleRoot() => $_has(5);
  @TagNumber(6)
  void clearTallyHashMerkleRoot() => clearField(6);
  @TagNumber(6)
  Hash ensureTallyHashMerkleRoot() => $_ensure(5);
}