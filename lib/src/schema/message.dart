part of 'schema.dart';

class Message extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo(
    'Message',
    package: const PackageName('witnet'),
    createEmptyInstance: create)
      ..a<int>(1, 'magic', PbFieldType.OU3)
      ..aOM<Message_Command>(2, 'kind', subBuilder: Message_Command.create)
      ..hasRequiredFields = false;

  static Message create() => Message._();
  static PbList<Message> createRepeated() => PbList<Message>();
  static Message getDefault() => _defaultInstance ??= GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  Message._() : super();
  Message createEmptyInstance() => create();
  Message clone() => Message()..mergeFromMessage(this);
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message; // ignore: deprecated_member_use

  factory Message({
    int? magic,
    Message_Command? kind,
  }) {
    final _result = create();
    if (magic != null) {
      _result.magic = magic;
    }
    if (kind != null) {
      _result.kind = kind;
    }
    return _result;
  }

  @override
  factory Message.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);

  @override
  factory Message.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  int get magic => $_getIZ(0);
  @TagNumber(1)
  set magic(int v) { $_setUnsignedInt32(0, v); }
  @TagNumber(1)
  bool hasMagic() => $_has(0);
  @TagNumber(1)
  void clearMagic() => clearField(1);

  @TagNumber(2)
  Message_Command get kind => $_getN(1);
  @TagNumber(2)
  set kind(Message_Command v) { setField(2, v); }
  @TagNumber(2)
  bool hasKind() => $_has(1);
  @TagNumber(2)
  void clearKind() => clearField(2);
  @TagNumber(2)
  Message_Command ensureKind() => $_ensure(1);
}