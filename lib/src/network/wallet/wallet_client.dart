import 'dart:convert' show json;

import 'package:web_socket_channel/web_socket_channel.dart'
    show WebSocketChannel, WebSocketChannelException;
import 'package:web_socket_channel/status.dart' as status;
import 'package:witnet/schema.dart';
import 'package:witnet/src/network/wallet/wallet_api.dart';

class WalletClient {
  String address;
  int port;
  late int _id;
  late WebSocketChannel channel;
  bool keepAlive;
  bool awaitingWallet = false;

  WalletClient(this.address, this.port, {this.keepAlive = false});

  Future<Map<String, dynamic>> runRadRequest(RADRequest request) async {
    try {
      var rad = request.jsonMap();
      print(rad);
      var req = formatRequest(
          method: 'run_rad_request', params: {'rad_request': rad});
      var response = await handle(json.encode(req));
      print(response);
      return response['result'];
    } on WalletException catch (e) {
      throw WalletException(
          code: e.code, message: '{"run_rad_request": "${e.message}"}');
    }
  }

  Future<String> createMnemonics({required int length}) async {
    try {
      var req =
          formatRequest(method: 'create_mnemonics', params: {'length': length});
      var response = await handle(req);
      return response['result']!['mnemonics'];
    } on WalletException catch (e) {
      throw WalletException(
          code: e.code, message: '{"create_mnemonics": "${e.message}"}');
    }
  }

  Future<dynamic> validateMnemonics({required String mnemonics}) async {
    try {
      var req = formatRequest(
          method: 'validate_mnemonics',
          params: {'seed_data': mnemonics, 'seed_source': 'mnemonics'});
      var response = await handle(req);
      return response['result'];
    } on WalletException catch (e) {
      throw WalletException(
          code: e.code, message: '{"validate_mnemonics": "${e.message}"}');
    }
  }

  Future<GetWalletInfosResponse> getWalletInfos() async {
    try {
      var req = formatRequest(method: 'get_wallet_infos');
      var response = await handle(req);
      return GetWalletInfosResponse.fromJson(response['result']);
    } on WalletException {
      rethrow;
    }
  }

  //password, seed_source, name, description, overwrite, birth_date
  Future<dynamic> createWallet({
    required String seedData,
    required String password,
    String seedSource = 'mnemonics',
    bool overwrite = false,
    int? birthDate,
  }) async {
    try {
      var req = formatRequest(method: 'create_wallet', params: {
        'seed_data': seedData,
        'seed_source': seedSource,
        'password': password,
        'overwite': overwrite,
        'birth_date': birthDate
      });
      var response = await handle(req);
      return response['result'];
    } on WalletException catch (e) {
      throw WalletException(
          code: e.code, message: '{"create_wallet": "${e.message}"}');
    }
  }

  Future<WalletInfo> unlockWallet(
      {required String walletId, required String password}) async {
    try {
      var req = formatRequest(
          method: 'unlock_wallet',
          params: {'wallet_id': walletId, 'password': password});
      var response = await handle(req);
      return WalletInfo.fromJson(response['result']);
    } on WalletException catch (e) {
      throw WalletException(
          code: e.code, message: '{"unlock_wallet": "${e.message}"}');
    }
  }

  Future<dynamic> lockWallet(
      {required String walletId,
      required String sessionId,
      required String password}) async {
    try {
      var req = formatRequest(method: 'lock_wallet', params: {
        'wallet_id': walletId,
        'session_id': sessionId,
        'password': password
      });

      var response = await handle(req);
      return response['result'];
    } on WalletException catch (e) {
      throw WalletException(
          code: e.code, message: '{"lock_wallet": "${e.message}"}');
    }
  }

  Future<dynamic> generateAddress(
      {required String walletId,
      required String sessionId,
      bool? external,
      String? label}) async {
    try {
      var req = formatRequest(method: 'generate_address', params: {
        'wallet_id': walletId,
        'session_id': sessionId,
        'external': external,
        'label': label
      });

      var response = await handle(req);
      return response['result'];
    } on WalletException catch (e) {
      throw WalletException(
          code: e.code, message: '{"generate_address": "${e.message}"}');
    }
  }

