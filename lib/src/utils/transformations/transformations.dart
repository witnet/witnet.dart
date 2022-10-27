import 'dart:convert' show Utf8Codec;
import 'dart:math' show pow;
import 'dart:typed_data' show ByteData, Endian, Uint8List;
import '../bech32/exceptions.dart' show InvalidPadding;


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

// Converts string to UTF-8 bytes
List<int> toUtf8Bytes(String string, [bool bom = false]) {
  if (bom) {
    Uint8List data = Uint8List.fromList(utf8.encode(string));
    Uint8List dataWithBom = Uint8List(data.length + 3)
      ..setAll(0, [0xEF, 0xBB, 0xBF])
      ..setRange(3, data.length + 3, data);
    return dataWithBom;
  }
  return utf8.encode(string);
}

// Converts UTF-16 string to bytes
Uint8List toUtf16Bytes(String string,
    [Endian endian = Endian.big, bool bom = false]) {
  List<int> list =
      bom ? (endian == Endian.big ? [0xFE, 0xFF] : [0xFF, 0xFE]) : [];
  string.runes.forEach((rune) {
    if (rune >= 0x10000) {
      int firstWord = (rune >> 10) + 0xD800 - (0x10000 >> 10);
      int secondWord = (rune & 0x3FF) + 0xDC00;
      if (endian == Endian.big) {
        list.add(firstWord >> 8);
        list.add(firstWord & 0xFF);
        list.add(secondWord >> 8);
        list.add(secondWord & 0xFF);
      } else {
        list.add(firstWord & 0xFF);
        list.add(firstWord >> 8);
        list.add(secondWord & 0xFF);
        list.add(secondWord >> 8);
      }
    } else {
      if (endian == Endian.big) {
        list.add(rune >> 8);
        list.add(rune & 0xFF);
      } else {
        list.add(rune & 0xFF);
        list.add(rune >> 8);
      }
    }
  });
  return Uint8List.fromList(list);
}

bool isStringNullOrEmpty(String? string) => string == null || string.isEmpty;
