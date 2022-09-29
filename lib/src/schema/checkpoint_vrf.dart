part of 'schema.dart';

class CheckpointVRF extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('CheckpointVRF',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<int>(1, 'checkpoint', PbFieldType.OF3)
    ..aOM<Hash>(2, 'hashPrevVrf', subBuilder: Hash.create)
    ..hasRequiredFields = false;

  static CheckpointVRF create() => CheckpointVRF._();
  static PbList<CheckpointVRF> createRepeated() => PbList<CheckpointVRF>();
  static CheckpointVRF getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<CheckpointVRF>(create);
  static CheckpointVRF? _defaultInstance;

  CheckpointVRF._() : super();

  @override
  CheckpointVRF createEmptyInstance() => create();

  @override
  CheckpointVRF clone() => CheckpointVRF()..mergeFromMessage(this);

  @override
  CheckpointVRF copyWith(void Function(CheckpointVRF) updates) =>
      super.copyWith((message) => updates(message as CheckpointVRF))
          as CheckpointVRF; // ignore: deprecated_member_use

  factory CheckpointVRF({
    int? checkpoint,
    Hash? hashPrevVrf,
  }) {
    final _result = create();
    if (checkpoint != null) {
      _result.checkpoint = checkpoint;
    }
    if (hashPrevVrf != null) {
      _result.hashPrevVrf = hashPrevVrf;
    }
    return _result;
  }

  @override
  factory CheckpointVRF.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory CheckpointVRF.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  int get checkpoint => $_getIZ(0);
  @TagNumber(1)
  set checkpoint(int v) {
    $_setUnsignedInt32(0, v);
  }

  @TagNumber(1)
  bool hasCheckpoint() => $_has(0);
  @TagNumber(1)
  void clearCheckpoint() => clearField(1);

  @TagNumber(2)
  Hash get hashPrevVrf => $_getN(1);
  @TagNumber(2)
  set hashPrevVrf(Hash v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasHashPrevVrf() => $_has(1);
  @TagNumber(2)
  void clearHashPrevVrf() => clearField(2);
  @TagNumber(2)
  Hash ensureHashPrevVrf() => $_ensure(1);
}
