part of 'schema.dart';

class ConsensusConstants extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('ConsensusConstants',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aInt64(1, 'checkpointZeroTimestamp')
    ..a<int>(2, 'checkpointsPeriod', PbFieldType.OU3)
    ..aOM<Hash>(3, 'bootstrapHash', subBuilder: Hash.create)
    ..aOM<Hash>(4, 'genesisHash', subBuilder: Hash.create)
    ..a<int>(5, 'maxVtWeight', PbFieldType.OU3)
    ..a<int>(6, 'maxDrWeight', PbFieldType.OU3)
    ..a<int>(7, 'activityPeriod', PbFieldType.OU3)
    ..a<int>(8, 'reputationExpireAlphaDiff', PbFieldType.OU3)
    ..a<int>(9, 'reputationIssuance', PbFieldType.OU3)
    ..a<int>(10, 'reputationIssuanceStop', PbFieldType.OU3)
    ..a<double>(11, 'reputationPenalizationFactor', PbFieldType.OD)
    ..a<int>(12, 'miningBackupFactor', PbFieldType.OU3)
    ..a<int>(13, 'miningReplicationFactor', PbFieldType.OU3)
    ..a<Int64>(14, 'collateralMinimum', PbFieldType.OU6,
        defaultOrMaker: Int64.ZERO)
    ..a<int>(15, 'collateralAge', PbFieldType.OU3)
    ..a<int>(16, 'superblockPeriod', PbFieldType.OU3)
    ..a<int>(17, 'extraRounds', PbFieldType.OU3)
    ..a<int>(18, 'minimumDifficulty', PbFieldType.OU3)
    ..a<int>(19, 'epochsWithMinimumDifficulty', PbFieldType.OU3)
    ..pPS(20, 'bootstrappingCommittee')
    ..a<int>(21, 'superblockSigningCommitteeSize', PbFieldType.OU3)
    ..a<int>(22, 'superblockCommitteeDecreasingPeriod', PbFieldType.OU3)
    ..a<int>(23, 'superblockCommitteeDecreasingStep', PbFieldType.OU3)
    ..a<Int64>(24, 'initialBlockReward', PbFieldType.OU6,
        defaultOrMaker: Int64.ZERO)
    ..a<int>(25, 'halvingPeriod', PbFieldType.OU3)
    ..hasRequiredFields = false;

  static ConsensusConstants create() => ConsensusConstants._();
  static PbList<ConsensusConstants> createRepeated() =>
      PbList<ConsensusConstants>();
  static ConsensusConstants getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<ConsensusConstants>(create);
  static ConsensusConstants? _defaultInstance;

  ConsensusConstants._() : super();

  @override
  ConsensusConstants clone() => ConsensusConstants()..mergeFromMessage(this);


  @override
  ConsensusConstants createEmptyInstance() => create();

  factory ConsensusConstants({
    Int64? checkpointZeroTimestamp,
    int? checkpointsPeriod,
    Hash? bootstrapHash,
    Hash? genesisHash,
    int? maxVtWeight,
    int? maxDrWeight,
    int? activityPeriod,
    int? reputationExpireAlphaDiff,
    int? reputationIssuance,
    int? reputationIssuanceStop,
    double? reputationPenalizationFactor,
    int? miningBackupFactor,
    int? miningReplicationFactor,
    Int64? collateralMinimum,
    int? collateralAge,
    int? superblockPeriod,
    int? extraRounds,
    int? minimumDifficulty,
    int? epochsWithMinimumDifficulty,
    Iterable<String>? bootstrappingCommittee,
    int? superblockSigningCommitteeSize,
    int? superblockCommitteeDecreasingPeriod,
    int? superblockCommitteeDecreasingStep,
    Int64? initialBlockReward,
    int? halvingPeriod,
  }) {
    final _result = create();
    if (checkpointZeroTimestamp != null) {
      _result.checkpointZeroTimestamp = checkpointZeroTimestamp;
    }
    if (checkpointsPeriod != null) {
      _result.checkpointsPeriod = checkpointsPeriod;
    }
    if (bootstrapHash != null) {
      _result.bootstrapHash = bootstrapHash;
    }
    if (genesisHash != null) {
      _result.genesisHash = genesisHash;
    }
    if (maxVtWeight != null) {
      _result.maxVtWeight = maxVtWeight;
    }
    if (maxDrWeight != null) {
      _result.maxDrWeight = maxDrWeight;
    }
    if (activityPeriod != null) {
      _result.activityPeriod = activityPeriod;
    }
    if (reputationExpireAlphaDiff != null) {
      _result.reputationExpireAlphaDiff = reputationExpireAlphaDiff;
    }
    if (reputationIssuance != null) {
      _result.reputationIssuance = reputationIssuance;
    }
    if (reputationIssuanceStop != null) {
      _result.reputationIssuanceStop = reputationIssuanceStop;
    }
    if (reputationPenalizationFactor != null) {
      _result.reputationPenalizationFactor = reputationPenalizationFactor;
    }
    if (miningBackupFactor != null) {
      _result.miningBackupFactor = miningBackupFactor;
    }
    if (miningReplicationFactor != null) {
      _result.miningReplicationFactor = miningReplicationFactor;
    }
    if (collateralMinimum != null) {
      _result.collateralMinimum = collateralMinimum;
    }
    if (collateralAge != null) {
      _result.collateralAge = collateralAge;
    }
    if (superblockPeriod != null) {
      _result.superblockPeriod = superblockPeriod;
    }
    if (extraRounds != null) {
      _result.extraRounds = extraRounds;
    }
    if (minimumDifficulty != null) {
      _result.minimumDifficulty = minimumDifficulty;
    }
    if (epochsWithMinimumDifficulty != null) {
      _result.epochsWithMinimumDifficulty = epochsWithMinimumDifficulty;
    }
    if (bootstrappingCommittee != null) {
      _result.bootstrappingCommittee.addAll(bootstrappingCommittee);
    }
    if (superblockSigningCommitteeSize != null) {
      _result.superblockSigningCommitteeSize = superblockSigningCommitteeSize;
    }
    if (superblockCommitteeDecreasingPeriod != null) {
      _result.superblockCommitteeDecreasingPeriod =
          superblockCommitteeDecreasingPeriod;
    }
    if (superblockCommitteeDecreasingStep != null) {
      _result.superblockCommitteeDecreasingStep =
          superblockCommitteeDecreasingStep;
    }
    if (initialBlockReward != null) {
      _result.initialBlockReward = initialBlockReward;
    }
    if (halvingPeriod != null) {
      _result.halvingPeriod = halvingPeriod;
    }
    return _result;
  }

  @override
  factory ConsensusConstants.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory ConsensusConstants.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  Int64 get checkpointZeroTimestamp => $_getI64(0);
  @TagNumber(1)
  set checkpointZeroTimestamp(Int64 v) {
    $_setInt64(0, v);
  }

  @TagNumber(1)
  bool hasCheckpointZeroTimestamp() => $_has(0);
  @TagNumber(1)
  void clearCheckpointZeroTimestamp() => clearField(1);

  @TagNumber(2)
  int get checkpointsPeriod => $_getIZ(1);
  @TagNumber(2)
  set checkpointsPeriod(int v) {
    $_setUnsignedInt32(1, v);
  }

  @TagNumber(2)
  bool hasCheckpointsPeriod() => $_has(1);
  @TagNumber(2)
  void clearCheckpointsPeriod() => clearField(2);

  @TagNumber(3)
  Hash get bootstrapHash => $_getN(2);
  @TagNumber(3)
  set bootstrapHash(Hash v) {
    setField(3, v);
  }

  @TagNumber(3)
  bool hasBootstrapHash() => $_has(2);
  @TagNumber(3)
  void clearBootstrapHash() => clearField(3);
  @TagNumber(3)
  Hash ensureBootstrapHash() => $_ensure(2);

  @TagNumber(4)
  Hash get genesisHash => $_getN(3);
  @TagNumber(4)
  set genesisHash(Hash v) {
    setField(4, v);
  }

  @TagNumber(4)
  bool hasGenesisHash() => $_has(3);
  @TagNumber(4)
  void clearGenesisHash() => clearField(4);
  @TagNumber(4)
  Hash ensureGenesisHash() => $_ensure(3);

  @TagNumber(5)
  int get maxVtWeight => $_getIZ(4);
  @TagNumber(5)
  set maxVtWeight(int v) {
    $_setUnsignedInt32(4, v);
  }

  @TagNumber(5)
  bool hasMaxVtWeight() => $_has(4);
  @TagNumber(5)
  void clearMaxVtWeight() => clearField(5);

  @TagNumber(6)
  int get maxDrWeight => $_getIZ(5);
  @TagNumber(6)
  set maxDrWeight(int v) {
    $_setUnsignedInt32(5, v);
  }

  @TagNumber(6)
  bool hasMaxDrWeight() => $_has(5);
  @TagNumber(6)
  void clearMaxDrWeight() => clearField(6);

  @TagNumber(7)
  int get activityPeriod => $_getIZ(6);
  @TagNumber(7)
  set activityPeriod(int v) {
    $_setUnsignedInt32(6, v);
  }

  @TagNumber(7)
  bool hasActivityPeriod() => $_has(6);
  @TagNumber(7)
  void clearActivityPeriod() => clearField(7);

  @TagNumber(8)
  int get reputationExpireAlphaDiff => $_getIZ(7);
  @TagNumber(8)
  set reputationExpireAlphaDiff(int v) {
    $_setUnsignedInt32(7, v);
  }

  @TagNumber(8)
  bool hasReputationExpireAlphaDiff() => $_has(7);
  @TagNumber(8)
  void clearReputationExpireAlphaDiff() => clearField(8);

  @TagNumber(9)
  int get reputationIssuance => $_getIZ(8);
  @TagNumber(9)
  set reputationIssuance(int v) {
    $_setUnsignedInt32(8, v);
  }

  @TagNumber(9)
  bool hasReputationIssuance() => $_has(8);
  @TagNumber(9)
  void clearReputationIssuance() => clearField(9);

  @TagNumber(10)
  int get reputationIssuanceStop => $_getIZ(9);
  @TagNumber(10)
  set reputationIssuanceStop(int v) {
    $_setUnsignedInt32(9, v);
  }

  @TagNumber(10)
  bool hasReputationIssuanceStop() => $_has(9);
  @TagNumber(10)
  void clearReputationIssuanceStop() => clearField(10);

  @TagNumber(11)
  double get reputationPenalizationFactor => $_getN(10);
  @TagNumber(11)
  set reputationPenalizationFactor(double v) {
    $_setDouble(10, v);
  }

  @TagNumber(11)
  bool hasReputationPenalizationFactor() => $_has(10);
  @TagNumber(11)
  void clearReputationPenalizationFactor() => clearField(11);

  @TagNumber(12)
  int get miningBackupFactor => $_getIZ(11);
  @TagNumber(12)
  set miningBackupFactor(int v) {
    $_setUnsignedInt32(11, v);
  }

  @TagNumber(12)
  bool hasMiningBackupFactor() => $_has(11);
  @TagNumber(12)
  void clearMiningBackupFactor() => clearField(12);

  @TagNumber(13)
  int get miningReplicationFactor => $_getIZ(12);
  @TagNumber(13)
  set miningReplicationFactor(int v) {
    $_setUnsignedInt32(12, v);
  }

  @TagNumber(13)
  bool hasMiningReplicationFactor() => $_has(12);
  @TagNumber(13)
  void clearMiningReplicationFactor() => clearField(13);

  @TagNumber(14)
  Int64 get collateralMinimum => $_getI64(13);
  @TagNumber(14)
  set collateralMinimum(Int64 v) {
    $_setInt64(13, v);
  }

  @TagNumber(14)
  bool hasCollateralMinimum() => $_has(13);
  @TagNumber(14)
  void clearCollateralMinimum() => clearField(14);

  @TagNumber(15)
  int get collateralAge => $_getIZ(14);
  @TagNumber(15)
  set collateralAge(int v) {
    $_setUnsignedInt32(14, v);
  }

  @TagNumber(15)
  bool hasCollateralAge() => $_has(14);
  @TagNumber(15)
  void clearCollateralAge() => clearField(15);

  @TagNumber(16)
  int get superblockPeriod => $_getIZ(15);
  @TagNumber(16)
  set superblockPeriod(int v) {
    $_setUnsignedInt32(15, v);
  }

  @TagNumber(16)
  bool hasSuperblockPeriod() => $_has(15);
  @TagNumber(16)
  void clearSuperblockPeriod() => clearField(16);

  @TagNumber(17)
  int get extraRounds => $_getIZ(16);
  @TagNumber(17)
  set extraRounds(int v) {
    $_setUnsignedInt32(16, v);
  }

  @TagNumber(17)
  bool hasExtraRounds() => $_has(16);
  @TagNumber(17)
  void clearExtraRounds() => clearField(17);

  @TagNumber(18)
  int get minimumDifficulty => $_getIZ(17);
  @TagNumber(18)
  set minimumDifficulty(int v) {
    $_setUnsignedInt32(17, v);
  }

  @TagNumber(18)
  bool hasMinimumDifficulty() => $_has(17);
  @TagNumber(18)
  void clearMinimumDifficulty() => clearField(18);

  @TagNumber(19)
  int get epochsWithMinimumDifficulty => $_getIZ(18);
  @TagNumber(19)
  set epochsWithMinimumDifficulty(int v) {
    $_setUnsignedInt32(18, v);
  }

  @TagNumber(19)
  bool hasEpochsWithMinimumDifficulty() => $_has(18);
  @TagNumber(19)
  void clearEpochsWithMinimumDifficulty() => clearField(19);

  @TagNumber(20)
  List<String> get bootstrappingCommittee => $_getList(19);

  @TagNumber(21)
  int get superblockSigningCommitteeSize => $_getIZ(20);
  @TagNumber(21)
  set superblockSigningCommitteeSize(int v) {
    $_setUnsignedInt32(20, v);
  }

  @TagNumber(21)
  bool hasSuperblockSigningCommitteeSize() => $_has(20);
  @TagNumber(21)
  void clearSuperblockSigningCommitteeSize() => clearField(21);

  @TagNumber(22)
  int get superblockCommitteeDecreasingPeriod => $_getIZ(21);
  @TagNumber(22)
  set superblockCommitteeDecreasingPeriod(int v) {
    $_setUnsignedInt32(21, v);
  }

  @TagNumber(22)
  bool hasSuperblockCommitteeDecreasingPeriod() => $_has(21);
  @TagNumber(22)
  void clearSuperblockCommitteeDecreasingPeriod() => clearField(22);

  @TagNumber(23)
  int get superblockCommitteeDecreasingStep => $_getIZ(22);
  @TagNumber(23)
  set superblockCommitteeDecreasingStep(int v) {
    $_setUnsignedInt32(22, v);
  }

  @TagNumber(23)
  bool hasSuperblockCommitteeDecreasingStep() => $_has(22);
  @TagNumber(23)
  void clearSuperblockCommitteeDecreasingStep() => clearField(23);

  @TagNumber(24)
  Int64 get initialBlockReward => $_getI64(23);
  @TagNumber(24)
  set initialBlockReward(Int64 v) {
    $_setInt64(23, v);
  }

  @TagNumber(24)
  bool hasInitialBlockReward() => $_has(23);
  @TagNumber(24)
  void clearInitialBlockReward() => clearField(24);

  @TagNumber(25)
  int get halvingPeriod => $_getIZ(24);
  @TagNumber(25)
  set halvingPeriod(int v) {
    $_setUnsignedInt32(24, v);
  }

  @TagNumber(25)
  bool hasHalvingPeriod() => $_has(24);
  @TagNumber(25)
  void clearHalvingPeriod() => clearField(25);
}
