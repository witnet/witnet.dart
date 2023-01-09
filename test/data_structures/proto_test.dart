import 'dart:typed_data';

import 'package:test/expect.dart';
import 'package:witnet/schema.dart';
import 'package:test/scaffolding.dart';
import 'package:witnet/src/utils/transformations/transformations.dart';

main() async {
  test('PublicKey Protobuf Serialize & Deserialize', () {
    expect(testPublicKeyProto(), true);
  });

  test('Value Transfer Transaction Test', () {
    expect(testVttProto(), true);
  });
}

bool testPublicKeyProto() {
  try {
    int compressed = 0x03;
    List<int> bytes = List<int>.generate(32, (index) => 0x4a);
    PublicKey testPublicKey = PublicKey(
        bytes: concatBytes([
      Uint8List.fromList([compressed]),
      Uint8List.fromList(bytes)
    ]));
    Uint8List pkBytes = testPublicKey.pbBytes;
    PublicKey deserializePublicKey = PublicKey.fromBuffer(pkBytes);
    assert(testPublicKey == deserializePublicKey);
  } catch (e) {
    print(e);
    return false;
  }
  return true;
}

bool testVttProto() {
  VTTransaction vtTransaction = VTTransaction(
      body: VTTransactionBody(
          inputs: [Input()], outputs: [ValueTransferOutput()]));

  print(vtTransaction.pbBytes);

  return true;
}
