import 'package:witnet/src/utils/bech32/codec.dart';

import 'bech32.dart' show Bech32, separator, verifyChecksum;

/// Generic validations for Bech32 standard.
mixin Bech32Validations {
  static const int maxInputLength = 293;
  static const checksumLength = 6;

  bool validateAddress(String address) {
    Bech32 bech32 = Bech32Codec().decode(address);
    String hrp = bech32.hrp;
    List<int> data = bech32.data;
    int separatorPosition = 4;
    if (isChecksumTooShort(separatorPosition, address)) {
      print('ChecksumTooShort');
      return false;
    } else if (hasOutOfBoundsChars(data)) {
      print('hasOutOfBoundsChars');
      return false;
    } else if (isHrpTooShort(separatorPosition)) {
      print('HrpTooShort');
      return false;
    } else if (isInvalidChecksum(hrp, data)) {
      print('InvalidChecksum');
      return false;
    } else
      return true;
  }

  // From the entire input subtract the hrp length, the separator and the required checksum length
  bool isChecksumTooShort(int separatorPosition, String input) {
    return (input.length - separatorPosition - 1 - checksumLength) < 0;
  }

  bool hasOutOfBoundsChars(List<int> data) {
    return data.any((c) => c == -1);
  }

  bool isHrpTooShort(int separatorPosition) {
    return separatorPosition == 0;
  }

  bool isInvalidChecksum(String hrp, List<int> data) {
    return !verifyChecksum(hrp, data);
  }

  bool isMixedCase(String input) {
    return input.toLowerCase() != input && input.toUpperCase() != input;
  }

  bool hasInvalidSeparator(String bech32) {
    return bech32.lastIndexOf(separator) == -1;
  }

  bool hasOutOfRangeHrpCharacters(String hrp) {
    return hrp.codeUnits.any((c) => c < 33 || c > 126);
  }
}
