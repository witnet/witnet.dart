import 'package:witnet/schema.dart';

extension Metadata on VTTransaction {
  List<PublicKeyHash> get metadata {
    List<PublicKeyHash> metadata = this
        .body
        .outputs
        .where((ValueTransferOutput output) => output.value == 1)
        .map((ValueTransferOutput output) => output.pkh)
        .toList();

    return metadata;
  }
}
