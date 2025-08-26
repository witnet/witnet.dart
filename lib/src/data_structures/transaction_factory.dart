import 'package:witnet/schema.dart'
    show
        DRTransaction,
        DRTransactionBody,
        DataRequestOutput,
        Input,
        KeyedSignature,
        VTTransaction,
        VTTransactionBody,
        ValueTransferOutput;
import 'package:witnet/src/crypto/address.dart' show Address;
import 'package:witnet/src/crypto/secp256k1/private_key.dart';
import 'package:witnet/constants.dart'
    show ALPHA, GAMMA, INPUT_SIZE, OUTPUT_SIZE;
import 'package:witnet/src/schema/schema.dart' show PublicKeyHash;
import 'package:witnet/src/utils/transformations/transformations.dart'
    show isHexStringOfLength;
import '../../data_structures.dart';
import 'package:convert/convert.dart';

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

ValueTransferOutput createMetadataOutput(String metadata) {
  if (!isHexStringOfLength(metadata, 20)) {
    throw TransactionError(-1, 'Metadata must be a 20-byte hex string');
  }

  final cleanMetadata =
      metadata.startsWith('0x') ? metadata.substring(2) : metadata;

  // Convert hex string into raw List of bytes
  final metadataBytes = hex.decode(cleanMetadata);

  final metadataPkh = PublicKeyHash()..hash = metadataBytes;

  return ValueTransferOutput.fromJson({
    'pkh': metadataPkh.address,
    'value': 1,
    'time_lock': 0,
  });
}

Future<dynamic> createVTTransaction({
  required List<ValueTransferOutput> outputs,
  required WitPrivateKey privateKey,
  Address? changeAddress,
  required dynamic networkSource,
  required UtxoSelectionStrategy utxoStrategy,
  FeeType? feeType,
  int fee = 0,
  String? metadata,
}) async {
  List<ValueTransferOutput> allOutputs = outputs;

  if (metadata != null) {
    allOutputs.add(createMetadataOutput(metadata));
  }

  int outputValue = 0;
  int totalUtxoValue = 0;
  int selectedUtxoValue = 0;
  allOutputs.forEach((ValueTransferOutput output) {
    outputValue += output.value.toInt();
  });

  Address signerAddress = Address.fromAddress(privateKey.publicKey.address);
  // if the changeAddress param is left blank send the change to the signer
  Address _changeAddress = changeAddress ?? signerAddress;

  await signerAddress.getUtxoInfo(source: networkSource);
  List<Input> inputs = [];

  List<Utxo> utxoPool = signerAddress.utxoPool!.sortUtxos(utxoStrategy);
  utxoPool.forEach((utxo) {
    totalUtxoValue += utxo.value;
  });

  if (totalUtxoValue < outputValue) {
    return TransactionError(-1, 'Insufficient funds.');
  }

  List<Utxo> selectedUtxos = [];

  var _outputValue = outputValue;

  while (_outputValue > 0) {
    Utxo utxo = utxoPool.first;
    utxoPool.removeAt(0);
    selectedUtxos.add(utxo);
    _outputValue -= utxo.value;
  }

  selectedUtxos.forEach((Utxo utxo) {
    inputs.add(utxo.toInput());
    print('${utxo.toInput().outputPointer.jsonMap(asHex: true)} ${utxo.value}');
    selectedUtxoValue += utxo.value;
  });
  print(selectedUtxoValue);
  int change = selectedUtxoValue - outputValue;

  if (change > 0) {
    // receive the change to this address
    FeeType absFee = FeeType.Absolute;
    // if feeType is null use Absolute fee
    switch (feeType ?? absFee) {
      case FeeType.Absolute:
        if (change > fee) {
          allOutputs.add(_changeAddress.receive(change - fee));
        } else if (change == fee) {
          // do nothing with the change since it is the fee.
        } else {
          // get additional utxos to cover the fee
          while (fee > change) {
            Utxo nextUtxo = utxoPool.first;
            utxoPool.removeAt(0);
            selectedUtxos.add(nextUtxo);
            inputs.add(nextUtxo.toInput());
            selectedUtxoValue += nextUtxo.value;
            change = selectedUtxoValue - outputValue;
          }
        }
        break;
      case FeeType.Weighted:
        print('Current Change: $change');
        var inputCount = inputs.length;
        var outputCount = allOutputs.length;
        var currentWeight = vttWeight(inputCount, outputCount);
        print('Inputs: $inputCount, Outputs: $outputCount');
        print('Current Weight -> $currentWeight');
        if (change == currentWeight) {
          // do nothing with the change since it is the currentWeight
        } else if (change > currentWeight) {
          // account for the weight of an additional output for the change
          int newWeight = vttWeight(inputCount, outputCount + 1);
          // is the new weight greater than the change?
          if (newWeight > change) {
            // need additional utxos to cover the weighted fee
            while (newWeight > change) {
              Utxo nextUtxo = utxoPool.first;
              utxoPool.removeAt(0);
              inputs.add(nextUtxo.toInput());
              selectedUtxoValue += nextUtxo.value;
              change = selectedUtxoValue - outputValue;
              newWeight = vttWeight(inputs.length, outputCount + 1);
            }
          }
          allOutputs.add(_changeAddress.receive(change - newWeight));
        } else {
          // need additional utxos to cover the weighted fee
        }
        break;
    }
  }

  VTTransactionBody body =
      VTTransactionBody(inputs: inputs, outputs: allOutputs);
  VTTransaction transaction = VTTransaction(body: body, signatures: []);

  KeyedSignature signature =
      signerAddress.signHash(transaction.transactionID, privateKey);
  for (int i = 0; i < transaction.body.inputs.length; i++) {
    transaction.signatures.add(signature);
  }
  return transaction;
}

