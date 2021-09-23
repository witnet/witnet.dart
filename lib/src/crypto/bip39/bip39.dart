import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' show sha256;
import 'package:hex/hex.dart';
import 'package:pointycastle/digests/sha512.dart';

import 'utils/pbkdf2.dart';

import 'wordlists/chinese_simplified.dart' as chineseSimplified;
import 'wordlists/chinese_traditional.dart' as chineseTraditional;
import 'wordlists/english.dart' as english;
import 'wordlists/french.dart' as french;
import 'wordlists/italian.dart' as italian;
import 'wordlists/japanese.dart' as japanese;
import 'wordlists/korean.dart' as korean;
import 'wordlists/spanish.dart' as spanish;
import 'wordlists/czech.dart' as czech;
import 'wordlists/portuguese.dart' as portuguese;

/// The Word lists
/// [BIP39 Reference](https://github.com/bitcoin/bips/blob/master/bip-0039/bip-0039-wordlists.md)
const word_lists = {
  'ChineseSimplified': chineseSimplified.WORDLIST,
  'ChineseTraditional': chineseTraditional.WORDLIST,
  'Czech': czech.WORDLIST,
  'English': english.WORDLIST,
  'French': french.WORDLIST,
  'Italian': italian.WORDLIST,
  'Japanese': japanese.WORDLIST,
  'Korean': korean.WORDLIST,
  'Portuguese': portuguese.WORDLIST,
  'Spanish': spanish.WORDLIST,
};

const int _SIZE_BYTE = 255;
const _INVALID_MNEMONIC = 'Invalid mnemonic';
const _INVALID_ENTROPY = 'Invalid entropy';
const _INVALID_CHECKSUM = 'Invalid mnemonic checksum';

typedef Uint8List RandomBytes(int size);

int _binaryToByte(String binary) {
  return int.parse(binary, radix: 2);
}

String _bytesToBinary(Uint8List bytes) {
  return bytes.map((byte) => byte.toRadixString(2).padLeft(8, '0')).join('');
}

String _deriveChecksumBits(Uint8List entropy) {
  final _entropy = entropy.length * 8;
  final _checksum = _entropy ~/ 32;
  final hash = sha256.convert(entropy);
  return _bytesToBinary(Uint8List.fromList(hash.bytes)).substring(0, _checksum);
}

Uint8List _randomBytes(int size) {
  final rng = Random.secure();
  final bytes = Uint8List(size);
  for (var i = 0; i < size; i++) {
    bytes[i] = rng.nextInt(_SIZE_BYTE);
  }
  return bytes;
}

String generateMnemonic({int wordCount = 12, String language = 'English'}) {
  const strengthMap = {12: 128, 15: 160, 18: 192, 21: 224, 24: 256};
  var strength = 128;

  var idx = 0;
  strengthMap.forEach((key, value) {
    if (key == wordCount) {
      strength = strengthMap.values.elementAt(idx);
    }
    idx += 1;
  });
  RandomBytes randomBytes = _randomBytes;
  assert(strength % 32 == 0);
  final entropy = randomBytes(strength ~/ 8);
  return entropyToMnemonic(HEX.encode(entropy), language: language);
}

String entropyToMnemonic(String entropyString, {String language = "English"}) {
  final entropy = Uint8List.fromList(HEX.decode(entropyString));
  if (entropy.length < 16) {
    throw ArgumentError(_INVALID_ENTROPY);
  }
  if (entropy.length > 32) {
    throw ArgumentError(_INVALID_ENTROPY);
  }
  if (entropy.length % 4 != 0) {
    throw ArgumentError(_INVALID_ENTROPY);
  }
  final entropyBits = _bytesToBinary(entropy);
  final checksumBits = _deriveChecksumBits(entropy);
  final bits = entropyBits + checksumBits;
  final regex = new RegExp(r".{1,11}", caseSensitive: false, multiLine: false);
  final chunks = regex
      .allMatches(bits)
      .map((match) => match.group(0))
      .toList(growable: false);
  final List<String> wordlist = word_lists[language]!;
  String words =
      chunks.map((binary) => wordlist[_binaryToByte(binary!)]).join(' ');
  return words;
}

Uint8List mnemonicToSeed(String mnemonic, {String passphrase = ""}) {
  final pbkdf2 = new PBKDF2(digestAlgorithm: new SHA512Digest());
  return pbkdf2.process(
      data: Uint8List.fromList(mnemonic.codeUnits), passphrase: passphrase);
}

String mnemonicToSeedHex(String mnemonic, {String passphrase = ""}) {
  return mnemonicToSeed(mnemonic, passphrase: passphrase).map((byte) {
    return byte.toRadixString(16).padLeft(2, '0');
  }).join('');
}

bool validateMnemonic(String mnemonic) {
  try {
    mnemonicToEntropy(mnemonic);
  } catch (e) {
    rethrow;
  }
  return true;
}

String mnemonicToEntropy(mnemonic, {String language = 'English'}) {
  var words = mnemonic.split(' ');
  if (words.length % 3 != 0) {
    throw new ArgumentError(_INVALID_MNEMONIC);
  }
  final wordlist = word_lists[language];
  // convert word indices to 11 bit binary strings
  final bits = words.map((word) {
    final index = wordlist?.indexOf(word);
    if (index == -1) {
      throw new ArgumentError(_INVALID_MNEMONIC);
    }
    return index?.toRadixString(2).padLeft(11, '0');
  }).join('');
  // split the binary string into ENT/CS
  final dividerIndex = (bits.length / 33).floor() * 32;
  final entropyBits = bits.substring(0, dividerIndex);
  final checksumBits = bits.substring(dividerIndex);

  // calculate the checksum and compare
  final regex = RegExp(r".{1,8}");
  final entropyBytes = Uint8List.fromList(regex
      .allMatches(entropyBits)
      .map((match) => _binaryToByte(match.group(0)!))
      .toList(growable: false));
  if (entropyBytes.length < 16) {
    throw StateError(_INVALID_ENTROPY);
  }
  if (entropyBytes.length > 32) {
    throw StateError(_INVALID_ENTROPY);
  }
  if (entropyBytes.length % 4 != 0) {
    throw StateError(_INVALID_ENTROPY);
  }
  final newChecksum = _deriveChecksumBits(entropyBytes);
  if (newChecksum != checksumBits) {
    throw StateError(_INVALID_CHECKSUM);
  }
  return entropyBytes.map((byte) {
    return byte.toRadixString(16).padLeft(2, '0');
  }).join('');
}
