import 'dart:typed_data' show Uint8List;
import 'package:witnet/data_structures.dart'
    show
        createDRTransaction,
        createVTTransaction,
        FeeType,
        Utxo,
        UtxoPool,
        UtxoSelectionStrategy;

import 'secp256k1/private_key.dart' show WitPrivateKey;
import 'secp256k1/public_key.dart' show WitPublicKey;

import 'package:witnet/explorer.dart' show ExplorerClient;
import 'package:witnet/node.dart' show UtxoInfo, NodeClient;
import 'package:witnet/utils.dart'
    show bech32, Bech32, convertBits, nanoWitToWit;
import 'package:witnet/schema.dart'
    show
        DRTransaction,
        DRTransactionBody,
        KeyedSignature,
        PublicKey,
        PublicKeyHash,
        Secp256k1Signature,
        Signature,
        VTTransaction,
        ValueTransferOutput;

class Address {
  String address;
  WitPublicKey? publicKey;
  PublicKeyHash? publicKeyHash;
  UtxoInfo? _utxoInfo;
  UtxoPool? utxoPool;

  Address({required this.address, this.publicKeyHash, this.publicKey});

  factory Address.fromAddress(String address) {
    return Address(
      address: address,
      publicKeyHash: PublicKeyHash.fromAddress(address),
    );
  }

  factory Address.fromPublicKeyHash({required Uint8List hash}) {
    return Address(
      address: bech32.encode(Bech32(
          hrp: 'wit',
          data: Uint8List.fromList(
              convertBits(data: hash.toList(), from: 8, to: 5, pad: false)))),
      publicKeyHash: PublicKeyHash(hash: hash),
    );
  }

  int get balanceNanoWit {
    int value = 0;
    if (_utxoInfo != null) {
      utxos.forEach((Utxo utxo) {
        value += utxo.value;
      });
    }
    return value;
  }

  double get balanceWit {
    return nanoWitToWit(balanceNanoWit);
  }

  List<Utxo> get utxos {
    if (_utxoInfo != null) {
      return _utxoInfo!.utxos;
    }
    return [];
  }

  ValueTransferOutput receive(int value, {int timeLock = 0}) {
    return ValueTransferOutput.fromJson({
      'pkh': address,
      'time_lock': timeLock,
      'value': value,
    });
  }

  Future<VTTransaction> createVTT({
    required List<ValueTransferOutput> outputs,
    required WitPrivateKey privateKey,
    Address? changeAddress,
    required UtxoSelectionStrategy utxoStrategy,
    FeeType? feeType,
    int fee = 0,
    required dynamic networkSource,
  }) async {
    return await createVTTransaction(
        outputs: outputs,
        privateKey: privateKey,
        changeAddress: (changeAddress != null)
            ? changeAddress
            : Address.fromAddress(privateKey.publicKey.address),
        feeType: feeType,
        fee: fee,
        utxoStrategy: utxoStrategy,
        networkSource: networkSource);
  }

  Future<DRTransaction> createDRT({
    required DRTransactionBody body,
    required WitPrivateKey privateKey,
    required UtxoSelectionStrategy utxoStrategy,
    FeeType? feeType,
    int fee = 0,
    dynamic networkSource,
  }) async {
    return await createDRTransaction(
        body.drOutput,
        privateKey,
        Address.fromAddress(privateKey.publicKey.address),
        networkSource,
        feeType!,
        utxoStrategy);
  }

  KeyedSignature signHash(String hash, WitPrivateKey privateKey) {
    final sig = privateKey.signature(hash);
    int compressed = privateKey.publicKey.encode().elementAt(0);
    Uint8List key_bytes = privateKey.publicKey.encode().sublist(1);
    return KeyedSignature(
      publicKey: PublicKey(bytes: privateKey.publicKey.encode()),
      signature: Signature(secp256k1: Secp256k1Signature(der: sig.encode())),
    );
  }

  void _setUtxoInfo(UtxoInfo utxoInfo) {
    _utxoInfo = utxoInfo;
    utxoPool = UtxoPool();
    _utxoInfo!.utxos.forEach((utxo) {
      utxoPool!.insert(utxo);
    });
  }

  /// To get the UtxoInfo for an address. the `source` can be NodeClient
  /// TODO: add ExplorerClient as a source
  Future<bool> getUtxoInfo({dynamic source}) async {
    if (source.runtimeType == NodeClient) {
      UtxoInfo utxoInfo = await source.getUtxoInfo(address: address);
      _setUtxoInfo(utxoInfo);
      return true;
    } else if (source.runtimeType == ExplorerClient) {
      List<Utxo> _utxos = await source.getUtxoInfo(address: address);
      UtxoInfo utxoInfo = UtxoInfo(collateralMin: 0, utxos: _utxos);
      _setUtxoInfo(utxoInfo);
    }
    return false;
  }
}
