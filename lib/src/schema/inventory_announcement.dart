part of 'schema.dart';

class InventoryAnnouncement extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'InventoryAnnouncement',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..pc<InventoryEntry>(1, 'inventory', PbFieldType.PM, subBuilder: InventoryEntry.create)
      ..hasRequiredFields = false;

  static InventoryAnnouncement create() => InventoryAnnouncement._();
  static PbList<InventoryAnnouncement> createRepeated() => PbList<InventoryAnnouncement>();
  static InventoryAnnouncement getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<InventoryAnnouncement>(create);
  static InventoryAnnouncement? _defaultInstance;

  InventoryAnnouncement._() : super();

  @override
  InventoryAnnouncement clone() => InventoryAnnouncement()..mergeFromMessage(this);

  @override
  InventoryAnnouncement createEmptyInstance() => create();

  factory InventoryAnnouncement({
    Iterable<InventoryEntry>? inventory,
  }) {
    final _result = create();
    if (inventory != null) {
      _result.inventory.addAll(inventory);
    }
    return _result;
  }

  @override
  factory InventoryAnnouncement.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  @override
  factory InventoryAnnouncement.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  List<InventoryEntry> get inventory => $_getList(0);
}