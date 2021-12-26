import 'dart:typed_data';

import 'package:witnet/src/crypto/hd_wallet/extended_key.dart';
import 'package:witnet/src/crypto/secp256k1/secp256k1.dart';

import '../secp256k1/public_key.dart';
import '../crypto.dart';
import '../secp256k1/private_key.dart';
import 'package:witnet/utils.dart' show
  Bech32,
  bech32,
  bigIntToBytes,
  bytesToBigInt,
  bytesToHex,
  concatBytes,
  convertBits,
  hexToBytes,
  leftJustify,
  rightJustify;

class Xpub extends ExtendedKey{
  Xpub(
      {required Uint8List key,
      required Uint8List code,
      required int depth,
      required BigInt index,
      required Uint8List parent,
      required String? path
  }): super(
    rootPath: 'M',
    key: key,
    code: code,
    depth: depth,
    index: index,
    parent: parent,
    path: path,
  ) {
    (path != null)
      ? path.replaceAll('m', 'M')
      : rootPath.replaceAll('m', 'M');
    publicKey = WitPublicKey.decode(key);
  }


  Uint8List? _id;

  late WitPublicKey publicKey;

  Uint8List get keyData => publicKey.encode();

  @override
  Uint8List id() {
    if (_id == null) {
      _id = hash160(data: keyData);
    }
    return _id!;
  }

  String get address => publicKey.address;

  @override
  Xpub child({required BigInt index}) {
    bool hardened = index >= BigInt.from(1 << 31);
    if (hardened)
      assert(hardened == false,
          'Cannot derive a hardened key from an extended public key');
    var data;
    final indexBytes = leftJustify(bigIntToBytes(index), 4, 0);
    if (hardened) {
      print('Cannot derive Extended Public from Hardened');

    } else {
      data = publicKey.encode() + rightJustify(indexBytes, 4, 0);
    }
    Uint8List I = hmacSHA512(
        key: code, data: Uint8List.fromList(data));
    Uint8List IL = I.sublist(0, 32);
    Uint8List IR = I.sublist(32);
    Point _key = WitPrivateKey(bytes: I.sublist(0, 32)).publicKey.point + publicKey.point;

    return Xpub(
        key: hexToBytes(pointToHexInCompress(_key)),
        code: IR,
        depth: depth + 1,
        index: index,
        parent: fingerPrint,
        path: path! + '/$index');
  }
  factory Xpub.fromXpub(String xpubString){
    Bech32 bech = bech32.decoder.convert(xpubString);
    var bn256 = convertBits(data: bech.data, from: 5, to: 8, pad: true);
    Uint8List data = Uint8List.fromList(bn256);
    int bytePosition = 0;
    int? depth;
    int depthSize = 1;
    int fingerprintSize = 4;
    int chainCodeSize = 32;
    int keySize = 33;
    Uint8List _depth = data.sublist(bytePosition, bytePosition+depthSize);
    bytePosition+=depthSize;
    depth = int.parse(bytesToHex(_depth), radix: 16);
    // the index size is 4 bytes per depth to get the full key path
    int indexSize = 4 * (depth);
    // get parent fingerprint
    Uint8List fingerprint = data.sublist(bytePosition, bytePosition+fingerprintSize);
    bytePosition+=fingerprintSize;
    // get path
    Uint8List _index = data.sublist(bytePosition, bytePosition+indexSize);
    bytePosition+=indexSize;
    // get chain code
    Uint8List chainCode = data.sublist(bytePosition, bytePosition+chainCodeSize);
    bytePosition += chainCodeSize;
    // get key data
    Uint8List keyData = data.sublist(bytePosition, bytePosition+keySize);

    String hrp = bech.hrp;
    assert(hrp == 'xpub', 'Not a valid XPUB for importing.');


    String _path = 'M';
    Uint8List lastIndex = Uint8List(4);
    for(int i = 0; i < _index.length; i += 4){
      BigInt currentIndex = bytesToBigInt(_index.sublist(i,i+4));
      lastIndex = _index.sublist(i,i+4);
      if (currentIndex < BigInt.from(1 << 31)) {
       _path+='/${currentIndex.toString()}';
      } else {
        _path += '/${currentIndex - BigInt.from(1 << 31)}h';
      }
    }

    return Xpub(
      key: keyData,
      code: chainCode,
      depth: depth,
      index: bytesToBigInt(lastIndex),
      parent: fingerprint,
      path: _path
    );
  }

  String toSlip32() {
    Uint8List depthBytes = bigIntToBytes(BigInt.from(depth));
    List<String> pathParts = path!.split('/').sublist(1);
    List<Uint8List> indexParts = [];
    pathParts.forEach((element) {
      if(element.contains('h')){
        var value = BigInt.from(int.parse(element.replaceAll('h', '')))
            + BigInt.from(1 << 31);
      indexParts.add(bigIntToBytes(value));
      } else {
        indexParts.add(rightJustify(bigIntToBytes( BigInt.from(int.parse(element))),4,0));
      }
    });
    Uint8List indexData = concatBytes(indexParts);
    Uint8List data = concatBytes(
        [depthBytes, fingerPrint, indexData, code, publicKey.point.encode()]);
    var _data = convertBits(data: data, from: 8, to: 5, pad: true);
    return bech32.encoder.convert(Bech32(hrp: 'xpub', data: _data));
  }



}
