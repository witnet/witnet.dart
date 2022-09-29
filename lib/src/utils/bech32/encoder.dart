import 'dart:convert' show Converter;
import 'bech32.dart' show Bech32, separator, createChecksum, charset;
import 'validations.dart' show Bech32Validations;
import 'exceptions.dart'
    show
        OutOfBoundChars,
        TooShortHrp,
        TooLong,
        OutOfRangeHrpCharacters,
        MixedCase;

// This class converts a Bech32 class instance to a String.
class Bech32Encoder extends Converter<Bech32, String> with Bech32Validations {
  @override
  String convert(Bech32 input,
      [int maxLength = Bech32Validations.maxInputLength]) {
    var hrp = input.hrp;
    var data = input.data;

    if (hrp.length +
            data.length +
            separator.length +
            Bech32Validations.checksumLength >
        maxLength) {
      throw TooLong(
          hrp.length + data.length + 1 + Bech32Validations.checksumLength);
    }

    if (hrp.isEmpty) {
      throw TooShortHrp();
    }

    if (hasOutOfRangeHrpCharacters(hrp)) {
      throw OutOfRangeHrpCharacters(hrp);
    }

    if (isMixedCase(hrp)) {
      throw MixedCase(hrp);
    }

    hrp = hrp.toLowerCase();

    var checksummed = data + createChecksum(hrp, data);

    if (hasOutOfBoundsChars(checksummed)) {
      // TODO this could be more informative
      throw OutOfBoundChars('<unknown>');
    }
    return hrp + separator + checksummed.map((i) => charset[i]).join();
  }
}
