
import 'dart:convert' show json, utf8;
import 'dart:io' show Socket, SocketException;


import 'node_api.dart' show NodeStats, NodeException, UtxoInfo, SyncStatus;

import 'package:witnet/schema.dart' show Block, Transaction;

class NodeClient {
  String address;
  int port;
  late int _id;
  List<String> messages = [];
  bool keepAlive;
  String _secureResponse = '';
  Socket? _socket;
  NodeClient(
      {required this.address, required this.port, this.keepAlive = false});


  Future<SyncStatus> syncStatus() async {
    try{
      var response = await sendMessage(formatRequest(method: 'syncStatus'))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          SyncStatus _response = SyncStatus.fromJson(data['result']);
          return _response;
        }
      });
      return response!;
    } on NodeException catch(e) {
      throw NodeException(code: e.code, message: '{"syncStatus": "${e.message}"}');
    }

  }

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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"nodeStats": "${e.message}"}');
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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"inventory": "${e.message}"}');
    }
  }

  Future<dynamic> getBlockChain({required int epoch, required int limit}) async {
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
    }  on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getBlockChain": "${e.message}"}');
    }
  }

  Future<Block> getBlock({required String blockHash}) async {
    try {
      var response = await sendMessage(
              formatRequest(method: 'getBlock', params: [blockHash]))
          .then((Map<String, dynamic> data) {

        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          print(json.encode(data));
          throw NodeException.fromJson(data['error']);
        }
      });
      return Block.fromJson(response);
    }  on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getBlock": "${e.message}"}');
    }
  }

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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getTransaction": "${e.message}"}');
    }
  }

  Future<Map<String, dynamic>> dataRequestReport({required String transactionHash}) async {
    try{
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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"dataRequestReport": "${e.message}"}');
    }
  }

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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getBalance": "${e.message}"}');
    }
  }

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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getReputation": "${e.message}"}');
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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getReputationAll": "${e.message}"}');
    }
  }

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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"peers": "${e.message}"}');
    }
  }

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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"knownPeers": "${e.message}"}');
    }
  }

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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getMempool": "${e.message}"}');
    }
  }

  Future<Map<String, dynamic>> getConsensusConstants() async {
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
      return response;
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getConsensusConstants": "${e.message}"}');
    }
  }

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
    } on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getSuperBlock": "${e.message}"}');
    }
  }

  /// protected methods

  Future<UtxoInfo> getUtxoInfo({required String address}) async {
    try {
      var response = await sendMessage(
              formatRequest(method: 'getUtxoInfo', params: [address]))
          .then((Map<String, dynamic> data) {
        if (data.containsKey('result')) {
          return data['result'];
        } else if (data.containsKey('error')) {
          print(json.encode(data));
          throw NodeException.fromJson(data['error']);
        }
      });

      return UtxoInfo.fromJson(response);
    }  on NodeException catch(e){
      throw NodeException(code: e.code, message: '{"getUtxoInfo": "${e.message}"}');
    }
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

      _id += 1;
      request['id'] = _id;

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


    try {
      // =============================================================
      _socket = await Socket.connect(address, port).then((Socket sock) {
        _socket = sock;
      }).then((_) {
        // SENT TO NODE
        _socket!.add(utf8.encode(_request));
        return _socket!.first;
      }).then((data) {
        // GET FROM NODE
        _secureResponse = new String.fromCharCodes(data).trim();
        _socket!.close();
        return _socket;
      });
    } on SocketException catch(e){
      throw NodeException(code: e.osError!.errorCode, message: e.message);
    } catch (e) {
      throw NodeException(code: -1, message: e.toString());
    }
    Map<String, dynamic> response = json.decode(_secureResponse);
    return response;
  }
}

Map<int, String> jsonErrors = {
  -32603: 'ItemNotFound',
};
