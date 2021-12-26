import 'dart:convert' show json;
import 'package:witnet/schema.dart';
import 'package:witnet/src/schema/reveal_transaction.dart';
import 'package:witnet/src/schema/tally_transaction.dart';

import '../constants.dart' show GAMMA;

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

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex:asHex));

  factory Transaction.fromJson(Map<String, dynamic> json) {
    var _transaction;
    var _transactionType;
    if (json.containsKey('transaction')) {
      Map<String, dynamic> _txn = json['transaction'];
      var type = _txn.keys.first;
      switch (type) {
        case 'ValueTransfer':
            _transaction = VTTransaction.fromJson(_txn['ValueTransfer']);
            _transactionType = TransactionType.ValueTransfer;
            break;
        case 'Mint':
            _transaction = MintTransaction.fromJson(_txn['Mint']);
            _transactionType = TransactionType.Mint;
            break;
        case 'DataRequest':
            _transaction = DRTransaction.fromJson(_txn['DataRequest']);
            _transactionType = TransactionType.DataRequest;
            break;
        case 'Commit':
            _transaction = CommitTransaction.fromJson(_txn['Commit']);
            _transactionType = TransactionType.Commit;
            break;
        case 'Reveal':
            _transaction = RevealTransaction.fromJson(_txn['Reveal']);
            _transactionType = TransactionType.Reveal;
            break;
        case 'Tally':
            _transaction = TallyTransaction.fromJson(_txn['Tally']);
            _transactionType = TransactionType.Tally;
            break;
      }
    } else{
      throw ArgumentError('Invalid json');
    }
    return Transaction(transaction: _transaction, transactionType: _transactionType);
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
          int _weight = drTransaction.body.weight;
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

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
        "transaction": transaction.jsonMap(asHex: asHex),
      };
}
