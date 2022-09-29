part of 'schema.dart';

class StringPair extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('StringPair',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOS(1, 'left')
    ..aOS(2, 'right')
    ..hasRequiredFields = false;

  static StringPair create() => StringPair._();
  static PbList<StringPair> createRepeated() => PbList<StringPair>();
  static StringPair getDefault() =>
      _defaultInstance ??= GeneratedMessage.$_defaultFor<StringPair>(create);
  static StringPair? _defaultInstance;

  StringPair._() : super();

  @override
  StringPair createEmptyInstance() => create();

  @override
  StringPair clone() => StringPair()..mergeFromMessage(this);

  @override
  StringPair copyWith(void Function(StringPair) updates) =>
      super.copyWith((message) => updates(message as StringPair))
          as StringPair; // ignore: deprecated_member_use

  factory StringPair({
    String? left,
    String? right,
  }) {
    final _result = create();
    if (left != null) {
      _result.left = left;
    }
    if (right != null) {
      _result.right = right;
    }
    return _result;
  }

  @override
  factory StringPair.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  @override
  factory StringPair.fromJson(Map<String, dynamic> json) =>
      StringPair(left: json["left"], right: json["right"]);

  @override
  BuilderInfo get info_ => _i;

  Uint8List get pbBytes => writeToBuffer();

  @TagNumber(1)
  String get left => $_getSZ(0);
  @TagNumber(1)
  set left(String v) {
    $_setString(0, v);
  }

  @TagNumber(1)
  bool hasLeft() => $_has(0);
  @TagNumber(1)
  void clearLeft() => clearField(1);

  @TagNumber(2)
  String get right => $_getSZ(1);
  @TagNumber(2)
  set right(String v) {
    $_setString(1, v);
  }

  @TagNumber(2)
  bool hasRight() => $_has(1);
  @TagNumber(2)
  void clearRight() => clearField(2);
}
