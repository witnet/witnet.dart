part of 'schema.dart';

class CheckpointBeacon extends GeneratedMessage {

  static final BuilderInfo _i = BuilderInfo(
      'CheckpointBeacon',
      package: const PackageName('witnet'),
      createEmptyInstance: create)
    ..a<int>(1, 'checkpoint', PbFieldType.OF3)
    ..aOM<Hash>(2, 'hashPrevBlock', subBuilder: Hash.create)
    ..hasRequiredFields = false;

  static CheckpointBeacon create() => CheckpointBeacon._();
  static PbList<CheckpointBeacon> createRepeated() => PbList<CheckpointBeacon>();
  static CheckpointBeacon getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<CheckpointBeacon>(create);
  static CheckpointBeacon? _defaultInstance;

  CheckpointBeacon._() : super();

  @override
  CheckpointBeacon clone() => CheckpointBeacon()..mergeFromMessage(this);

  @override
  CheckpointBeacon createEmptyInstance() => create();

  factory CheckpointBeacon({
    int? checkpoint,
    Hash? hashPrevBlock,
  }) {
    final _result = create();
    if (checkpoint != null) {
      _result.checkpoint = checkpoint;
    }
    if (hashPrevBlock != null) {
      _result.hashPrevBlock = hashPrevBlock;
    }
    return _result;
  }

  @override
  factory CheckpointBeacon.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  factory CheckpointBeacon.fromRawJson(String str) => CheckpointBeacon.fromJson(json.decode(str));

  @override
  factory CheckpointBeacon.fromJson(Map<String, dynamic> json) => CheckpointBeacon(
        checkpoint: json["checkpoint"],
        hashPrevBlock: Hash.fromString(json["hashPrevBlock"]),
      );

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex=false}) {
   print('checkpoint_beacon');
    return {
      "checkpoint"
    : checkpoint,
    "hashPrevBlock": (asHex) ? hashPrevBlock.hex : hashPrevBlock.bytes,
    };
  }

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  int get checkpoint => $_getIZ(0);
  @TagNumber(1)
  set checkpoint(int v) { $_setUnsignedInt32(0, v); }
  @TagNumber(1)
  bool hasCheckpoint() => $_has(0);
  @TagNumber(1)
  void clearCheckpoint() => clearField(1);

  @TagNumber(2)
  Hash get hashPrevBlock => $_getN(1);
  @TagNumber(2)
  set hashPrevBlock(Hash v) { setField(2, v); }
  @TagNumber(2)
  bool hasHashPrevBlock() => $_has(1);
  @TagNumber(2)
  void clearHashPrevBlock() => clearField(2);
  @TagNumber(2)
  Hash ensureHashPrevBlock() => $_ensure(1);


}
