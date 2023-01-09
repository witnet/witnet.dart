part of 'schema.dart';

class GetPeers extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('GetPeers',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..hasRequiredFields = false;

  static GetPeers create() => GetPeers._();
  static PbList<GetPeers> createRepeated() => PbList<GetPeers>();
  static GetPeers getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<GetPeers>(create);
  static GetPeers? _defaultInstance;

  GetPeers._() : super();

  @override
  GetPeers clone() => GetPeers()..mergeFromMessage(this);


  @override
  GetPeers createEmptyInstance() => create();

  factory GetPeers() => create();

  @override
  factory GetPeers.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory GetPeers.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;
}
