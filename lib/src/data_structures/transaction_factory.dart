import 'package:witnet/schema.dart';


class TransactionInfo {
  final List<Input> inputs;
  final List<ValueTransferOutput> outputs;
  final int input_value;
  final int output_value;
  final int fee;

  TransactionInfo(
      {required this.inputs,
      required this.outputs,
      required this.input_value,
      required this.output_value,
      required this.fee});
}

enum FeeType {
  Absolute,
  Weighted,
}
