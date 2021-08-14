import 'package:witnet/node_rpc.dart';
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