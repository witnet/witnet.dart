import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'dart:convert' as convert;
import 'dart:io' show HttpException;

import 'package:witnet/data_structures.dart' show Utxo;
import 'package:witnet/explorer.dart';
import 'package:witnet/schema.dart';

enum ExplorerMode {
  production,
  development,
}

class RetryHttpClient {
  RetryHttpClient() : retryClient = RetryClient(http.Client());

  RetryClient retryClient;

  Future<Map<String, dynamic>> _makeHttpRequest(
    Future<http.Response> Function(Uri uri, {dynamic body}) requestMethod,
    Uri uri,
    dynamic data,
  ) async {
    var response;
    try {
      response = await requestMethod(uri, body: data);
    } on http.ClientException catch (e) {
      if (e.message.contains('Client is already closed')) {
        retryClient = RetryClient(http.Client());
        response = await requestMethod(uri, body: data);
      }
    }

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 500) {
      throw HttpException(response.reasonPhrase!);
    } else if (response.containsKey('error')) {
      throw ExplorerException(code: -3, message: response['error']);
    }
    throw ExplorerException(
        code: response.statusCode, message: response.reasonPhrase!);
  }

  Future<Map<String, dynamic>> get(Uri uri) async {
    return _makeHttpRequest(
      (Uri uri, {dynamic body}) async {
        return await retryClient.get(uri);
      },
      uri,
      null,
    );
  }

  Future<Map<String, dynamic>> post(
      Uri uri, Map<String, dynamic> postData) async {
    return _makeHttpRequest(
      (Uri uri, {dynamic body}) async {
        return await retryClient.post(uri, body: json.encode(body));
      },
      uri,
      postData,
    );
  }
}

class ExplorerClient {
  ExplorerClient({
    required this.url,
    required this.mode,
  })  : SSL = (mode == ExplorerMode.production) ? true : false,
        client = RetryHttpClient();

  final String url;
  final ExplorerMode mode;
  final bool SSL;
  final RetryHttpClient client;

  Uri api(String method, [Map<String, dynamic> params = const {}]) {
    if (SSL) {
      return Uri.https(url, 'api/$method', params);
    } else {
      return Uri.http(url, 'api/$method', params);
    }
  }

  Future<List<Utxo>> getUtxoInfo({required String address}) async {
    try {
      Uri urlEndpoint = api('utxos', {'address': address});

      // Await the http get response, then decode the json-formatted response.
      var response = await client.get(urlEndpoint);
      List<dynamic> _utxos = response[address]['utxos'] as List<dynamic>;
      List<Utxo> utxos = [];
      _utxos.forEach((element) {
        utxos.add(Utxo.fromJson(element));
      });

      return utxos;
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"getUtxoInfo": "${e.message}"}');
    }
  }

  Future<Map<String, List<Utxo>>> getMultiUtxoInfo(
      {required List<String> addresses}) async {
    try {
      int addressLimit = 10;
      Map<String, List<Utxo>> addressMap = {};

      List<Uri> urlCalls = [];

      for (int i = 0; i < addresses.length; i += addressLimit) {
        int end = (i + addressLimit < addresses.length)
            ? i + addressLimit
            : addresses.length;
        urlCalls.add(
            api('utxos', {'address': addresses.sublist(i, end).join(',')}));
      }
      // Await the http get response, then decode the json-formatted response.
      for (int i = 0; i < urlCalls.length; i++) {
        var response = await client.get(urlCalls[i]);
        response.forEach((key, value) {
          List<Utxo> _utxos =
              List<Utxo>.from(value['utxos'].map((ut) => Utxo.fromJson(ut)));
          addressMap[key] = _utxos;
        });
      }

      return addressMap;
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"getMultiUtxoInfo": "${e.message}"}');
    }
  }

  Future<dynamic> sendVTTransaction(VTTransaction transaction,
      {bool testing = true}) async {
    return await send(
        transaction:
            Transaction(valueTransfer: transaction).jsonMap(asHex: true));
  }

  Future<dynamic> hash(String value, [bool simple = true]) async {
    try {
      Uri uri = api('hash', {'value': value, 'simple': simple.toString()});
      var data = await client.get(uri);
      if (data.containsKey('type')) {
        switch (data['type'] as String) {
          case 'value_transfer_txn':
            return ValueTransferInfo.fromJson(data);
          case 'data_request_txn':
          case 'commit_txn':
          case 'reveal_txn':
          case 'tally_txn':
          case 'mint_txn':
            MintInfo mintInfo = MintInfo.fromJson(data);
            return mintInfo;
          case 'block':
            return BlockDetails.fromJson(data);
        }
      }
    } catch (e) {
      throw ExplorerException(code: 0, message: '{"hash": "$e"}');
    }
  }

  Future<Home> home() async {
    try {
      return Home.fromJson(await client.get(api('home')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"home": "${e.message}"}');
    }
  }

  Future<Network> network() async {
    try {
      return Network.fromJson(await client.get(api('network')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"network": "${e.message}"}');
    }
  }

  Future<Status> status() async {
    try {
      return Status.fromJson(await client.get(api('status')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"status": "${e.message}"}');
    }
  }

  Future<dynamic> mempool({String key = 'live'}) async {
    try {
      if (['live', 'history'].contains(key)) {
        return await client.get(api('mempool', {'key': '$key'}));
      }
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"mempool": "${e.message}"}');
    }
  }

  Future<dynamic> reputation() async {
    try {
      return await client.get(api('reputation'));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"reputation": "${e.message}"}');
    }
  }

  Future<dynamic> richList({int start = 0, int stop = 1000}) async {
    try {
      return await client
          .get(api('richlist', {'start': '$start', 'stop': '$stop'}));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"richList": "${e.message}"}');
    }
  }

  Future<dynamic> address(
      {required String value,
      required String tab,
      int? limit,
      int? epoch}) async {
    try {
      var data = await client.get(api('address', {'value': value, 'tab': tab}));
      switch (tab) {
        case 'blocks':
          return AddressBlocks.fromJson(data);
        case 'details':
          return AddressDetails.fromJson(data);
        case 'data_requests_solved':
          return AddressDataRequestsSolved.fromJson(data);
        case 'data_requests_launched':
          // TODO: implement method
          //  waiting on the explorer to return valid response
          break;
        case 'value_transfers':
          return AddressValueTransfers.fromJson(data);
      }
      return data;
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"address": "${e.message}"}');
    }
  }

  Future<Blockchain> blockchain({int block = -100}) async {
    try {
      return Blockchain.fromJson(
          await client.get(api('blockchain', {'block': '$block'})));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"blockchain": "${e.message}"}');
    }
  }

  Future<Tapi> tapi() async {
    try {
      return Tapi.fromJson(await client.get(api('tapi')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"tapi": "${e.message}"}');
    }
  }

  Future<dynamic> send(
      {required Map<String, dynamic> transaction, bool test = false}) async {
    try {
      return await client.post(api('send'), transaction);
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"send": "${e.message}"}');
    }
  }

  Future<PrioritiesEstimate> valueTransferPriority() async {
    try {
      return PrioritiesEstimate.fromJson(
          await client.get(api('priority', {"type": "vtt"})));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"priority": "${e.message}"}');
    }
  }
}
