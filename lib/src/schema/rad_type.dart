part of 'schema.dart';

class RADType extends ProtobufEnum {
  static const RADType Unknown = RADType._(0, 'Unknown');
  static const RADType HttpGet = RADType._(1, 'HTTP-GET');
  static const RADType Rng = RADType._(2, 'RNG');
  static const RADType HttpPost = RADType._(3, 'HTTP-POST');

  static const List<RADType> values = <RADType>[
    Unknown,
    HttpGet,
    Rng,
    HttpPost,
  ];

  static final Map<int, RADType> _byValue = ProtobufEnum.initByValue(values);
  static RADType? valueOf(int value) => _byValue[value];

  static RADType? fromString(String value) {
    Map<String, RADType?> map = {
      'Unknown': _byValue[0],
      'HTTP-GET': _byValue[1],
      'RNG': _byValue[2],
      'HTTP-POST': _byValue[3],
    };
    return map[value];
  }

  const RADType._(int v, String n) : super(v, n);
}
