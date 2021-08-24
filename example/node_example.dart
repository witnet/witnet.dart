import 'package:witnet/node.dart';
import 'package:witnet/src/network/node/node_api.dart';

void main() async {
  NodeClient nodeClient = NodeClient(address: '127.0.0.1', port: 21338);
  try {
    SyncStatus syncStatus = await nodeClient.syncStatus();
    print(syncStatus.nodeState);
  } on NodeException catch (e) {
    print(e.jsonMap());
  }
}

