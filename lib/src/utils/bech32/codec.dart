import 'dart:convert';
import 'dart:typed_data';

import 'bech32.dart';
import 'decoder.dart';
import 'encoder.dart';
import 'validations.dart';
import '../transformations/transformations.dart' show
  bytesToBinary, convertBits;

/// An instance of the default implementation of the Bech32Codec.
const Bech32Codec bech32 = Bech32Codec();

class Bech32Codec extends Codec<Bech32, String> {
  const Bech32Codec();

  @override
  Bech32Decoder get decoder => Bech32Decoder();

  @override
  Bech32Encoder get encoder => Bech32Encoder();

  @override
  String encode(Bech32 data, [maxLength = Bech32Validations.maxInputLength]) {
    return Bech32Encoder().convert(data, maxLength);
  }

  @override
  Bech32 decode(String data, [maxLength = Bech32Validations.maxInputLength]) {
    return Bech32Decoder().convert(data, maxLength);
  }

  String encodeAddress(String hrp, List<int> data) {
    var bin = bytesToBinary(Uint8List.fromList(data));
    List<int> h3 = [];
    for (int i = 0; i < bin.length; i += 5) {
      h3.add(int.tryParse(bin.substring(i, i + 5), radix: 2)!);
    }
    Bech32 b = Bech32(hrp: hrp, data: h3);
    return encode(b);
  }

  String encodeXprv(String hrp, List<int> data) {
    var bin = bytesToBinary(Uint8List.fromList(data));
    List<int> h3 = [];
    for (int i = 0; i < bin.length; i += 5) {
      h3.add(int.tryParse(bin.substring(i, i + 5), radix: 2)!);
    }
    print(h3);
    Bech32 b = Bech32(hrp: hrp, data: h3);
    return encode(b);
  }

  Uint8List decodeAddress(String address) {
    return Uint8List.fromList(convertBits(
        data: bech32.decode(address).data, from: 5, to: 8, pad: true));
  }
}