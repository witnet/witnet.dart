import 'dart:convert';
import 'data_request_transaction.dart';
import 'input.dart';
import 'value_transfer_output.dart';

import 'value_transfer_transaction.dart';
import 'mint_transaction.dart';

import '../constants.dart';

enum TransactionType {
  ValueTransfer,
  Mint,
  DataRequest,
  Commit,
  Reveal,
  Tally,
}

class Transaction {
  Transaction({
    required this.transaction,
    required this.transactionType,
  });

  dynamic transaction;
  TransactionType transactionType;

  factory Transaction.fromRawJson(String str) =>
      Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) {
    var _transaction;
    var _transactionType;
    if (json.containsKey('ValueTransfer')) {
      _transactionType = TransactionType.ValueTransfer;
      _transaction = VTTransaction.fromJson(json['ValueTransfer']);
    } else if (json.containsKey('Mint')) {
      _transactionType = TransactionType.Mint;
      _transaction = MintTransaction.fromJson(json['Mint']);
    } else if (json.containsKey('DataRequest')) {
      _transactionType = TransactionType.DataRequest;
    } else if (json.containsKey('Commit')) {
      _transactionType = TransactionType.Commit;
    } else if (json.containsKey('Reveal')) {
      _transactionType = TransactionType.Reveal;
    } else if (json.containsKey('Tally')) {
      _transactionType = TransactionType.Tally;
    }
    return Transaction(
      transaction: _transaction,
      transactionType: _transactionType,
    );
  }

  int get weight {
    switch (transactionType) {
      case TransactionType.ValueTransfer:
        {
          VTTransaction vtTransaction = transaction as VTTransaction;
          int _weight = 0;
          int numInputs = vtTransaction.body.inputs.length;
          int numOutputs = vtTransaction.body.outputs.length;
          _weight = 1 * numInputs * 3 * numOutputs * GAMMA;
          return _weight;
        }
      case TransactionType.DataRequest:
        {
          DRTransaction drTransaction = transaction as DRTransaction;
          int _weight = 0;
          return _weight;
        }
      case TransactionType.Mint:
        break;
      case TransactionType.Commit:
        break;
      case TransactionType.Reveal:
        break;
      case TransactionType.Tally:
        break;
    }
    return 0;
  }

  Map<String, dynamic> toJson() => {
        "$transactionType": transaction.toJson(),
      };
}
