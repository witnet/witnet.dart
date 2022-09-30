part of 'schema.dart';

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
