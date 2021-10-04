import 'package:witnet/explorer.dart';
import 'package:witnet/src/network/explorer/explorer_api.dart';

String explorerUrl = 'witnet.network';
ExplorerClient explorer = ExplorerClient(url: explorerUrl, mode: ExplorerMode.production);

void main() async{
  try{
    Status status = await explorer.status();
    print(status.databaseMessage);
  }  on ExplorerException catch(e) {
    print(e.message);
  }
}
