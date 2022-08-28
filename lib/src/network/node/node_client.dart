import 'dart:async';
import 'dart:convert' show Utf8Decoder, json, utf8;
import 'dart:io' show Socket, SocketException;
import 'dart:math';
import 'dart:typed_data';

import 'package:witnet/utils.dart';

import 'node_api.dart' show NodeStats, NodeException, UtxoInfo, SyncStatus;

import 'package:witnet/schema.dart' show Block, Transaction;

class NodeClient {
  String address;
  int port;
  List<String> messages = [];
  int? _id;
  bool keepAlive;


  late Socket _socket;
  Uint8List _buffer = Uint8List.fromList([]);

  NodeClient({required this.address,
    required this.port,
    this.keepAlive = false});

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
  Future<dynamic> nodeStats() async {
    try {
      var response = await sendMessage(formatRequest(method: 'nodeStats'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          NodeStats _response = NodeStats.fromMap(data['result']);
          return _response;
        }
      });
      return response;
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
      throw NodeException(
          code: e.code, message: '{"inventory": "${e.message}"}');
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
  Future<Map<String, dynamic>> peers() async {
    try {
      var response = await sendMessage(formatRequest(method: 'peers'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
    } on NodeException catch (e) {
      throw NodeException(code: e.code, message: '{"peers": "${e.message}"}');
    }
  }

  /// Get list of known peers
  Future<Map<String, dynamic>> knownPeers() async {
    try {
      var response = await sendMessage(formatRequest(method: 'knownPeers'))
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
  Future<Map<String, dynamic>> getConsensusConstants() async {
    try {
      var response =
      await sendMessage(formatRequest(method: 'getConsensusConstants'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          print(json.encode(data));
          throw NodeException.fromJson(data['error']);
        }
      });
      return response;
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
          print(json.encode(data));
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
    var msg = json.encode(message) + '\n';
    final tmp = await _handle(msg);
    return tmp;
  }

  /// Handle the Socket connection for the Node
  Future<Map<String, dynamic>> _handle(String _request) async {
    Completer<Map<String, dynamic>> _completer =
    new Completer<Map<String, dynamic>>();

    String _secureResponse = '';

    try {
      if (_request != null) {
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
              // incomplete buffer
            }
          },
          onError: (e) {},
          onDone: () {
            _socket.close();
          },
        );
        _socket.add(utf8.encode(_request));
      }
    } on SocketException catch (e) {
      throw NodeException(code: e.osError!.errorCode, message: e.message);
    } catch (e) {
      throw NodeException(code: -1, message: e.toString());
    }
    return _completer.future;
  }
}