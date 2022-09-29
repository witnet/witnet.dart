part of 'schema.dart';

class PeerAddress extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Address',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..a<List<int>>(1, 'address', PbFieldType.OY)
    ..hasRequiredFields = false;

  static PeerAddress create() => PeerAddress._();
  static PbList<PeerAddress> createRepeated() => PbList<PeerAddress>();
  static PeerAddress getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<PeerAddress>(create);
  static PeerAddress? _defaultInstance;

  PeerAddress._() : super();

  @override
  PeerAddress clone() => PeerAddress()..mergeFromMessage(this);

  @override
  PeerAddress copyWith(void Function(PeerAddress) updates) =>
      super.copyWith((message) => updates(message as PeerAddress))
          as PeerAddress; // ignore: deprecated_member_use

  @override
  PeerAddress createEmptyInstance() => create();

  factory PeerAddress({
    List<int>? address,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    return _result;
  }

  @override
  factory PeerAddress.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory PeerAddress.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  List<int> get address => $_getN(0);
  @TagNumber(1)
  set address(List<int> v) {
    $_setBytes(0, v);
  }

  @TagNumber(1)
  bool hasAddress() => $_has(0);
  @TagNumber(1)
  void clearAddress() => clearField(1);
}
