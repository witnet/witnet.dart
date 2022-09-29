import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:witnet/constants.dart';
import 'package:witnet/schema.dart';

void main() async {
  test('Value Transfer Weight', () => expect(testVtWeight(), true));
  test('Data Request Weight', () => expect(testDrWeight(), true));
}

bool testVtWeight() {
  /// test vt transaction weight with 1 input and 1 output
  try {
    final vtBody =
        VTTransactionBody(inputs: [Input()], outputs: [ValueTransferOutput()]);
    final vtTransaction = VTTransaction(body: vtBody, signatures: []);
    assert(INPUT_SIZE + OUTPUT_SIZE * GAMMA == vtTransaction.weight);
    assert(493 == vtTransaction.weight);
  } catch (e) {
    return false;
  }

  /// test vt transaction weight with 2 inputs and 1 output
  try {
    final vtBody = VTTransactionBody(
        inputs: List<Input>.generate(2, (index) => Input()),
        outputs: [ValueTransferOutput()]);
    final vtTransaction = VTTransaction(body: vtBody, signatures: []);
    assert(2 * INPUT_SIZE + OUTPUT_SIZE * GAMMA == vtTransaction.weight);
    assert(626 == vtTransaction.weight);
  } catch (e) {
    return false;
  }

  /// test vt transaction weight with 1 input and 2 output
  try {
    final vtBody = VTTransactionBody(
        inputs: [Input()],
        outputs: List<ValueTransferOutput>.generate(
            2, (index) => ValueTransferOutput()));
    final vtTransaction = VTTransaction(body: vtBody, signatures: []);

    assert(INPUT_SIZE + 2 * OUTPUT_SIZE * GAMMA == vtTransaction.weight);
    assert(853 == vtTransaction.weight);
  } catch (e) {
    return false;
  }
  return true;
}

bool testDrWeight() {
  /// test dr transaction weight with 2 witnesses
  try {
    final dro = DataRequestOutput(witnesses: 2);
    final drBody = DRTransactionBody(
      inputs: [Input()],
      outputs: [ValueTransferOutput()],
      drOutput: dro.clone(),
    );
    final drTransaction = DRTransaction(body: drBody, signatures: []);
    assert(1587 == drTransaction.weight);
  } catch (e) {
    return false;
  }

  /// test dr transaction weight with 5 witnesses
  try {
    final int witnessCount = 5;
    final DataRequestOutput dro = DataRequestOutput(witnesses: witnessCount);
    final DRTransactionBody drBody = DRTransactionBody(
      inputs: [Input()],
      outputs: [ValueTransferOutput()],
      drOutput: dro.clone(),
    );
    final drTransaction = DRTransaction(body: drBody, signatures: []);
    assert(3495 == drTransaction.weight);
  } catch (e) {
    return false;
  }
  return true;
}
