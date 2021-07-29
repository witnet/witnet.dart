import 'dart:typed_data';
import '../utils/bech32/bech32.dart';
import '../utils/bech32/codec.dart';
import '../utils/protobuf/serializer.dart';
import '../utils/transformations/transformations.dart';

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
    Uint8List content = concatBytes([fieldHeader, bytesSerializer(hash)]);
    return concatBytes([fieldHeader, bytesSerializer(content)]);
  }
}
