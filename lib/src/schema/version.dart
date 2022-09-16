part of 'schema.dart';

class Version extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'Version',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..a<int>(1, 'version', PbFieldType.OU3)
      ..aInt64(2, 'timestamp')
      ..a<Int64>(3, 'capabilities', PbFieldType.OF6, defaultOrMaker: Int64.ZERO)
      ..aOM<PeerAddress>(4, 'senderAddress', subBuilder: PeerAddress.create)
      ..aOM<PeerAddress>(5, 'receiverAddress', subBuilder: PeerAddress.create)
      ..aOS(6, 'userAgent')
      ..a<Int64>(7, 'nonce', PbFieldType.OF6, defaultOrMaker: Int64.ZERO)
      ..aOM<LastBeacon>(8, 'beacon', subBuilder: LastBeacon.create)
      ..hasRequiredFields = false;

  static Version create() => Version._();
  static PbList<Version> createRepeated() => PbList<Version>();
  static Version getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<Version>(create);
  static Version? _defaultInstance;

  Version._() : super();

  @override
  Version clone() => Version()..mergeFromMessage(this);

  @override
  Version copyWith(void Function(Version) updates) => super.copyWith((message) => updates(message as Version)) as Version;

  @override
  Version createEmptyInstance() => create();

  factory Version({
    int? version,
    Int64? timestamp,
    Int64? capabilities,
    PeerAddress? senderAddress,
    PeerAddress? receiverAddress,
    String? userAgent,
    Int64? nonce,
    LastBeacon? beacon,
  }) {
    final _result = create();
    if (version != null) {
      _result.version = version;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (capabilities != null) {
      _result.capabilities = capabilities;
    }
    if (senderAddress != null) {
      _result.senderAddress = senderAddress;
    }
    if (receiverAddress != null) {
      _result.receiverAddress = receiverAddress;
    }
    if (userAgent != null) {
      _result.userAgent = userAgent;
    }
    if (nonce != null) {
      _result.nonce = nonce;
    }
    if (beacon != null) {
      _result.beacon = beacon;
    }
    return _result;
  }

  @override
  BuilderInfo get info_ => _i;

  @override
  factory Version.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  @override
  factory Version.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  int get version => $_getIZ(0);
  @TagNumber(1)
  set version(int v) { $_setUnsignedInt32(0, v); }
  @TagNumber(1)
  bool hasVersion() => $_has(0);
  @TagNumber(1)
  void clearVersion() => clearField(1);

  @TagNumber(2)
  Int64 get timestamp => $_getI64(1);
  @TagNumber(2)
  set timestamp(Int64 v) { $_setInt64(1, v); }
  @TagNumber(2)
  bool hasTimestamp() => $_has(1);
  @TagNumber(2)
  void clearTimestamp() => clearField(2);

  @TagNumber(3)
  Int64 get capabilities => $_getI64(2);
  @TagNumber(3)
  set capabilities(Int64 v) { $_setInt64(2, v); }
  @TagNumber(3)
  bool hasCapabilities() => $_has(2);
  @TagNumber(3)
  void clearCapabilities() => clearField(3);

  @TagNumber(4)
  PeerAddress get senderAddress => $_getN(3);
  @TagNumber(4)
  set senderAddress(PeerAddress v) { setField(4, v); }
  @TagNumber(4)
  bool hasSenderAddress() => $_has(3);
  @TagNumber(4)
  void clearSenderAddress() => clearField(4);
  @TagNumber(4)
  PeerAddress ensureSenderAddress() => $_ensure(3);

  @TagNumber(5)
  PeerAddress get receiverAddress => $_getN(4);
  @TagNumber(5)
  set receiverAddress(PeerAddress v) { setField(5, v); }
  @TagNumber(5)
  bool hasReceiverAddress() => $_has(4);
  @TagNumber(5)
  void clearReceiverAddress() => clearField(5);
  @TagNumber(5)
  PeerAddress ensureReceiverAddress() => $_ensure(4);

  @TagNumber(6)
  String get userAgent => $_getSZ(5);
  @TagNumber(6)
  set userAgent(String v) { $_setString(5, v); }
  @TagNumber(6)
  bool hasUserAgent() => $_has(5);
  @TagNumber(6)
  void clearUserAgent() => clearField(6);

  @TagNumber(7)
  Int64 get nonce => $_getI64(6);
  @TagNumber(7)
  set nonce(Int64 v) { $_setInt64(6, v); }
  @TagNumber(7)
  bool hasNonce() => $_has(6);
  @TagNumber(7)
  void clearNonce() => clearField(7);

  @TagNumber(8)
  LastBeacon get beacon => $_getN(7);
  @TagNumber(8)
  set beacon(LastBeacon v) { setField(8, v); }
  @TagNumber(8)
  bool hasBeacon() => $_has(7);
  @TagNumber(8)
  void clearBeacon() => clearField(8);
  @TagNumber(8)
  LastBeacon ensureBeacon() => $_ensure(7);
}