import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:witnet/schema.dart';
import 'package:witnet/src/data_structures/transaction_factory.dart';

void main() async {
  group("create_metadata_output", () {
    test("Create Metadata Output", () {
      ValueTransferOutput vto1 =
          createMetadataOutput("0x1111AbA2164AcdC6D291b08DfB374280035E1111");
      expect(vto1.value.toInt(), 1);
      expect(vto1.pkh.address, 'wit1zyg6hgskftxud553kzxlkd6zsqp4uyg3zd9q6h');

      ValueTransferOutput vto2 =
          createMetadataOutput("0x77703aE126B971c9946d562F41Dd47071dA00777");
      expect(vto2.value.toInt(), 1);
      expect(vto2.pkh.address, 'wit1wacr4cfxh9cun9rd2ch5rh28quw6qpmhk0ydga');
    });
  });
}
