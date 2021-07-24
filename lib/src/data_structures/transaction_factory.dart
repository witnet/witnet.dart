
import 'package:witnet/schema.dart';

import '../../node_rpc.dart';

class TransactionInfo{
  List<Input> inputs;
  List<ValueTransferOutput> outputs;
  int input_value;
  int output_value;
  int fee;

}


enum FeeType{
  Absolute,
  Weighted,

}

VTTransaction buildVTT(
{
  List<ValueTransferOutput> outputs,
  int fee,
  List<Utxo> utxos,

}
){

}