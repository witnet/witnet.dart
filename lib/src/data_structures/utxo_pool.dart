import 'dart:math' show Random;

import 'package:witnet/schema.dart' show OutputPointer, ValueTransferOutput;

import 'utxo.dart' show Utxo;
import 'package:witnet/utils.dart' show nanoWitToWit;

enum UtxoSelectionStrategy {
  Random,
  SmallFirst,
  LargeFirst,
}

class UtxoPool {
  Map<OutputPointer, Utxo> map = {};

  void insert(Utxo utxo) {
    map[utxo.outputPointer] = utxo;
  }

  void remove(Utxo utxo) {
    map.remove(utxo.outputPointer);
  }

  List<Utxo> shuffleUtxos() {
    List<Utxo> items = map.values.toList();
    var random = new Random();
    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }

  List<Utxo> sortUtxos(UtxoSelectionStrategy utxoSelectionStrategy) {
    List<Utxo> sortedUtxos;
    switch (utxoSelectionStrategy) {
      case UtxoSelectionStrategy.Random:
        {
          sortedUtxos = shuffleUtxos();
        }
        break;
      case UtxoSelectionStrategy.LargeFirst:
        {
          sortedUtxos = map.values.toList()
            ..sort((e1, e2) {
              var diff = e2.value.compareTo(e1.value);
              if (diff == 0) diff = e2.value.compareTo(e1.value);
              return diff;
            });
        }
        break;
      case UtxoSelectionStrategy.SmallFirst:
        {
          sortedUtxos = map.values.toList()
            ..sort((e1, e2) {
              var diff = e1.value.compareTo(e2.value);
              if (diff == 0) diff = e1.value.compareTo(e2.value);
              return diff;
            });
        }
    }
    return sortedUtxos;
  }

  List<Utxo> selectUtxos(
      {required List<ValueTransferOutput> outputs,
      required UtxoSelectionStrategy utxoStrategy,
}) {
    List<Utxo> utxos = sortUtxos(utxoStrategy);
    if (utxos.isEmpty) {
      print('Error -> no Utxos to select.');
      return [];
    }
    int utxoValue = 0;
    int outputValue = 0;

    utxos.forEach((utxo) {
      utxoValue += utxo.value;
    });

    // total the output value
    outputs.forEach((output) {
      outputValue += output.value;
    });
    List<Utxo> selectedUtxos = [];
    print('selecting Utxos to cover ${nanoWitToWit(outputValue)}');
    if (outputValue > utxoValue) {
      print('Insufficient funds.');
      return [];
    }
    while (outputValue > 0) {
      // since the list is sorted - take the first item
      Utxo utxo = utxos.first;
      utxos.removeAt(0);
      selectedUtxos.add(utxo);
      outputValue -= utxo.value;
    }

    return selectedUtxos;
  }
}
