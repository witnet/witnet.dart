<img src="https://github.com/parodyBit/witnet/tree/main/doc/api/static-assets/witnet_logo.svg"
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
import 'package:witnet/witnet.dart';
import 'package:witnet/node_rpc.dart' show NodeClient, NodeStats, SyncStatus, UtxoInfo, Utxo;

main() async {
  var nodeClient = NodeClient(address: '127.0.0.1', port: 21338);
  SyncStatus syncStatus = await nodeClient.syncStatus();
  if (syncStatus.nodeState == 'Synced'){
    Xprv nodeXprv = Xprv.fromXprv('xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvu566tn6');
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

