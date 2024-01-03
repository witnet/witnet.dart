import 'package:witnet/explorer.dart';

String explorerUrl = 'witscan.xyz';
ExplorerClient explorer =
    ExplorerClient(url: explorerUrl, mode: ExplorerMode.production);
void main() async {
  try {
    dynamic status = await explorer.address(
        tab: "value_transfers",
        value: "wit1zl7ty0lwr7atp5fu34azkgewhtfx2fl4wv69cw",
        page: 1,
        pageSize: 1);
    print("Status: ${status}");
  } on ExplorerException catch (e) {
    print(e.message);
  }
}
