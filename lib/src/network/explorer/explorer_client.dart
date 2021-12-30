import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io' show HttpException;

import 'package:witnet/data_structures.dart' show Utxo;
import 'package:witnet/explorer.dart';
import 'package:witnet/schema.dart' show VTTransaction;
import 'explorer_api.dart'
    show
        AddressBlocks,
        AddressDataRequestsSolved,
        AddressDetails,
        AddressValueTransfers,
        Blockchain,
        ExplorerException,
        HashInfo,
        Home,
        MintInfo,
        Network,
        Status,
        Tapi;

enum ExplorerMode {
  production,
  development,
}

class ExplorerClient {
  ExplorerClient({
    required this.url,
    required this.mode,
  }) : SSL = (mode == ExplorerMode.production) ? true : false;

  final String url;
  final ExplorerMode mode;
  late bool SSL;

  Uri api(String method, [Map<String, dynamic> params = const {}]) {
    if (SSL) {
      return Uri.https(url, 'api/$method', params);
    } else {
      return Uri.http(url, 'api/$method', params);
    }
  }

  Future<Map<String, dynamic>> _processGet(Uri uri) async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      // response is okay
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 500) {}
    throw ExplorerException(
        code: response.statusCode, message: response.reasonPhrase!);
  }

  Future<Map<String, dynamic>> _processPost(
      Uri uri, Map<String, dynamic> postData) async {
    var response = await http.post(
      uri,
      body: json.encode(postData),
    );
    if (response.statusCode == 200) {
      // response is okay
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 500) {
      throw HttpException(response.reasonPhrase!);
    }
    throw ExplorerException(
        code: response.statusCode, message: response.reasonPhrase!);
  }

  Future<List<Utxo>> getUtxoInfo({required String address}) async {
    Uri urlEndpoint = api('utxos', {'address': address});

    // Await the http get response, then decode the json-formatted response.
    try {
      var response = await http.get(urlEndpoint);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        List<dynamic> _utxos = jsonResponse[address]['utxos'] as List<dynamic>;
        List<Utxo> utxos = [];
        _utxos.forEach((element) {
          utxos.add(Utxo.fromJson(element));
        });

        return utxos;
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, List<Utxo>>> getMultiUtxoInfo(
      {required List<String> addresses}) async {
    int addressLimit = 10;
    Map<String, List<Utxo>> addressMap = {};

    List<Uri> urlCalls = [];

    for (int i = 0; i < addresses.length; i += addressLimit) {
      int end = (i + addressLimit < addresses.length)
          ? i + addressLimit
          : addresses.length;
      urlCalls
          .add(api('utxos', {'address': addresses.sublist(i, end).join(',')}));
    }
    // Await the http get response, then decode the json-formatted response.
    try {
      for (int i = 0; i < urlCalls.length; i++) {
        print('call $i');
        var response = await http.get(urlCalls[i]);
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          var jsonResponse = Map.from(convert.jsonDecode(response.body));
          jsonResponse.forEach((key, value) {
            List<Utxo> _utxos =
                List<Utxo>.from(value['utxos'].map((ut) => Utxo.fromJson(ut)));
            print(_utxos);
            addressMap[key] = _utxos;
          });
        }
      }

      return addressMap;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<dynamic> sendVTTransaction(VTTransaction transaction,
      {bool testing = true}) async {
    Uri uri = Uri.dataFromString('content');
    http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: transaction.jsonMap,
      encoding: convert.utf8,
    );
    return response;
  }

  Future<dynamic> hash(String value, [bool simple = true]) async {
    /// TODO:
    try {
      Uri uri = api('hash', {'value': value, 'simple': simple.toString()});
      var data = await _processGet(uri);
      print(data);
      HashInfo hashInfo = HashInfo.fromJson(data);
      if (hashInfo.isMined() || hashInfo.isConfirmed()) {
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
          }
        }
      }
      return hashInfo;
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"hash": "${e.message}"}');
    }
  }

  Future<Home> home() async {
    try {
      return Home.fromJson(await _processGet(api('home')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"home": "${e.message}"}');
    }
  }

  Future<Network> network() async {
    try {
      return Network.fromJson(await _processGet(api('network')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"network": "${e.message}"}');
    }
  }

  Future<Status> status() async {
    try {
      return Status.fromJson(await _processGet(api('status')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"status": "${e.message}"}');
    }
  }

  Future<dynamic> pending() async {
    try {
      return await _processGet(api('pending'));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"pending": "${e.message}"}');
    }
  }

  Future<dynamic> reputation() async {
    try {
      return await _processGet(api('reputation'));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"reputation": "${e.message}"}');
    }
  }

  Future<dynamic> richList({int start = 0, int stop = 1000}) async {
    try {
      return await _processGet(
          api('richlist', {'start': '$start', 'stop': '$stop'}));
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
      var data =
          await _processGet(api('address', {'value': value, 'tab': tab}));
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
          await _processGet(api('blockchain', {'block': '$block'})));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"blockchain": "${e.message}"}');
    }
  }

  Future<Tapi> tapi() async {
    try {
      return Tapi.fromJson(await _processGet(api('tapi')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"tapi": "${e.message}"}');
    }
  }

  Future<dynamic> send(
      {required Map<String, dynamic> transaction, bool test = false}) async {
    try {
      var response = await _processPost(api('send'), transaction);
      if (response.containsKey('error')) {
        throw ExplorerException(code: -3, message: response['error']);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

/*

 */
