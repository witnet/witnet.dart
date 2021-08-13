import 'dart:typed_data';


import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED;
import 'package:witnet/utils.dart' show bytesToHex, bech32;

class PublicKeyHash {
  PublicKeyHash({required this.hash});

  final Uint8List hash;

  factory PublicKeyHash.fromAddress(String address) {
    return PublicKeyHash(
        hash: Uint8List.fromList(bech32.decodeAddress(address)));
  }

  String get hex => bytesToHex(hash);

  String get address => bech32.encodeAddress('wit', hash);

  Uint8List get pbBytes {
    return pbField(1, LENGTH_DELIMITED, hash);
  }
}
