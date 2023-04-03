part of 'schema.dart';

class LastBeacon extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('LastBeacon',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<CheckpointBeacon>(1, 'highestBlockCheckpoint',
        subBuilder: CheckpointBeacon.create)
    ..aOM<CheckpointBeacon>(2, 'highestSuperblockCheckpoint',
        subBuilder: CheckpointBeacon.create)
    ..hasRequiredFields = false;

  static LastBeacon create() => LastBeacon._();
  static PbList<LastBeacon> createRepeated() => PbList<LastBeacon>();
  static LastBeacon getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<LastBeacon>(create);
  static LastBeacon? _defaultInstance;

  LastBeacon._() : super();

  @override
  LastBeacon clone() => LastBeacon()..mergeFromMessage(this);

  @override
  LastBeacon createEmptyInstance() => create();

  factory LastBeacon({
    CheckpointBeacon? highestBlockCheckpoint,
    CheckpointBeacon? highestSuperblockCheckpoint,
  }) {
    final _result = create();
    if (highestBlockCheckpoint != null) {
      _result.highestBlockCheckpoint = highestBlockCheckpoint;
    }
    if (highestSuperblockCheckpoint != null) {
      _result.highestSuperblockCheckpoint = highestSuperblockCheckpoint;
    }
    return _result;
  }

  @override
  factory LastBeacon.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory LastBeacon.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  CheckpointBeacon get highestBlockCheckpoint => $_getN(0);
  @TagNumber(1)
  set highestBlockCheckpoint(CheckpointBeacon v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasHighestBlockCheckpoint() => $_has(0);
  @TagNumber(1)
  void clearHighestBlockCheckpoint() => clearField(1);
  @TagNumber(1)
  CheckpointBeacon ensureHighestBlockCheckpoint() => $_ensure(0);

  @TagNumber(2)
  CheckpointBeacon get highestSuperblockCheckpoint => $_getN(1);
  @TagNumber(2)
  set highestSuperblockCheckpoint(CheckpointBeacon v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasHighestSuperblockCheckpoint() => $_has(1);
  @TagNumber(2)
  void clearHighestSuperblockCheckpoint() => clearField(2);
  @TagNumber(2)
  CheckpointBeacon ensureHighestSuperblockCheckpoint() => $_ensure(1);
}
