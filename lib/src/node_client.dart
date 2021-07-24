import 'dart:async';
import 'dart:convert';
import 'dart:io' show Socket;

import 'schema/node_rpc/node_response.dart';
import 'schema/node_rpc/node_stats.dart';
import 'schema/node_rpc/response_error.dart';
import 'schema/node_rpc/sync_status.dart';
import 'schema/node_rpc/get_utxo_info.dart';

class NodeClient {
  Socket _socket;
  String address;
  int port;
  int _id;
  List<String> messages = [];
  bool keepAlive;
  NodeClient({this.address, this.port, this.keepAlive = false});

  Future<SyncStatus> syncStatus() async{
    var response = await sendMessage(_socket, formatRequest(method: 'syncStatus'))
        .then((Map<String, dynamic> _data)  {
      SyncStatus _response = SyncStatus.fromJson(_data['result']);
      return _response;
    });
    return response;
  }
  Future<NodeStats> nodeStats() async{
    var response = await sendMessage(_socket, formatRequest(method: 'nodeStats'))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        NodeStats _response = NodeStats.fromMap(data['result']);
        return _response;
      }
    });
    return response;
  }
  /// The `inventory` method is used to submit transactions.
  Future<dynamic> inventory(Map<String,dynamic> inventoryItem) async{
    var response = await sendMessage(_socket, formatRequest(method: 'inventory', params: inventoryItem))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data;
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<dynamic> getBlockChain({int epoch, int limit}) async{
    var response = await sendMessage(_socket, formatRequest(method: 'getBlockChain',params: {'epoch': epoch, 'limit': limit}))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> getBlock({String blockHash}) async{
    var response = await sendMessage(_socket, formatRequest(method: 'getBlock',params: [blockHash]))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<dynamic> getTransaction(String transactionHash) async{
    var response = await sendMessage(_socket, formatRequest(method: 'getTransaction',params: [transactionHash]))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> dataRequestReport({String transactionHash}) async{
    var response = await sendMessage(_socket, formatRequest(method: 'dataRequestReport',params: [transactionHash]))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }


  Future<Map<String, dynamic>> getBalance({String address}) async{
    var response = await sendMessage(_socket, formatRequest(method: 'getBalance',params: [address] ))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> getReputation({String address}) async{
    var response = await sendMessage(_socket, formatRequest(method: 'getReputation',params: [address] ))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }

  Future<Map<String, dynamic>> getReputationAll() async{
    var response = await sendMessage(_socket, formatRequest(method: 'getReputationAll' ))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }
  Future<Map<String, dynamic>> peers() async{
    var response = await sendMessage(_socket, formatRequest(method: 'peers' ))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }
  Future<Map<String, dynamic>> knownPeers() async{
    var response = await sendMessage(_socket, formatRequest(method: 'knownPeers' ))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }
  Future<Map<String, dynamic>> getMempool() async{
    var response = await sendMessage(_socket, formatRequest(method: 'getMempool' ))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }
  Future<Map<String, dynamic>> getConsensusConstants() async{
    var response = await sendMessage(_socket, formatRequest(method: 'getConsensusConstants' ))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }
  Future<Map<String, dynamic>> getSuperBlock() async{
    var response = await sendMessage(_socket, formatRequest(method: 'getSuperBlock' ))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });
    return response;
  }
/// protected methods

  Future<UtxoInfo> getUtxoInfo({String address}) async{
    var response = await sendMessage(_socket, formatRequest(method: 'getUtxoInfo',params: [address] ))
        .then((Map<String, dynamic> data)  {
      if(data.containsKey('result')){
        return data['result'];
      } else if(data.containsKey('error')){
        print(json.encode(data));
        return ResponseError.fromJson(data['error']);
      }
    });

    return UtxoInfo.fromJson(response);
  }

  Map<String, dynamic> formatRequest({String method, dynamic params}){
    Map<String, dynamic> request = {
      'jsonrpc': '2.0',
      'method': '$method',
    };
    if (params != null){
      request['params'] = params;
    }
    if (keepAlive) {
      if(_id != null){
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
  Future<Map<String, dynamic>> sendMessage(Socket socket, Map<String, dynamic> message) async{
    var msg = json.encode(message) + '\n';
    final tmp = await _handle(msg);
    return tmp;
  }
  Future<Map<String, dynamic>> _handle(String _request) async {
    String _errorData;
    String _secureResponse;
    _errorData = "Server_Error";
    if (_request != null) {
      // =============================================================
      await Socket.connect("10.0.0.3", 21338).then((Socket sock) {
        _socket = sock;
      }).then((_) {
        // SENT TO NODE
        _socket.add(utf8.encode(_request));
        return _socket.first;
      }).then((data) {
        // GET FROM NODE
        _secureResponse =  new String.fromCharCodes(data).trim();

        closeSocket();
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

  void closeSocket(){
    _socket.close();
  }

}


Map<int, String> jsonErrors = {
  -32603: 'ItemNotFound',

};