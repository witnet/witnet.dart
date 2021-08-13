import 'dart:async';
import 'dart:convert';
import 'dart:io' show Socket;


import 'schema/node_rpc/node_stats.dart';
import 'schema/node_rpc/response_error.dart';
import 'schema/node_rpc/sync_status.dart';
import 'schema/node_rpc/get_utxo_info.dart';

import 'package:witnet/schema.dart' show Block;

class NodeClient {
  String address;
  int port;
  late int _id;
  List<String> messages = [];
  bool keepAlive;

  NodeClient(
      {required this.address, required this.port, this.keepAlive = false});

  Future<SyncStatus> syncStatus() async {
    var response = await sendMessage(formatRequest(method: 'syncStatus'))
        .then((Map<String, dynamic> _data) {
      SyncStatus _response = SyncStatus.fromJson(_data['result']);
      return _response;
    });
    return response;
  }

  Future<dynamic> nodeStats() async {
    var response = await sendMessage(formatRequest(method: 'nodeStats'))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        NodeStats _response = NodeStats.fromMap(data['result']);
        return _response;
      }
    });
    return response;
  }

  /// The `inventory` method is used to submit transactions.
  Future<dynamic> inventory(Map<String, dynamic> inventoryItem) async {
    var response = await sendMessage(
            formatRequest(method: 'inventory', params: inventoryItem))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data;
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<dynamic> getBlockChain({required int epoch, required int limit}) async {
    var response = await sendMessage(formatRequest(
            method: 'getBlockChain', params: {'epoch': epoch, 'limit': limit}))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Block> getBlock({required String blockHash}) async {
    var response = await sendMessage(
            formatRequest(method: 'getBlock', params: [blockHash]))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return Block.fromJson(response);
  }

  Future<dynamic> getTransaction(String transactionHash) async {
    var response = await sendMessage(
            formatRequest(method: 'getTransaction', params: [transactionHash]))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> dataRequestReport({required String transactionHash}) async {
    var response = await sendMessage(formatRequest(
        method: 'dataRequestReport',
        params: [transactionHash])).then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> getBalance({required String address}) async {
    var response = await sendMessage(
            formatRequest(method: 'getBalance', params: [address]))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> getReputation({required String address}) async {
    var response = await sendMessage(
            formatRequest(method: 'getReputation', params: [address]))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> getReputationAll() async {
    var response = await sendMessage(formatRequest(method: 'getReputationAll'))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> peers() async {
    var response = await sendMessage(formatRequest(method: 'peers'))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> knownPeers() async {
    var response = await sendMessage(formatRequest(method: 'knownPeers'))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> getMempool() async {
    var response = await sendMessage(formatRequest(method: 'getMempool'))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> getConsensusConstants() async {
    var response =
        await sendMessage(formatRequest(method: 'getConsensusConstants'))
            .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> getSuperBlock() async {
    var response = await sendMessage(formatRequest(method: 'getSuperBlock'))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  /// protected methods

  Future<UtxoInfo> getUtxoInfo({required String address}) async {
    var response = await sendMessage(
            formatRequest(method: 'getUtxoInfo', params: [address]))
        .then((Map<String, dynamic> data) {
      if (data.containsKey('result')) {
        return data['result'];
      } else if (data.containsKey('error')) {
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });

    return UtxoInfo.fromJson(response);
  }

  Map<String, dynamic> formatRequest({required String method, dynamic params}) {
    Map<String, dynamic> request = {
      'jsonrpc': '2.0',
      'method': '$method',
    };
    if (params != null) {
      request['params'] = params;
    }
    if (keepAlive) {
      if (_id != null) {
        _id += 1;
        request['id'] = _id;
      } else {
        _id = 1;
        request['id'] = _id;
      }
    } else {
      request['id'] = 1;
    }
    return request;
  }

  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> message) async {
    var msg = json.encode(message) + '\n';
    final tmp = await _handle(msg);
    return tmp;
  }

  Future<Map<String, dynamic>> _handle(String _request) async {
    String _errorData;
    String _secureResponse = '';
    Socket? _socket;
    _errorData = "Server_Error";
    if (_request != null) {
      // =============================================================
      await Socket.connect(address, port).then((Socket sock) {
        _socket = sock;
      }).then((_) {
        // SENT TO NODE
        _socket!.add(utf8.encode(_request));
        return _socket!.first;
      }).then((data) {
        // GET FROM NODE
        _secureResponse = new String.fromCharCodes(data).trim();

        _socket!.close();
      }).catchError((AsyncError e) {
        _secureResponse = _errorData;
      });
      // ==============================================================
    } else {
      _secureResponse = _errorData;
    }
    Map<String, dynamic> response = json.decode(_secureResponse);
    return response;
  }
}

Map<int, String> jsonErrors = {
  -32603: 'ItemNotFound',
};
