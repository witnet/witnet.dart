part of 'schema.dart';

class Peers extends GeneratedMessage {

  static final BuilderInfo _i = BuilderInfo(
    'Peers',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..pc<PeerAddress>(1, 'peers', PbFieldType.PM, subBuilder: PeerAddress.create)
      ..hasRequiredFields = false;

  static Peers create() => Peers._();
  static PbList<Peers> createRepeated() => PbList<Peers>();
  static Peers getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<Peers>(create);
  static Peers? _defaultInstance;

  Peers._() : super();

  @override
  Peers clone() => Peers()..mergeFromMessage(this);

  @override
  Peers copyWith(void Function(Peers) updates) => super.copyWith((message) => updates(message as Peers)) as Peers; // ignore: deprecated_member_use

  @override
  Peers createEmptyInstance() => create();

  factory Peers({
    Iterable<PeerAddress>? peers,
  }) {
    final _result = create();
    if (peers != null) {
      _result.peers.addAll(peers);
    }
    return _result;
  }

  @override
  factory Peers.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  @override
  factory Peers.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  List<PeerAddress> get peers => $_getList(0);
}