  Future<GetAddressesResponse> getAddresses(
      {required String walletId,
      required String sessionId,
      int offset = 0,
      int limit = 0,
      bool? external}) async {
    try {
      var req = formatRequest(method: 'get_addresses', params: {
        'wallet_id': walletId,
        'session_id': sessionId,
        'external': external,
        'offset': offset,
        'limit': limit,
      });

      var response = await handle(req);
      return GetAddressesResponse.fromJson(response['result']);
    } on WalletException catch (e) {
      throw WalletException(
          code: e.code, message: '{"get_addresses": "${e.message}"}');
    }
  }

  Future<bool> canConnect() async {
    var req = formatRequest(method: 'create_mnemonics', params: {'length': 12});
    var response = await handle(req);
    if (response.keys.contains('Error')) {
      return false;
    }
    return true;
  }

  String formatRequest({required String method, dynamic params}) {
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
    return json.encode(request);
  }

  void connect() {
    channel = WebSocketChannel.connect(Uri.parse('ws://$address:$port'));
  }

  void close() {
    channel.sink.close(status.goingAway);
  }

  Future<Map<String, dynamic>> handle(String _request) async {
    Map<String, dynamic> response = {};
    try {
      connect();
      channel.sink.add(_request);
      await for (var value in channel.stream) {
        response = json.decode(value);
        channel.sink.close();
      }
      ;
      close();
      if (response.keys.contains('error')) {
        throw WalletException(
            code: response['error']['code'],
            message: response['error']['message']);
      }
    } on WebSocketChannelException catch (e) {
      throw WalletException(code: e.hashCode, message: e.inner.toString());
    }
    return response;
  }

  Future<dynamic> updateWallet(
      {required String walletId,
      required String sessionId,
      required String name,
      required String description}) async {
    // TODO:
    throw UnimplementedError('updateWallet');
  }

  Future<dynamic> resyncWallet() async {
    // TODO:
    throw UnimplementedError('resyncWallet');
  }

  Future<dynamic> closeSession() async {
    // TODO:
    throw UnimplementedError('closeSession');
  }

  Future<dynamic> refreshSession() async {
    // TODO:
    throw UnimplementedError('refreshSession');
  }

  Future<dynamic> getBalance({
    required String walletId,
    required String sessionId,
  }) async {
    // TODO:
    throw UnimplementedError('getBalance');
  }

  Future<dynamic> getUtxoInfo({
    required String walletId,
    required String sessionId,
  }) async {
    // TODO:
    throw UnimplementedError('getUtxoInfo');
  }

  Future<dynamic> getTransactions({
    required String walletId,
    required String sessionId,
    required int offset,
    required int limit,
  }) async {
    // TODO:
    throw UnimplementedError('getTransactions');
  }

  Future<dynamic> sendTransaction({
    required String walletId,
    required String sessionId,
    required Transaction transaction,
  }) async {
    // TODO:
    throw UnimplementedError('sendTransaction');
  }

  Future<dynamic> createDataRequest({
    required String walletId,
    required String sessionId,
    required Map<String, dynamic> params,
  }) async {
    // TODO:
    throw UnimplementedError('createDataRequest');
  }

  Future<dynamic> createVTT({
    required String walletId,
    required String sessionId,
    required Map<String, dynamic> params,
  }) async {
    // TODO:
    throw UnimplementedError('createVTT');
  }

  Future<dynamic> signData({
    required String walletId,
    required String sessionId,
  }) async {
    // TODO:
    throw UnimplementedError('signData');
  }

  Future<dynamic> exportMasterKey(
      {required String walletId,
      required String sessionId,
      required String password}) async {
    // TODO:
    throw UnimplementedError('exportMasterKey');
  }

  Future<dynamic> shutdown({
    required String walletId,
    required String sessionId,
  }) async {
    // TODO:
    throw UnimplementedError('shutdown');
  }
}
