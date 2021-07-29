import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import '../bech32/exceptions.dart';

const Utf8Codec utf8 = Utf8Codec();

BigInt binaryToBigInt(String binary) {
  return BigInt.parse(binary, radix: 2);
}

String binaryToHex(String binary) {
  return binaryToBigInt(binary).toRadixString(16);
}

BigInt bytesToBigInt(Uint8List bytes) {
  var hex = bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  return BigInt.parse(hex, radix: 16);
}

String bytesToBinary(Uint8List bytes) {
  return bytes.map((byte) => byte.toRadixString(2).padLeft(8, '0')).join('');
}

String bytesToHex(Uint8List bytes) {
  return bytes
      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
      .join()
      .toLowerCase();
}

Uint8List stringToBytes(String string) {
  Uint8List tmp = Uint8List.fromList(utf8.encode(string));
  return tmp;
}

String bigIntToHex(BigInt i) {
  return i.toRadixString(16);
}

Uint8List bigIntToBytes(BigInt bigInt) {
  final data = ByteData((bigInt.bitLength / 8).ceil());
  BigInt _bigInt = bigInt;
  for (int i = 1; i <= data.lengthInBytes; i++) {
    data.setUint8(data.lengthInBytes - i, _bigInt.toUnsigned(8).toInt());
    _bigInt = _bigInt >> 8;
  }
  return data.buffer.asUint8List();
}

String bytesToString(Uint8List bytes) {
  return utf8.decode(bytes.toList());
}

BigInt hexToBigInt(String hex) {
  return BigInt.parse(hex, radix: 16);
}

Uint8List hexToBytes(String hex) {
  var result = new Uint8List(hex.length ~/ 2);
  for (var i = 0; i < hex.length; i += 2) {
    var num = hex.substring(i, i + 2);
    var byte = int.parse(num, radix: 16);
    result[i ~/ 2] = byte;
  }
  return result;
}

List<int> convertBits(
    {required List<int> data,
    required int from,
    required int to,
    required bool pad}) {
  var acc = 0;
  var bits = 0;
  var result = <int>[];
  var maxv = (1 << to) - 1;

  data.forEach((v) {
    if (v < 0 || (v >> from) != 0) {
      throw Exception();
    }
    acc = (acc << from) | v;
    bits += from;
    while (bits >= to) {
      bits -= to;
      result.add((acc >> bits) & maxv);
    }
  });

  if (pad) {
    if (bits > 0) {
      result.add((acc << (to - bits)) & maxv);
    }
  } else if (bits >= from) {
    throw InvalidPadding('illegal zero padding');
  } else if (((acc << (to - bits)) & maxv) != 0) {
    throw InvalidPadding('non zero');
  }

  return result;
}

Uint8List concatBytes(List<Uint8List> byteLists) {
  return Uint8List.fromList(byteLists.expand((x) => x).toList());
}

int witToNanoWit(double value) {
  return (value * pow(10, 9)).toInt();
}

double nanoWitToWit(int value) {
  return value / pow(10, 9);
}

Uint8List rightJustify(Uint8List bytes, int size, int value) {
  var padding = size - bytes.length;

  List<int> _pad = [];
  _pad += bytes.toList();
  for (int i = 0; i < padding; i++) {
    _pad.add(value);
  }

  return Uint8List.fromList(_pad);
}

Uint8List leftJustify(Uint8List bytes, int size, int value) {
  var padding = size - bytes.length;

  List<int> _pad = [];

  for (int i = 0; i < padding; i++) {
    _pad.add(value);
  }
  _pad += bytes.toList();

  return Uint8List.fromList(_pad);
}
