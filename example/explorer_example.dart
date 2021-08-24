import 'package:witnet/explorer.dart';
import 'package:witnet/src/network/explorer/explorer_api.dart';

String explorerUrl = 'witnet.network';
String explorerTest = '209.145.51.142';
ExplorerClient explorer = ExplorerClient(url: explorerTest, mode: ExplorerMode.development);

void main() async{
  try{
    Status status = await explorer.status();
    print(status.databaseMessage);
  }  on ExplorerException catch(e) {
    print(e.message);
  }
}
