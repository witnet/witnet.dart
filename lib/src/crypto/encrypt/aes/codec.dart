import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:witnet/src/crypto/bip39/utils/pbkdf2.dart';
import 'package:witnet/utils.dart';
import 'decoder.dart';
import 'encoder.dart';

const IV_LENGTH = 16;
const SALT_LENGTH = 32;
const PBKDF2_BLOCK_LENGTH = 64;
const HASH_ITER_COUNT = 10000;

class CodecAES extends Codec<Object, String> {
  AesCrypt _aesCrypt;
  DecoderAES _decoder;
  EncoderAES _encoder;
  CodecAES({Uint8List key, Uint8List iv, AesMode mode}){
    _aesCrypt = AesCrypt(bytesToHex(key));
    _aesCrypt.aesSetParams(key, iv, mode);
    _decoder = DecoderAES(_aesCrypt);
    _encoder = EncoderAES(_aesCrypt);
  }

  @override
  Converter<String, Object> get decoder => _decoder;

  @override
  Converter<Object, String> get encoder => _encoder;

}

Uint8List keyFromPassword({String password, Uint8List salt}){
  final pbkdf2 = new PBKDF2(
      blockLength: PBKDF2_BLOCK_LENGTH,
      desiredKeyLength: 32,
      iterationCount: 10000,
      digestAlgorithm: SHA256Digest()
  );
  return pbkdf2.process(data: Uint8List.fromList(password.codeUnits), passphrase: '', salt: salt);
}

CodecAES getCodecAES(String password, {Uint8List iv, Uint8List salt}){
  return CodecAES(key: keyFromPassword(password: password, salt: salt), iv: iv, mode: AesMode.cbc);
}

Uint8List generateIV(){
  var random = Random.secure();
  return Uint8List.fromList(List<int>.generate(IV_LENGTH, (index) => random.nextInt(256)));
}
Uint8List generateSalt(){
  var random = Random.secure();
  return Uint8List.fromList(List<int>.generate(SALT_LENGTH, (index) => random.nextInt(256)));
}