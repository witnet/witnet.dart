import 'dart:typed_data' show Uint8List;

import 'package:pointycastle/ecc/api.dart';
import 'package:witnet/node_rpc.dart';
import 'package:witnet/schema.dart';
import 'package:witnet/src/crypto/hd_wallet/extended_private_key.dart';
import 'package:witnet/src/crypto/secp256k1/private_key.dart';
import 'package:witnet/src/crypto/secp256k1/public_key.dart';
import 'package:witnet/src/crypto/secp256k1/secp256k1.dart';
import 'package:witnet/src/data_structures/transaction_factory.dart';
import 'package:witnet/src/data_structures/utxo_pool.dart';
import 'package:witnet/src/utils/bech32/bech32.dart';
import 'package:witnet/src/utils/bech32/codec.dart';
import 'package:witnet/src/utils/transformations/transformations.dart';

import '../schema/node_rpc/get_utxo_info.dart';

import '../schema/public_key.dart';
import '../schema/public_key_hash.dart';

class Address {
  String address;
  WitPublicKey publicKey;
  PublicKeyHash publicKeyHash;
  UtxoInfo _utxoInfo;
  UtxoPool utxoPool;
  Address({this.address, this.publicKeyHash, this.publicKey});

  factory Address.fromAddress(String address){
    return Address(
      address: address,
      publicKeyHash: PublicKeyHash.fromAddress(address),
    );
  }
  factory Address.fromPublicKeyHash({Uint8List hash}){
    return Address(
      address: bech32.encode(Bech32(hrp: 'wit', data: hash.toList())),
      publicKeyHash: PublicKeyHash(hash: hash),
    );
  }

  int get balanceNanoWit {
    int value = 0;
    if (_utxoInfo != null) {
      utxos.forEach((Utxo utxo) { value += utxo.value; });
    }
    return value;
  }

  double get balanceWit {
    return nanoWitToWit(balanceNanoWit);
  }



  List<Utxo> get utxos {
    if(_utxoInfo != null) {
      return _utxoInfo.utxos;
    }
    return [];
}
  ValueTransferOutput receive(int value, {int timeLock = 0}){
    return ValueTransferOutput.fromJson({
      'pkh': address,
      'time_lock': timeLock,
      'value': value,
    });
  }

  VTTransaction createVTT({
    List<ValueTransferOutput> to,
    WitPrivateKey privateKey,
    UtxoSelectionStrategy utxoStrategy,
    FeeType feeType,
    int fee = 0,
  }){
    int totalValue = 0;
    int utxoValue = 0;
    to.forEach((ValueTransferOutput output) { totalValue += output.value; });
    totalValue += fee;

    List<Input> inputs = [];

    List<Utxo> selectedUtxos = utxoPool.selectUtxos(outputs: to, utxoStrategy: utxoStrategy, fee: fee);
    selectedUtxos.forEach((Utxo utxo) {
      inputs.add(utxo.toInput());
      print(utxo.toInput().outputPointer.jsonMap);
      utxoValue += utxo.value;
    });
    int change = utxoValue - totalValue;
    assert (change >=0, 'Insufficient funds.');

    if( change > 0){
      // receive the change to this address
      to.add(receive(change));
    }

    VTTransactionBody body = VTTransactionBody(inputs: inputs, outputs: to);
    VTTransaction transaction = VTTransaction(body: body, signatures: []);

    //print(verify(transaction.transactionID, sig, privateKey.toPublicKey()));
    KeyedSignature signature = signHash(transaction.transactionID, privateKey);
    for (int i = 0; i < transaction.body.inputs.length; i ++){
      transaction.signatures.add(signature);
    }
    if(feeType == FeeType.Weighted){
    }
    print('Inputs: ${transaction.body.inputs.length}');
    print('Signatures: ${transaction.signatures.length}');
    return transaction;
  }
  KeyedSignature signHash(String hash, WitPrivateKey privateKey){
    final sig = privateKey.signature(hash);

    int compressed = privateKey.publicKey.encode().elementAt(0);
    Uint8List key_bytes = privateKey.publicKey.encode().sublist(1);

    return KeyedSignature(
      publicKey: PublicKey(bytes: key_bytes, compressed: compressed),
      signature: Signature(secp256K1: Secp256k1Signature(der: sig.encode())),
    );
  }
  void _setUtxoInfo(UtxoInfo utxoInfo) {
    _utxoInfo = utxoInfo;
    utxoPool = UtxoPool();
    _utxoInfo.utxos.forEach((utxo) { utxoPool.insert(utxo); });
  }

  /// To get the UtxoInfo for an address. the `source` can be NodeClient
  /// TODO: add ExplorerClient as a source
  Future<bool> getUtxoInfo({dynamic source}) async {
    if (source.runtimeType == NodeClient){
      UtxoInfo utxoInfo = await source.getUtxoInfo(address: address);
      _setUtxoInfo(utxoInfo);
      return true;
    }
  }
}
