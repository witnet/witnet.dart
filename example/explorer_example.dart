import 'package:witnet/explorer.dart';

String explorerUrl = 'witscan.xyz';
ExplorerClient explorer =
    ExplorerClient(url: explorerUrl, mode: ExplorerMode.production);
void main() async {
  try {
    dynamic status = await explorer.address(
        tab: "value_transfers",
        value: "wit174la8pevl74hczcpfepgmt036zkmjen4hu8zzs",
        page: 1,
        pageSize: 1);
    print("Status: ${status}");
  } on ExplorerException catch (e) {
    print(e.message);
  }
}
