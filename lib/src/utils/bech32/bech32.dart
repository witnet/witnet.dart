import 'dart:typed_data';

/// Bech32 is a dead simple wrapper around a Human Readable Part (HRP) and a
/// bunch of bytes.
class Bech32 {
  Bech32({this.hrp, this.data});

  final String hrp;
  final List<int> data;
}

const String separator = '1';

const List<String> charset = [
  'q','p','z','r','y','9','x','8',
  'g','f','2','t','v','d','w','0',
  's','3','j','n','5','4','k','h',
  'c','e','6','m','u','a','7','l',
];

const List<int> generator = [
  0x3b6a57b2,
  0x26508e6d,
  0x1ea119fa,
  0x3d4233dd,
  0x2a1462b3,
];

int polymod(List<int> values) {
  var checksum = 1;
  values.forEach((value) {
    var top = checksum >> 25;
    checksum = (checksum & 0x1ffffff) << 5 ^ value;
    for (var i = 0; i < generator.length; i++) {
      if ((top >> i) & 1 == 1) {
        checksum ^= generator[i];
      }
    }
  });

  return checksum;
}

List<int> hrpExpand(String hrp) {
  var result = hrp.codeUnits.map((c) => c >> 5).toList();
  result = result + [0];
  result = result + hrp.codeUnits.map((c) => c & 31).toList();
  return result;
}

bool verifyChecksum(String hrp, List<int> data) {
  return polymod(hrpExpand(hrp) + data) == 1;
}

List<int> createChecksum(String hrp, List<int> data) {
  var values = hrpExpand(hrp) + data;
  var _polymod = polymod(values + [0, 0, 0, 0, 0, 0]) ^ 1;

  var result = <int>[0, 0, 0, 0, 0, 0];

  for (var i = 0; i < 6; i++) {
    result[i] = (_polymod >> (5 * (5 - i))) & 31;
  }
  return result;
}