Future<dynamic> createDRTransaction(
    DataRequestOutput dataRequestOutput,
    WitPrivateKey privateKey,
    Address? changeAddress,
    dynamic networkSource,
    FeeType feeType,
    UtxoSelectionStrategy utxoStrategy,
    [int fee = 0]) async {
  List<Input> inputs = [];
  List<ValueTransferOutput> outputs = [];
  // value owed from the data request
  int droValue =
      dataRequestOutput.witnesses * dataRequestOutput.witnessReward.toInt();
  int amountOwed = droValue;
  print('Total Witness Reward -> $droValue');
  dataRequestOutput;
  Address signerAddress = Address.fromAddress(privateKey.publicKey.address);
  // if the changeAddress param is left blank send the change to the signer
  Address _changeAddress = changeAddress ?? signerAddress;

  await signerAddress.getUtxoInfo(source: networkSource);
  List<Utxo> utxoPool = signerAddress.utxoPool!.sortUtxos(utxoStrategy);
  int totalUtxoValue = 0;

  utxoPool.forEach((utxo) {
    totalUtxoValue += utxo.value;
  });
  if (utxoPool.isEmpty) {
    return TransactionError(-1, 'Insufficient funds.');
  }
  assert(totalUtxoValue > amountOwed, 'Insufficient funds.');
  List<Utxo> selectedUtxos = [];
  int selectedUtxoValue = 0;
  switch (feeType) {
    case FeeType.Absolute:
      amountOwed += fee;
      var _outputValue = amountOwed;
      while (_outputValue > 0) {
        Utxo utxo = utxoPool.first;
        utxoPool.removeAt(0);
        selectedUtxos.add(utxo);
        _outputValue -= utxo.value;
      }
      selectedUtxos.forEach((Utxo utxo) {
        inputs.add(utxo.toInput());
        selectedUtxoValue += utxo.value;
      });
      int change = selectedUtxoValue - amountOwed;
      if (change > 0) {
        outputs.add(_changeAddress.receive(change));
      }

      break;
    case FeeType.Weighted:
      // get utxos to cover the base value before weight
      var _outputValue = amountOwed;
      while (_outputValue > 0) {
        Utxo utxo = utxoPool.first;
        utxoPool.removeAt(0);
        selectedUtxos.add(utxo);
        _outputValue -= utxo.value;
      }
      selectedUtxos.forEach((Utxo utxo) {
        inputs.add(utxo.toInput());
        selectedUtxoValue += utxo.value;
      });

      int change = selectedUtxoValue - amountOwed;
      int inputCount = inputs.length;
      int outputCount = outputs.length;
      int droWeight = dataRequestOutput.weight;
      int droExtraWeight = dataRequestOutput.extraWeight;

      // estimate at least 1 output, currently zero in the list
      int currentWeight =
          drWeight(inputCount, outputCount + 1, droWeight, droExtraWeight);

      if (currentWeight == change) {
      } else if (currentWeight < change) {
        outputs.add(_changeAddress.receive(change - currentWeight));
      } else {}

      break;
  }
  DRTransactionBody body = DRTransactionBody(
      inputs: inputs, outputs: outputs, drOutput: dataRequestOutput);
  DRTransaction transaction = DRTransaction(body: body, signatures: []);
  KeyedSignature signature =
      signerAddress.signHash(transaction.transactionID, privateKey);
  for (int i = 0; i < transaction.body.inputs.length; i++) {
    transaction.signatures.add(signature);
  }
  return transaction;
}

int vttWeight(int inputCount, int outputCount) =>
    (inputCount * INPUT_SIZE) + (outputCount * OUTPUT_SIZE * GAMMA);

int drWeight(
    int inputCount, int outputCount, int droWeight, int droExtraWeight) {
  final int inputsWeight = inputCount * INPUT_SIZE;
  final int outputsWeight = outputCount * OUTPUT_SIZE;
  final drWeight = inputsWeight + outputsWeight + droWeight * ALPHA;
  final drExtraWeight = droExtraWeight;
  return drWeight + drExtraWeight;
}

class TransactionError {
  int id;
  String message;
  TransactionError(this.id, this.message);
  @override
  String toString() {
    // TODO: implement toString
    return 'TransactionError{id: $id, message: $message}';
  }
}
