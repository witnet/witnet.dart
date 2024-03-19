import 'package:witnet/explorer.dart';

String explorerUrl = 'witnet.network';
ExplorerClient explorer =
    ExplorerClient(url: explorerUrl, mode: ExplorerMode.production);
void main() async {
  try {
    String address = 'wit174la8pevl74hczcpfepgmt036zkmjen4hu8zzs';
    dynamic valueTransfers = await explorer.address(
        tab: "value_transfers", value: address, page: 1, pageSize: 1);
    print("List of Vtts from address ${address}: ${valueTransfers}");
  } on ExplorerException catch (e) {
    print(e.message);
  }
}
