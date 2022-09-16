part of 'schema.dart';

class RADType extends ProtobufEnum {
  static const RADType Unknown = RADType._(0, 'Unknown');
  static const RADType HttpGet = RADType._(1, 'HttpGet');
  static const RADType Rng = RADType._(2, 'Rng');
  static const RADType HttpPost = RADType._(3, 'HttpPost');

  static const List<RADType> values = <RADType> [
    Unknown,
    HttpGet,
    Rng,
    HttpPost,
  ];

  static final Map<int, RADType> _byValue = ProtobufEnum.initByValue(values);
  static RADType? valueOf(int value) => _byValue[value];

  const RADType._(int v, String n) : super(v, n);
}