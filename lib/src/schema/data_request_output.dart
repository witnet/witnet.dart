part of 'schema.dart';

class DataRequestOutput extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('DataRequestOutput',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<RADRequest>(1, 'dataRequest', subBuilder: RADRequest.create)
    ..a<Int64>(2, 'witnessReward', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..a<int>(3, 'witnesses', PbFieldType.OU3)
    ..a<Int64>(4, 'commitAndRevealFee', PbFieldType.OU6,
        defaultOrMaker: Int64.ZERO)
    ..a<int>(5, 'minConsensusPercentage', PbFieldType.OU3)
    ..a<Int64>(6, 'collateral', PbFieldType.OU6, defaultOrMaker: Int64.ZERO)
    ..hasRequiredFields = false;

  static DataRequestOutput create() => DataRequestOutput._();
  static PbList<DataRequestOutput> createRepeated() =>
      PbList<DataRequestOutput>();
  static DataRequestOutput getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<DataRequestOutput>(create);
  static DataRequestOutput? _defaultInstance;

  DataRequestOutput._() : super();

  @override
  DataRequestOutput clone() => DataRequestOutput()..mergeFromMessage(this);

  @override
  DataRequestOutput createEmptyInstance() => create();

  factory DataRequestOutput({
    RADRequest? dataRequest,
    int? witnessReward,
    int? witnesses,
    int? commitAndRevealFee,
    int? minConsensusPercentage,
    int? collateral,
  }) {
    final _result = create();
    if (dataRequest != null) {
      _result.dataRequest = dataRequest;
    }
    if (witnessReward != null) {
      _result.witnessReward = Int64(witnessReward);
    }
    if (witnesses != null) {
      _result.witnesses = witnesses;
    }
    if (commitAndRevealFee != null) {
      _result.commitAndRevealFee = Int64(commitAndRevealFee);
    }
    if (minConsensusPercentage != null) {
      _result.minConsensusPercentage = minConsensusPercentage;
    }
    if (collateral != null) {
      _result.collateral = Int64(collateral);
    }
    return _result;
  }

  factory DataRequestOutput.fromRawJson(String str) =>
      DataRequestOutput.fromJson(json.decode(str));

  @override
  factory DataRequestOutput.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory DataRequestOutput.fromJson(Map<String, dynamic> json) =>
      DataRequestOutput(
        collateral: json["collateral"],
        commitAndRevealFee: json["commit_and_reveal_fee"],
        dataRequest: RADRequest.fromJson(json["data_request"]),
        minConsensusPercentage: json["min_consensus_percentage"],
        witnessReward: json["witness_reward"],
        witnesses: json["witnesses"],
      );

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "collateral": collateral.toInt(),
        "commit_and_reveal_fee": commitAndRevealFee.toInt(),
        "data_request": dataRequest.jsonMap(asHex: asHex),
        "min_consensus_percentage": minConsensusPercentage,
        "witness_reward": witnessReward.toInt(),
        "witnesses": witnesses,
      };

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  Uint8List get hash => sha256(data: pbBytes);

  /// Returns the DataRequestOutput weight
  /// Witness reward: 8 bytes
  /// Witnesses: 2 bytes
  /// commit_and_reveal_fee: 8 bytes
  /// min_consensus_percentage: 4 bytes
  /// collateral: 8 bytes
  int get weight => dataRequest.weight + 8 + 2 + 8 + 4 + 8;

  /// Data Request extra weight related by commits, reveals and tally
  int get extraWeight {
    final commitsWeight = witnesses * COMMIT_WEIGHT;
    final revealsWeight = witnesses * REVEAL_WEIGHT * BETA;
    final tallyOutputsWeight = witnesses * OUTPUT_SIZE;
    final tallyWeight = TALLY_WEIGHT * BETA + tallyOutputsWeight;
    return commitsWeight + revealsWeight + tallyWeight;
  }

  @TagNumber(1)
  RADRequest get dataRequest => $_getN(0);
  @TagNumber(1)
  set dataRequest(RADRequest v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasDataRequest() => $_has(0);
  @TagNumber(1)
  void clearDataRequest() => clearField(1);
  @TagNumber(1)
  RADRequest ensureDataRequest() => $_ensure(0);

  @TagNumber(2)
  Int64 get witnessReward => $_getI64(1);
  @TagNumber(2)
  set witnessReward(Int64 v) {
    $_setInt64(1, v);
  }

  @TagNumber(2)
  bool hasWitnessReward() => $_has(1);
  @TagNumber(2)
  void clearWitnessReward() => clearField(2);

  @TagNumber(3)
  int get witnesses => $_getIZ(2);
  @TagNumber(3)
  set witnesses(int v) {
    $_setUnsignedInt32(2, v);
  }

  @TagNumber(3)
  bool hasWitnesses() => $_has(2);
  @TagNumber(3)
  void clearWitnesses() => clearField(3);

  @TagNumber(4)
  Int64 get commitAndRevealFee => $_getI64(3);
  @TagNumber(4)
  set commitAndRevealFee(Int64 v) {
    $_setInt64(3, v);
  }

  @TagNumber(4)
  bool hasCommitAndRevealFee() => $_has(3);
  @TagNumber(4)
  void clearCommitAndRevealFee() => clearField(4);

  @TagNumber(5)
  int get minConsensusPercentage => $_getIZ(4);
  @TagNumber(5)
  set minConsensusPercentage(int v) {
    $_setUnsignedInt32(4, v);
  }

  @TagNumber(5)
  bool hasMinConsensusPercentage() => $_has(4);
  @TagNumber(5)
  void clearMinConsensusPercentage() => clearField(5);

  @TagNumber(6)
  Int64 get collateral => $_getI64(5);
  @TagNumber(6)
  set collateral(Int64 v) {
    $_setInt64(5, v);
  }

  @TagNumber(6)
  bool hasCollateral() => $_has(5);
  @TagNumber(6)
  void clearCollateral() => clearField(6);
}
