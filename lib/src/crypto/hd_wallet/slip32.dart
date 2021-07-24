


import '../../utils/bech32/bech32.dart';
import '../../utils/bech32/codec.dart';
import '../../utils/bech32/decoder.dart';


dynamic fromSlip(String masterKey, rootPath) {
  Bech32 bech = bech32.decoder.convert(masterKey);
  print(bech);
  return bech;
}