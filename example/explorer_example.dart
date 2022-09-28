import 'package:witnet/explorer.dart';

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