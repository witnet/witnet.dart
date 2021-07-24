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
import 'package:witnet/src/crypto/address.dart';
import 'package:witnet/src/data_structures/utxo_pool.dart';
import 'package:witnet/witnet.dart' show Xprv, nanoWitToWit, signMessage, verify;
import 'package:witnet/node_rpc.dart' show NodeClient, NodeStats, SyncStatus;
import 'package:witnet/schema.dart' show Input, VTTransaction, ValueTransferOutput;

String nodeIp = '127.0.0.1';
int nodePort = 21338;
NodeClient nodeClient;

List<Input> inputs = [
  Input.fromJson({'output_pointer':'0000000000000000000000000000000000000000000000000000000000000000:1'}),
];

List<ValueTransferOutput> outputs = [
  ValueTransferOutput.fromJson({'pkh': 'wit174la8pevl74hczcpfepgmt036zkmjen4hu8zzs', 'time_lock': 0, 'value': 1000000000,}),
];
String testXprvStr = 'xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvu566tn6';
String testMnemonic = 'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';

main() async{

  print('Connecting to Node at $nodeIp:$nodePort...');
  nodeClient = NodeClient(address: nodeIp, port: nodePort);

  NodeStats nodeStats = await nodeClient.nodeStats();
  SyncStatus syncStatus = await nodeClient.syncStatus();
  Xprv nodeXprv = Xprv.fromXprv(testXprvStr);
  Xprv walletXprv = Xprv.fromMnemonic(mnemonic: testMnemonic);
  print(nodeXprv.address.address);
  print('Wallet address : ${walletXprv.address.address}');
  Address address = nodeXprv.address;

  if (syncStatus.nodeState == 'Synced'){


    await address.getUtxoInfo(source: nodeClient);
    print('${address.address}');
    print('${address.balanceWit} WIT');
    VTTransaction transaction = address.createVTT(
        to: outputs,
        privateKey: walletXprv.privateKey,
        utxoStrategy: UtxoSelectionStrategy.SmallFirst,
        fee: 1);
    print(transaction.jsonMap);
    print(transaction.body.toRawJson());
    print(transaction.transactionID);

    // change to true if you really want to send the transaction
    bool sendTrx = false;

    if(sendTrx){
      var resp = await nodeClient.inventory({'transaction': transaction.jsonMap});
      print(resp);
    }

  } else {
    print('Node is not synced. Current State: [${syncStatus.nodeState}]');
    print('Current Epoch:   [${syncStatus.currentEpoch}]');
    print('Last checkpoint: [${syncStatus.chainBeacon.checkpoint}]');

    print('${(syncStatus.chainBeacon.checkpoint / syncStatus.currentEpoch) * 100} % synced.');
  }
}
```

## Features and bugs
<img src="../api/static-assets/community.svg"
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
[tracker]: http://example.com/issues/replaceme
[license]: https://github.com/dart-lang/stagehand/blob/master/LICENSE
[pointy_castle]: https://pub.dev/packages/pointycastle

