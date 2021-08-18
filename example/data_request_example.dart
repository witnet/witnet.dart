import 'package:witnet/data_structures.dart';
import 'package:witnet/node_rpc.dart';
import 'package:witnet/schema.dart' show DRTransaction, DataRequestOutput;
import 'package:witnet/src/data_structures/transaction_factory.dart';
import 'package:witnet/utils.dart' show bytesToHex;
import 'package:witnet/witnet.dart';

String nodeIp = '127.0.0.1';
int nodePort = 21338;
NodeClient nodeClient = NodeClient(address: nodeIp, port: nodePort);

String testMnemonic = 'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
DataRequestOutput dataRequestOutput = DataRequestOutput.fromJson({
  "collateral": 2500000000,
  "commit_and_reveal_fee": 1,
  "data_request":{
    "aggregate":{"filters": [],"reducer": 3},
    "retrieve":[
      {"kind":"HTTP-GET","script":[130,24,119,130,24,100,100,108,97,115,116], "url":"https://www.bitstamp.net/api/ticker/"},
      {"kind":"HTTP-GET","script":[132,24,119,130,24,102,99,98,112,105,130,24,102,99,85,83,68,130,24,100,106,114, 97,116,101,95,102,108,111,97,116],"url":"https://api.coindesk.com/v1/bpi/currentprice.json"}
    ],
    "tally":{"filters": [],"reducer": 3},
    "time_lock": 0
  },
  "min_consensus_percentage": 51,
  "witness_reward": 1,
  "witnesses": 100
});
void main() async {

  Xprv xprv = Xprv.fromMnemonic(mnemonic: testMnemonic);
  WitPrivateKey privateKey = xprv.privateKey;
  Address changeAddress = Address.fromAddress(privateKey.publicKey.address);
  FeeType feeType = FeeType.Weighted;
  UtxoSelectionStrategy utxoStrategy = UtxoSelectionStrategy.SmallFirst;


  SyncStatus syncStatus = await nodeClient.syncStatus();
  if (syncStatus.nodeState == 'Synced') {

    var drTransaction = await createDRTransaction(
        dataRequestOutput,
        privateKey,
        changeAddress,
        nodeClient,
        feeType, utxoStrategy
    );


    if(drTransaction.runtimeType == DRTransaction){
      print(drTransaction.jsonMap);
      print(drTransaction.body.weight);
    } else {
      assert (drTransaction.runtimeType == TransactionError);
      print(drTransaction);
    }
  } else {
    print('Node is not synced. Current State: [${syncStatus.nodeState}]');
    print('Current Epoch:   [${syncStatus.currentEpoch}]');
    print('Last checkpoint: [${syncStatus.chainBeacon.checkpoint}]');

    print('${(syncStatus.chainBeacon.checkpoint / syncStatus.currentEpoch) * 100} % synced.');
  }
}
