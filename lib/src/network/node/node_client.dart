import 'dart:async';
import 'dart:convert' show json;
import 'dart:io' show Socket, SocketException;
import 'dart:typed_data';

import 'package:witnet/utils.dart';

import 'node_api.dart'
    show NodeException, NodeStats, Peer, SyncStatus, UtxoInfo;

import 'package:witnet/schema.dart'
    show
        Block,
        ConsensusConstants,
        DRTransaction,
        KeyedSignature,
        StakeTransaction,
        Transaction,
        UnstakeTransaction,
        VTTransaction;

class NodeClient {
  String address;
  int port;
  List<String> messages = [];
  int? _id;

  int? get id => _id;
  bool keepAlive;

  late Socket _socket;
  Uint8List _buffer = Uint8List.fromList([]);

  NodeClient({
    required this.address,
    required this.port,
    this.keepAlive = false,
  });

  /// Get node status

  Future<SyncStatus> syncStatus() async {
    try {
      var response = await sendMessage(formatRequest(method: 'syncStatus'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          SyncStatus _response = SyncStatus.fromJson(data['result']);
          return _response;
        }
      });
      return response!;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"syncStatus": "${e.message}"}');
    }
  }

  /// Get the node stats
  Future<NodeStats> nodeStats() async {
    try {
      var response = await sendMessage(formatRequest(method: 'nodeStats'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          NodeStats _response = NodeStats.fromMap(data['result']);
          return _response;
        }
      });
      return response!;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"nodeStats": "${e.message}"}');
    }
  }

  /// The `inventory` method is used to submit transactions.
  Future<dynamic> inventory(Map<String, dynamic> inventoryItem) async {
    try {
      var response = await sendMessage(
              formatRequest(method: 'inventory', params: inventoryItem))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
    } on NodeException catch (e) {
      print("${e.message}");
      return false;
    }
  }

  Future<dynamic> sendVTTransaction(VTTransaction vtTransaction) async {
    return await inventory({
      'transaction': {'ValueTransfer': vtTransaction.jsonMap(asHex: false)}
    });
  }

  Future<dynamic> sendDRTransaction(DRTransaction drTransaction) async {
    return await inventory({
      'transaction': {'DataRequest': drTransaction.jsonMap(asHex: false)}
    });
  }

  Future<dynamic> sendStakeTransaction(
      {required StakeTransaction stake}) async {
    return await inventory({
      'transaction': {'Stake': stake.jsonMap(asHex: false)}
    });
  }

  Future<bool> sendUnstakeTransaction(
      {required UnstakeTransaction unstake}) async {
    try {
      /// returns true if success
      return await inventory({
        'transaction': {'Unstake': unstake.jsonMap(asHex: false)}
      });
    } on NodeException catch (_) {
      print("${_.message}");
      return false;
    }
  }

  Future<int?> queryStakes(String? validator, String? withdrawer) async {
    try {
      Map<String, String> params = {};
      if (validator != null) params['Validator'] = validator;
      if (withdrawer != null) params['Withdrawer'] = withdrawer;
      var _ = await sendMessage(
              formatRequest(method: 'queryStakes', params: params))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data;
        }
        if (data.containsKey('error')) {
          return 0;
        }
      });
    } on NodeException catch (_) {}
    return null;
  }

  Future<KeyedSignature> authorizeStake(String withdrawer) async {
    try {
      var response = await sendMessage(formatRequest(
              method: 'authorizeStake', params: {'withdrawer': withdrawer}))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          KeyedSignature sig =
              KeyedSignature.fromJson(data['result']['signature']);
          return sig;
        }
      });
      return response!;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"authorizeStake": "${e.message}"}');
    }
  }

  /// Get the list of all the known block hashes.
  Future<dynamic> getBlockChain(
      {required int epoch, required int limit}) async {
    try {
      var response = await sendMessage(formatRequest(
              method: 'getBlockChain',
              params: {'epoch': epoch, 'limit': limit}))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
        if (data.containsKey('result')) {
          return data['result'];
        }
      });
      return response;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getBlockChain": "${e.message}"}');
    } catch (e) {}
  }

  /// Get block by hash
  Future<Block> getBlock({required String blockHash}) async {
    try {
      var response = await sendMessage(
              formatRequest(method: 'getBlock', params: [blockHash]))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return Block.fromJson(response);
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getBlock": "${e.message}"}');
    }
  }

  /// Get transaction by hash
  Future<dynamic> getTransaction(String transactionHash) async {
    try {
      var response = await sendMessage(formatRequest(
          method: 'getTransaction',
          params: [transactionHash])).then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return Transaction.fromJson(data['result']);
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getTransaction": "${e.message}"}');
    }
  }

  /// Data request info
  Future<Map<String, dynamic>> dataRequestReport(
      {required String transactionHash}) async {
    try {
      var response = await sendMessage(formatRequest(
          method: 'dataRequestReport',
          params: [transactionHash])).then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"dataRequestReport": "${e.message}"}');
    }
  }

  /// Get balance
  Future<Map<String, dynamic>> getBalance({required String address}) async {
    try {
      var response = await sendMessage(
              formatRequest(method: 'getBalance', params: [address]))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getBalance": "${e.message}"}');
    }
  }

  /// Get Reputation of one pkh
  Future<Map<String, dynamic>> getReputation({required String address}) async {
    try {
      var response = await sendMessage(
              formatRequest(method: 'getReputation', params: [address]))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getReputation": "${e.message}"}');
    }
  }

  Future<Map<String, dynamic>> getReputationAll() async {
    try {
      var response =
          await sendMessage(formatRequest(method: 'getReputationAll'))
              .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getReputationAll": "${e.message}"}');
    }
  }

  /// Get list of consolidated peers
  Future<List<Peer>> peers() async {
    try {
      var response = await sendMessage(formatRequest(method: 'peers'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return List<Peer>.from(data['result']);
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response!;
    } on NodeException catch (e) {
      throw NodeException(code: e.code, message: '{"peers": "${e.message}"}');
    }
  }

  /// Get list of known peers
  Future<List<Peer>> knownPeers() async {
    try {
      var response = await sendMessage(formatRequest(method: 'knownPeers'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          List<Peer> peers = [];
          List<dynamic> rawPeers = data["result"];
          rawPeers.forEach((element) {
            peers.add(Peer.fromJson(element));
          });

          return peers;
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response!;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"knownPeers": "${e.message}"}');
    }
  }

  /// Get all the pending transactions
  Future<Map<String, dynamic>> getMempool() async {
    try {
      var response = await sendMessage(formatRequest(method: 'getMempool'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getMempool": "${e.message}"}');
    }
  }

  /// Get consensus constants used by the node
  Future<ConsensusConstants> getConsensusConstants() async {
    try {
      var response =
          await sendMessage(formatRequest(method: 'getConsensusConstants'))
              .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return ConsensusConstants.fromJson(response);
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getConsensusConstants": "${e.message}"}');
    }
  }

  /// Get the blocks that pertain to the superblock index
  Future<Map<String, dynamic>> getSuperBlock() async {
    try {
      var response = await sendMessage(formatRequest(method: 'getSuperBlock'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getSuperBlock": "${e.message}"}');
    }
  }

  /// Get utxos
  Future<UtxoInfo> getUtxoInfo({required String address}) async {
    try {
      var response = await sendMessage(
              formatRequest(method: 'getUtxoInfo', params: [address]))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });

      return UtxoInfo.fromJson(response);
    } on NodeException catch (e) {
      throw NodeException(
          code: e.code, message: '{"getUtxoInfo": "${e.message}"}');
    }
  }

  /// Create JSON RPC request
  Map<String, dynamic> formatRequest({required String method, dynamic params}) {
    if (_id == null) {
      _id = 0;
    }

    Map<String, dynamic> request = {
      'jsonrpc': '2.0',
      'method': '$method',
    };
    if (params != null) {
      request['params'] = params;
    }
    if (keepAlive) {
      _id = _id! + 1;
      request['id'] = _id;
    } else {
      request['id'] = 1;
    }
    return request;
  }

  /// Send a request to the Node and wait for a response
  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> message) async {
    try {
      final msg = json.encode(message) + '\n';
      final response = await _handle(msg);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Handle the Socket connection for the Node
  Future<Map<String, dynamic>> _handle(String _request) async {
    Completer<Map<String, dynamic>> _completer =
        new Completer<Map<String, dynamic>>();

    try {
      // =============================================================
      _socket = await Socket.connect(address, port);
      _socket.listen(
        (Uint8List data) {
          // add the current chunk to the end of the buffer
          _buffer = concatBytes([_buffer, data]);
          // try to decode the buffer
          try {
            // this will throw an error if the _buffer is not complete
            Map<String, dynamic> response =
                json.decode(new String.fromCharCodes(_buffer).trim());

            // clear the buffer
            _buffer = Uint8List.fromList([]);
            _completer.complete(response);
            _socket.destroy();
          } on FormatException catch (e) {
            throw (e);
            // incomplete buffer
          }
        },
        onError: (e) {},
        onDone: () {
          _socket.close();
        },
      );
      _socket.add(utf8.encode(_request));
    } on SocketException catch (e) {
      throw NodeException(code: e.osError!.errorCode, message: e.message);
    } catch (e) {
      throw NodeException(code: -1, message: e.toString());
    }
    return _completer.future;
  }
}
