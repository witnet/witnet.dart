import 'dart:typed_data';

import 'package:witnet/utils.dart';

import 'aes.dart';
import 'cryptor.dart';
import 'exceptions.dart';

/// Enum that specifies the overwrite mode for write file operations
/// during encryption or decryption process.
enum AesCryptOwMode {
  /// If the file exists, stops the operation and throws [AesCryptException]
  /// exception with [AesCryptExceptionType.destFileExists] type.
  /// This mode is set by default.
  warn,

  /// If the file exists, adds index '(1)' to its' name and tries to save.
  /// If such file also exists, adds '(2)' to its name, then '(3)', etc.
  rename,

  /// Overwrites the file if it exists.
  on,
}

/// Enum that specifies the mode of operation of the AES algorithm.
enum AesMode {
  /// ECB (Electronic Code Book)
  ecb,

  /// CBC (Cipher Block Chaining)
  cbc,

  /// CFB (Cipher Feedback)
  cfb,

  /// OFB (Output Feedback)
  ofb,
}

/// Wraps encryption and decryption methods and algorithms.
class AesCrypt {
  final _aes = Aes();

  late String password;
  late Uint8List passBytes;
  late AesCryptOwMode owMode;

  /// Creates the library wrapper.
  ///
  /// Optionally sets encryption/decryption password as [password].
  AesCrypt([String password = '']) {
    password = password;
    passBytes = stringToBytes(password);
    owMode = AesCryptOwMode.warn;
  }

  /// Sets encryption/decryption password.
  void setPassword(String data) {
    AesCryptArgumentError.checkNullOrEmpty(data, 'Empty password.');
    password = data;
    passBytes = stringToBytes(data);
  }

  /// Sets overwrite mode [mode] for write file operations during encryption
  /// or decryption process.
  ///
  /// Available modes:
  ///
  /// [AesCryptOwMode.warn] - If the file exists, stops the operation and
  /// throws [AesCryptException] exception with
  /// [AesCryptExceptionType.destFileExists] type. This mode is set by default.
  ///
  /// [AesCryptOwMode.rename] - If the file exists, adds index '(1)' to its' name
  /// and tries to save. If such file also exists, adds '(2)' to its name, then '(3)', etc.
  ///
  /// [AesCryptOwMode.on] - Overwrite the file if it exists.
  void setOverwriteMode(AesCryptOwMode mode) => owMode = mode;

//****************************************************************************
//**************************** CRYPTO FUNCTIONS ******************************
//****************************************************************************

  /// Creates random encryption key of [length] bytes long.
  ///
  /// Returns [Uint8List] object containing created key.
  Uint8List createKey([int length = 32]) => Cryptor().createKey(length);

  /// Creates random initialization vector.
  ///
  /// Returns [Uint8List] object containing created initialization vector.
  Uint8List createIV() => Cryptor().createKey(16);

  /// Computes SHA256 hash for binary data [data].
  ///
  /// Returns [Uint8List] object containing computed hash.
  Uint8List sha256(Uint8List data) => Cryptor().sha256(data);

  /// Computes HMAC-SHA256 code for binary data [data] using cryptographic key [key].
  ///
  /// Returns [Uint8List] object containing computed code.
  Uint8List hmacSha256(Uint8List key, Uint8List data) =>
      Cryptor().hmacSha256(key, data);

  /// Sets AES encryption key [key] and the initialization vector [iv].
  void aesSetKeys(Uint8List key, [Uint8List? iv]) => _aes.aesSetKeys(key, iv);

  /// Sets AES mode of operation as [mode].
  ///
  /// Available modes:
  /// - [AesMode.ecb] - ECB (Electronic Code Book)
  /// - [AesMode.cbc] - CBC (Cipher Block Chaining)
  /// - [AesMode.cfb] - CFB (Cipher Feedback)
  /// - [AesMode.ofb] - OFB (Output Feedback)
  void aesSetMode(AesMode mode) => _aes.aesSetMode(mode);

  /// Sets AES encryption key [key], the initialization vector [iv] and AES mode [mode].
  void aesSetParams(Uint8List key, Uint8List iv, AesMode mode) {
    aesSetKeys(key, iv);
    aesSetMode(mode);
  }

  /// Encrypts binary data [data] with AES algorithm.
  ///
  /// Returns [Uint8List] object containing encrypted data.
  Uint8List aesEncrypt(Uint8List data) => _aes.aesEncrypt(data);

  // Decrypts binary data [data] encrypted with AES algorithm.
  //
  // Returns [Uint8List] object containing decrypted data.
  Uint8List aesDecrypt(Uint8List data) => _aes.aesDecrypt(data);
}
