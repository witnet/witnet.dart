import 'dart:convert' show json;

import 'package:web_socket_channel/web_socket_channel.dart' show WebSocketChannel;
import 'package:web_socket_channel/status.dart' as status;
import 'package:witnet/radon.dart';
import '../rad_request.dart';

class WalletClient{
  String address;
  int port;
  late int _id;
  late WebSocketChannel channel;
  bool keepAlive;
  bool awaitingWallet = false;
  late String _message = '';

  WalletClient(this.address, this.port, {this.keepAlive = false});


  Future<Map<String, dynamic>> runRadRequest(RADRequest request) async {
    var rad = request.toJson();
    print(rad);
    var req = formatRequest(method: 'run_rad_request', params: {'rad_request': rad});
    var response = await handle(json.encode(req));
    print(response);
    return response['result'];

  }
  Future<String> createMnemonics({required int length}) async {
    var req = formatRequest(method: 'create_mnemonics', params: {'length': 12});
    var response = await handle(json.encode(req));
    return response['result']!['mnemonics'];
  }

  Future<bool> canConnect() async{
    bool valid;

      var req = formatRequest(
          method: 'create_mnemonics', params: {'length': 12});
      var response = await handle(json.encode(req));
      if (response.keys.contains('Error')){
        return false;
      }
      return true;
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

  void connect(){
    channel = WebSocketChannel.connect(Uri.parse('ws://$address:$port'));
  }

  void close(){
    channel.sink.close(status.goingAway);
  }

  Future<Map<String, dynamic>> handle(String _request) async {
    Map<String, dynamic> response = {};
    try{
      connect();
      channel.sink.add(_request);
      await for (var value in channel.stream){
        response = json.decode(value);
        channel.sink.close();
      };
    } catch (e){
      response = {'Error': e};
    }

    return response;
  }
}