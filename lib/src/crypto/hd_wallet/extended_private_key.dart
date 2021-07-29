import 'dart:typed_data';

import 'package:witnet/src/crypto/aes/aes_crypt.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:witnet/src/crypto/address.dart';
import 'package:witnet/src/crypto/aes/exceptions.dart';
import 'package:witnet/src/crypto/encrypt/aes/codec.dart';

import '../bip39/bip39.dart' show mnemonicToSeed;

import '../crypto.dart';
import '../secp256k1/private_key.dart';
import '../../utils/bech32/bech32.dart';
import '../../utils/bech32/codec.dart';
import '../../utils/transformations/transformations.dart';

import 'extended_public_key.dart';
final _ecParams = ECCurve_secp256k1();

class Xprv {
  Xprv({
    required this.key,
    required this.code,
    this.depth = 0,
    this.index,
    this.parent,
    this.path,
    this.masterKey = false,
  }){
    assert (this.depth >= 0 && this.depth <=256);

    privateKey = WitPrivateKey(bytes: key);
    if (path == null){
      this.path = rootPath;
    }
  }

  @override
  String get rootPath => 'm';

  Xpub toXpub() {
    return Xpub(
        publicKey: privateKey.publicKey,
        code: code,
        depth: depth,
        index: index != null ? index! : BigInt.from(0),
        parent: parent != null ? parent! : Uint8List(4),
        path: (path != null) ? path!.replaceAll('m', 'M'):rootPath.replaceAll('m', 'M'));
  }
  Xpub toChildXpub(BigInt index) => toXpub().child(index);
  late WitPrivateKey privateKey;
  Uint8List ?_id;
  final Uint8List key;
  Uint8List code;
  Uint8List ?parent;
  BigInt? index;
  int depth;
  String ?path;
  late bool masterKey;

  Uint8List get keyData {
   return leftJustify(key, 33, 0);
  }

  Uint8List get id {
    if (_id == null) {
      _id = hash160(data: keyData);
    }
    return _id!;
  }
  Address get address => Address.fromAddress(privateKey.publicKey.address);
  Uint8List get fingerPrint =>  privateKey.publicKey.publicKeyHash;

  factory Xprv.fromSeed({required Uint8List seed, String networkKey = 'Bitcoin seed'}){
    assert (16 <= seed.length && seed.length <= 64,
    'Seed should be between 128 and 512 bits');
    var I = hmacSHA512(key: stringToBytes(networkKey), data: seed);
    var IL = I.sublist(0, 32);
    var IR = I.sublist(32);
    return Xprv(key: IL, code: IR);
  }

  factory Xprv.fromMnemonic({required String mnemonic, String passphrase=''}) {
    Uint8List seed = mnemonicToSeed(mnemonic, passphrase: passphrase);
    return Xprv.fromSeed(seed: seed);
  }

  factory Xprv.fromXprv(String xprv) {
    Bech32 bech = bech32.decoder.convert(xprv);
    var bn256 = convertBits(data: bech.data, from: 5, to: 8, pad: true);
    Uint8List data = Uint8List.fromList(bn256);
    String hrp = bech.hrp;
    assert (hrp == 'xprv', 'Not a valid XPRV for importing.');
    Uint8List depth = data.sublist(0, 1);

    Uint8List chainCode = data.sublist(1, 33);
    Uint8List keyData = data.sublist(34, 66);
    bool masterKey = false;
    if (4 * depth[0] == 0) {
      masterKey = true;
    }
    return Xprv(
        key: keyData, code: chainCode, depth: depth[0], masterKey: masterKey );
  }
  String toSlip32()  {
    Uint8List depthBytes = bigIntToBytes(BigInt.from(depth));
    Uint8List padding = leftJustify(Uint8List.fromList([0]),1,0);
    Uint8List data = concatBytes([
      depthBytes,
      padding,
      code,
      padding,
      privateKey.bytes.bytes
    ]);
    var _data = convertBits(data: data,from: 8, to: 5, pad: true);
    return bech32.encoder.convert(Bech32(hrp: 'xprv', data:_data));
  }

