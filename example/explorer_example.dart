import 'package:witnet/explorer.dart';

String explorerUrl = 'witnet.network';
ExplorerClient explorer =
    ExplorerClient(url: explorerUrl, mode: ExplorerMode.production);

void main() async {
  try {
    Status status = await explorer.status();
    PrioritiesEstimate priority = await explorer.valueTransferPriority();
    print("Status: ${status.databaseMessage}");
    print("Priority ${priority.vttHigh.priority}");
  } on ExplorerException catch (e) {
    print(e.message);
  }
}
