part of 'schema.dart';

class DataRequestVrfMessage extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('DataRequestVrfMessage',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<CheckpointVRF>(1, 'vrfInput', subBuilder: CheckpointVRF.create)
    ..aOM<Hash>(2, 'drHash', subBuilder: Hash.create)
    ..hasRequiredFields = false;

  static DataRequestVrfMessage create() => DataRequestVrfMessage._();
  static PbList<DataRequestVrfMessage> createRepeated() =>
      PbList<DataRequestVrfMessage>();
  static DataRequestVrfMessage getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<DataRequestVrfMessage>(create);
  static DataRequestVrfMessage? _defaultInstance;

  DataRequestVrfMessage._() : super();

  @override
  DataRequestVrfMessage clone() =>
      DataRequestVrfMessage()..mergeFromMessage(this);

  @override
  DataRequestVrfMessage createEmptyInstance() => create();

  factory DataRequestVrfMessage({
    CheckpointVRF? vrfInput,
    Hash? drHash,
  }) {
    final _result = create();
    if (vrfInput != null) {
      _result.vrfInput = vrfInput;
    }
    if (drHash != null) {
      _result.drHash = drHash;
    }
    return _result;
  }

  @override
  factory DataRequestVrfMessage.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory DataRequestVrfMessage.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  CheckpointVRF get vrfInput => $_getN(0);
  @TagNumber(1)
  set vrfInput(CheckpointVRF v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasVrfInput() => $_has(0);
  @TagNumber(1)
  void clearVrfInput() => clearField(1);
  @TagNumber(1)
  CheckpointVRF ensureVrfInput() => $_ensure(0);

  @TagNumber(2)
  Hash get drHash => $_getN(1);
  @TagNumber(2)
  set drHash(Hash v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasDrHash() => $_has(1);
  @TagNumber(2)
  void clearDrHash() => clearField(2);
  @TagNumber(2)
  Hash ensureDrHash() => $_ensure(1);
}