  factory Xprv.fromEncryptedXprv(String xprv, String password){
    Bech32 bech = bech32.decode(xprv);
    Uint8List data = Uint8List.fromList(
        convertBits(data: bech.data, from: 5, to: 8, pad: false));

    Uint8List iv = data.sublist(0, 16);
    Uint8List salt = data.sublist(16, 48);
    Uint8List _data = data.sublist(48);

    CodecAES codec = getCodecAES(password, salt: salt, iv: iv);
    Uint8List decoded = codec.decode(bytesToHex(_data)) as Uint8List;

    //String plainText = String.fromCharCodes(decoded).trim();
    String plainText;
    try {
      plainText = utf8.decode(decoded).trim();
      return Xprv.fromXprv(plainText);
    } catch (e){
      print(e);
      plainText = 'Aes Decode Error';
      throw AesCryptDataException('Invalid Password');
    }
  }

  String toEncryptedXprv({required String password}){
      String xprvStr = toSlip32();
      List<int> tmp = xprvStr.codeUnits;
      print(tmp.length);
      Uint8List dat = Uint8List(128);
      int padLength = dat.length - tmp.length;
      Uint8List padding = Uint8List(padLength);
      for(int i = 0; i < padLength; i++){
        padding[i] = 11;
      }
      dat.setRange(0, tmp.length, tmp);
      dat.setRange(tmp.length, dat.length, padding);
      print(dat);
      Uint8List _iv = generateIV();
      Uint8List _salt = generateSalt();
      CodecAES codec = getCodecAES(password, salt: _salt, iv: _iv);
      var encoded = codec.encode(dat);
      Uint8List encData = concatBytes([_iv, _salt, hexToBytes(encoded)]);
      print(encData);
      Uint8List data1 = Uint8List.fromList(
          convertBits(data: encData, from: 8, to: 5, pad: true));
      print(data1);
      Bech32 b1 = Bech32(hrp: 'xprv', data: data1);

      String bech1 = bech32.encode(b1, 293);
      // 32bit to 256bit
      print(bech1);
      return bech1;
  }


  Xprv child({required BigInt index}) {
    bool hardened = index >= BigInt.from(1 << 31);
    Uint8List I;
    var data;
    var indexBytes = leftJustify(bigIntToBytes(index), 4,0);
    if (hardened) {
      data = keyData + rightJustify(indexBytes,4,0);
    } else {
      data = privateKey.publicKey.encode() + rightJustify(indexBytes,4,0);
    }

    I = hmacSHA512(key: code, data: Uint8List.fromList(data));
    BigInt IL = bytesToBigInt(I.sublist(0, 32));
    Uint8List IR = I.sublist(32);
    Uint8List _key = bigIntToBytes((IL + bytesToBigInt(key)) % _ecParams.n);
    if (IL >= _ecParams.n || bytesToBigInt(_key) == BigInt.zero) {

      return this.child(index: index + BigInt.one);
    }
    Uint8List returnCode = IR;
    String _path = (path != null) ? path! : rootPath;
    if (hardened) {
      _path += '/${index - BigInt.two.pow(31)}h';
    } else {
      _path += '/$index';
    }

    return Xprv(
        key: _key,
        code: returnCode,
        depth: depth + 1,
        index: index,
        parent: fingerPrint,
        path: _path, );
  }

  Xprv operator /(dynamic index){
    BigInt i;

    if( index is double){
      // hardened child derivation
      i = BigInt.from(index)  + BigInt.two.pow(31);
    } else { // if ( index is int )
      // non-hardened child derivation
      i = BigInt.from(index);
    }
    return this.child(index: i);
  }

  Xprv operator ~/(int index){
    return this.child(index: BigInt.from(index) + BigInt.two.pow(31));
  }

  bool get isMaster {
    if (depth == 0 && index == null && path == rootPath) {
      return true;
    }
    return false;
  }
}
