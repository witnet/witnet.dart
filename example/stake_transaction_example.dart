// import 'package:witnet/node.dart';
import 'package:witnet/schema.dart';
import 'package:witnet/src/constants.dart';
import 'package:witnet/src/utils/transformations/transformations.dart';
import 'package:witnet/witnet.dart';

var outputPointer = OutputPointer.fromString(
    '0000000000000000000000000000000000000000000000000000000000000000:0');

void main() async {
  /// connect to local node rpc
  // NodeClient nodeClient = NodeClient(address: "127.0.0.1", port: 21338);

  // String mnemonic = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
  /// load node xprv for the default mnemonic
  Xprv masterNode = Xprv.fromXprv(
      "xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvu566tn6");

  Xprv withdrawer = masterNode /
      KEYPATH_PURPOSE /
      KEYPATH_COIN_TYPE /
      KEYPATH_ACCOUNT /
      EXTERNAL_KEYCHAIN /
      0;

  /// The 20 byte Public Key Hash of the withdrawer
  String pkh = bytesToHex(withdrawer.privateKey.publicKey.publicKeyHash);

  /// The authorization by the node
  KeyedSignature authorization = signHash(pkh, masterNode.privateKey);

  /// build stake transaction body
  StakeBody body = StakeBody(
    inputs: [
      Input(outputPointer: outputPointer),
    ],
    output: StakeOutput(
      value: MINIMUM_STAKEABLE_AMOUNT_WITS,
      authorization: authorization,
    ),
  );

  /// build and sign stake transaction
  StakeTransaction stake = StakeTransaction(
      body: body,
      signatures: [signHash(body.transactionId, masterNode.privateKey)]);

  /// The Stake Transaction ID
  print(stake.transactionID);

  /// send stake transaction
  /// var response = await nodeClient.inventory(stake.jsonMap());
  ///
  UnstakeBody unstakeBody = UnstakeBody(
      operator: PublicKeyHash.fromAddress(""),
      withdrawal: ValueTransferOutput.fromJson({}));

  KeyedSignature unstakeSignature =
      signHash(bytesToHex(unstakeBody.hash), masterNode.privateKey);
  UnstakeTransaction unstake =
      UnstakeTransaction(body: unstakeBody, signature: unstakeSignature);

  print(unstake.transactionID);
}

/// Sign Hash
KeyedSignature signHash(String hash, WitPrivateKey privateKey) {
  final sig = privateKey.signature(hash);
  return KeyedSignature(
    publicKey: PublicKey(bytes: privateKey.publicKey.encode()),
    signature: Signature(secp256k1: Secp256k1Signature(der: sig.encode())),
  );
}
