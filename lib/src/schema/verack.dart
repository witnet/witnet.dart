part of 'schema.dart';

class Verack extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Verack',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..hasRequiredFields = false;

  static Verack create() => Verack._();
  static PbList<Verack> createRepeated() => PbList<Verack>();
  static Verack getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<Verack>(create);
  static Verack? _defaultInstance;

  Verack._() : super();

  @override
  Verack clone() => Verack()..mergeFromMessage(this);

  @override
  Verack createEmptyInstance() => create();

  factory Verack() => create();

  @override
  factory Verack.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory Verack.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;
}
