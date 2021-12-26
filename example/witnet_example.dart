
import 'package:witnet/data_structures.dart';
import 'package:witnet/src/crypto/address.dart' show Address;
import 'package:witnet/src/network/node/node_api.dart';
import 'package:witnet/witnet.dart' show Xprv;
import 'package:witnet/node.dart' show NodeClient, SyncStatus;
import 'package:witnet/schema.dart' show VTTransaction, ValueTransferOutput;


String nodeIp = '127.0.0.1';
int nodePort = 21338;
NodeClient nodeClient = NodeClient(address: nodeIp, port: nodePort);



String testXprvStr = 'xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvu566tn6';
String testMnemonic = 'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';

main() async{

  print('Connecting to Node at $nodeIp:$nodePort...');
  try{
    SyncStatus syncStatus = await nodeClient.syncStatus();
    Xprv nodeXprv = Xprv.fromXprv(testXprvStr);
    Xprv walletXprv = Xprv.fromMnemonic(mnemonic: testMnemonic);
    print(nodeXprv.address.address);
    print('Wallet address : ${walletXprv.address.address}');
    Address address = nodeXprv.address;

    if (syncStatus.nodeState == 'Synced'){

      List<ValueTransferOutput> outputs = [
        ValueTransferOutput.fromJson({'pkh': 'wit174la8pevl74hczcpfepgmt036zkmjen4hu8zzs', 'time_lock': 0, 'value': 1000000000,}),
      ];
      await address.getUtxoInfo(source: nodeClient);
      print('${address.address}');
      print('${address.balanceWit} WIT');
      // var weightedFee = FeeType.Weighted;
      var absoluteFee = FeeType.Absolute;
      VTTransaction transaction = await address.createVTT(
          outputs: outputs,
          privateKey: nodeXprv.privateKey,
          utxoStrategy: UtxoSelectionStrategy.SmallFirst,
          fee: 1, feeType: absoluteFee, networkSource: nodeClient);
      print(transaction.jsonMap);
      print(transaction.body.toRawJson());
      print(transaction.transactionID);

      // uncomment to send the transaction
      // var resp = await nodeClient.inventory({'transaction': transaction.jsonMap});
      // print(resp);


    } else {
      print('Node is not synced. Current State: [${syncStatus.nodeState}]');
      print('Current Epoch:   [${syncStatus.currentEpoch}]');
      print('Last checkpoint: [${syncStatus.chainBeacon.checkpoint}]');

      print('${(syncStatus.chainBeacon.checkpoint / syncStatus.currentEpoch) * 100} % synced.');
    }
  } on NodeException catch(e){
    print(e.jsonMap());
  }

}