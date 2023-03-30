<img src="https://github.com/witnet/website/blob/master/assets/images/witnet_logo.svg"
alt="wit"
style="
display: block;
margin-left: auto;
margin-right: auto;
width: 51%;"
/>

A library to interface with the Witnet Protocol.
For more information about Witnet visit [witnet.io][witnet_io]
## Usage

A simple usage example:

```dart
import 'package:witnet/node.dart' show NodeClient, SyncStatus;

String nodeIp = '127.0.0.1';
int nodePort = 21338;

main() async{
  print('Connecting to Node at $nodeIp:$nodePort...');
  NodeClient nodeClient = NodeClient(address: nodeIp, port: nodePort);
  SyncStatus syncStatus = await nodeClient.syncStatus();
  if (syncStatus.nodeState == 'Synced'){
    print('Node is synced. Current Epoch ${syncStatus.currentEpoch}');
  } else {
    print('Node is not synced. Current State: [${syncStatus.nodeState}]');
    print('Current Epoch:   [${syncStatus.currentEpoch}]');
    print('Last checkpoint: [${syncStatus.chainBeacon.checkpoint}]');
    print('${(syncStatus.chainBeacon.checkpoint / syncStatus.currentEpoch) * 100} % synced.');
  }
}
```

Recover Keys
```dart
import 'package:witnet/witnet.dart' show WitPrivateKey, Xprv;

void recoverKeys(){
  String xprvStr = 'xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvu566tn6';
  String mnemonic = 'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
  Xprv nodeXprv = Xprv.fromXprv(xprvStr);
  WitPrivateKey nodeKey = nodeXprv.privateKey;
  print('Node Address: ${nodeXprv.address.address}');
  Xprv walletMasterKey = Xprv.fromMnemonic(mnemonic: mnemonic);
  Xprv walletExternalKeychain = walletMasterKey / 3.0 / 4919.0 / 0.0 / 0;
  Xprv walletInternalKeychain = walletMasterKey / 3.0 / 4919.0 / 0.0 / 1;

  for(int i=0; i < 10; i++){
    Xprv external = walletExternalKeychain / i;
    Xprv internal = walletInternalKeychain / i;
    print('${external.path} ${external.address.address}');
    print('${internal.path} ${internal.address.address}');
  }
}
```
Create a signed VTTransaction from UTXO data.
```dart
import 'package:witnet/data_structures.dart' show UtxoSelectionStrategy;
import 'package:witnet/node.dart' show NodeClient, SyncStatus;
import 'package:witnet/schema.dart' show VTTransaction, ValueTransferOutput;
import 'package:witnet/witnet.dart' show Address, Xprv, nanoWitToWit, signMessage, verify;

List<ValueTransferOutput> outputs = [
  ValueTransferOutput.fromJson({'pkh': 'wit174la8pevl74hczcpfepgmt036zkmjen4hu8zzs', 'time_lock': 0, 'value': 1000000000,}),
];
String testXprvStr = 'xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvu566tn6';
String testMnemonic = 'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
String nodeIp = '127.0.0.1';
int nodePort = 21338;


main() async {
  print('Connecting to Node at $nodeIp:$nodePort...');
  NodeClient nodeClient = NodeClient(address: nodeIp, port: nodePort);
  SyncStatus syncStatus = await nodeClient.syncStatus();
  if (syncStatus.nodeState == 'Synced') {
    Xprv nodeXprv = Xprv.fromXprv(testXprvStr);
    Address address = nodeXprv.address;
    await address.getUtxoInfo(source: nodeClient);
    print('${address.address}');
    print('${address.balanceWit} WIT');
    VTTransaction transaction = address.createVTT(
        outputs: outputs,
        privateKey: nodeXprv.privateKey,
        utxoStrategy: UtxoSelectionStrategy.SmallFirst,
        fee: 1,
        networkSource: nodeClient);
    print(transaction.jsonMap);
    print(transaction.body.toRawJson());
    print(transaction.transactionID);
  }
}
```
Create a `KeyedSignature` from a Transaction hash with a Private Key.
```dart
import 'dart:typed_data';

import 'package:witnet/witnet.dart' show WitPrivateKey;
import 'package:witnet/schema.dart' show KeyedSignature, PublicKey, Secp256k1Signature, Signature;
KeyedSignature signHash(String hash, WitPrivateKey privateKey){
  final sig = privateKey.signature(hash);
  int compressed = privateKey.publicKey.encode().elementAt(0);
  Uint8List key_bytes = privateKey.publicKey.encode().sublist(1);
  return KeyedSignature(
    publicKey: PublicKey(bytes: key_bytes),
    signature: Signature(secp256k1: Secp256k1Signature(der: sig.encode())),
  );
}
```
Build a VTTransaction from inputs and outputs.
```dart
import 'package:witnet/witnet.dart' show WitPrivateKey;
import 'package:witnet/schema.dart' show VTTransaction, Input, ValueTransferOutput, VTTransactionBody;
List<Input> inputs = [
  Input.fromJson({'output_pointer':'0000000000000000000000000000000000000000000000000000000000000000:1'}),
];
List<ValueTransferOutput> outputs = [
  ValueTransferOutput.fromJson({'pkh': 'wit174la8pevl74hczcpfepgmt036zkmjen4hu8zzs', 'time_lock': 0, 'value': 1000000000,}),
];
Future<VTTransaction> basicTransaction({
  required List<Input> inputs,
  required List<ValueTransferOutput> outputs,
  required WitPrivateKey privateKey
}) async {
  VTTransactionBody body = VTTransactionBody(inputs: inputs, outputs: outputs);
  VTTransaction transaction = VTTransaction(body: body, signatures: []);
  return transaction;
}
```
Send a transaction.
```dart
import 'package:witnet/node.dart';
import 'package:witnet/schema.dart' show VTTransaction, VTTransactionBody;

String nodeIp = '127.0.0.1';
int nodePort = 21338;

main() async {
  NodeClient nodeClient = NodeClient(address: nodeIp, port: nodePort);
  SyncStatus syncStatus = await nodeClient.syncStatus();
  if (syncStatus.nodeState == 'Synced') {
    // an empty transaction
    VTTransactionBody body = VTTransactionBody(inputs: [], outputs: []);
    VTTransaction transaction = VTTransaction(body: body, signatures: []);
    String transactionID = transaction.transactionID;
    // change to true if you really want to send the transaction
    var resp = await nodeClient.inventory({'transaction': transaction.jsonMap});
    print(resp);
  }
}

```

## Features and bugs
<img src="https://github.com/witnet/website/blob/master/assets/images/community.svg"
alt="wit"
style="
display: block;
margin-right: auto;
width: 30%;"
/>

Please file feature requests and bugs at the [issue tracker][tracker].

Created by the Witnet Community and released under the [GNU General Public License v3.0][license]

[witnet_io]: https://witnet.io
[witnet_github]: https://github.com/witnet
[tracker]: https://github.com/parodyBit/witnet/issues
[license]: https://github.com/parodyBit/witnet/blob/main/LICENSE
[pointy_castle]: https://pub.dev/packages/pointycastle

## Acknowledgment
We would like to express our sincere gratitude to [@parody_bit](https://github.com/parodyBit) for generously creating and sharing this library for the improvement of the Witnet ecosystem. Thank you for your hard work and dedication.
