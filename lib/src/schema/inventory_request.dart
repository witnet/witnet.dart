part of 'schema.dart';

class InventoryRequest extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('InventoryRequest',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..pc<InventoryEntry>(1, 'inventory', PbFieldType.PM,
        subBuilder: InventoryEntry.create)
    ..hasRequiredFields = false;

  static InventoryRequest create() => InventoryRequest._();
  static PbList<InventoryRequest> createRepeated() =>
      PbList<InventoryRequest>();
  static InventoryRequest getDefault() => _defaultInstance ??=
      GeneratedMessage.$_defaultFor<InventoryRequest>(create);
  static InventoryRequest? _defaultInstance;

  InventoryRequest._() : super();

  @override
  InventoryRequest clone() => InventoryRequest()..mergeFromMessage(this);

  @override
  InventoryRequest copyWith(void Function(InventoryRequest) updates) =>
      super.copyWith((message) => updates(message as InventoryRequest))
          as InventoryRequest; // ignore: deprecated_member_use

  @override
  InventoryRequest createEmptyInstance() => create();

  factory InventoryRequest({
    Iterable<InventoryEntry>? inventory,
  }) {
    final _result = create();
    if (inventory != null) {
      _result.inventory.addAll(inventory);
    }
    return _result;
  }

  @override
  factory InventoryRequest.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory InventoryRequest.fromJson(String i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  List<InventoryEntry> get inventory => $_getList(0);
}
