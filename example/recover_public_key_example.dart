import 'dart:typed_data';

import 'package:witnet/crypto.dart';
import 'package:witnet/src/crypto/hd_wallet/extended_private_key.dart';
import 'package:witnet/src/crypto/secp256k1/secp256k1.dart';
import 'package:witnet/src/crypto/secp256k1/signature.dart';
import 'package:witnet/src/utils/transformations/transformations.dart';
import 'package:witnet/witnet.dart';

// abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about
String xprvString =
    "xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvu566tn6";

void main() {
  // import a xprv
  Xprv xprv = Xprv.fromXprv(xprvString);
  var expectedKey = bytesToHex(xprv.privateKey.publicKey.point.encode());

  // sign a message
  String messageStr = "Hello Witnet!";
  Uint8List messageBytes = sha256(data: stringToBytes(messageStr));
  WitSignature signature = xprv.privateKey.signature(bytesToHex(messageBytes));

  // recover a public key from a signature
  WitPublicKey recoveredKey = WitPublicKey.recover(signature, messageBytes);

  try {
    assert(expectedKey == bytesToHex(recoveredKey.point.encode()),
        "error: Message not signed by expected Public Key");
  } catch (e) {
    print(e);
  }
}
