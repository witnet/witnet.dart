import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io' show HttpException;

import 'package:witnet/data_structures.dart' show Utxo;
import 'package:witnet/explorer.dart';
import 'package:witnet/schema.dart';
import 'explorer_api.dart'
    show
        AddressBlocks,
        AddressDataRequestsSolved,
        AddressValueTransfers,
        BlockDetails,
        Mempool,
        Blockchain,
        ExplorerException,
        NetworkBalances,
        Home,
        MintInfo,
        NetworkReputation,
        PrioritiesEstimate,
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

  // This function can return Map<String, dynamic> or List<Map<String, dynamic>>
  Future<dynamic> _processGet(Uri uri) async {
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
    Uri urlEndpoint = api('address/utxos', {'addresses': address});

    // Await the http get response, then decode the json-formatted response.
    try {
      var response = await http.get(urlEndpoint);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        List<dynamic> _utxos = jsonResponse[0]['utxos'] as List<dynamic>;
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
      urlCalls.add(api(
          'address/utxos', {'addresses': addresses.sublist(i, end).join(',')}));
    }
    // Await the http get response, then decode the json-formatted response.
    try {
      for (int i = 0; i < urlCalls.length; i++) {
        var response = await http.get(urlCalls[i]);
        if (response.statusCode == 200) {
          var jsonResponse = Map.from(convert.jsonDecode(response.body));
          jsonResponse.forEach((key, value) {
            List<Utxo> _utxos =
                List<Utxo>.from(value['utxos'].map((ut) => Utxo.fromJson(ut)));
            addressMap[key] = _utxos;
          });
        }
      }

      return addressMap;
    } catch (e) {
      throw e;
    }
  }

  // TBD
  Future<dynamic> sendVTTransaction(VTTransaction transaction,
      {bool testing = true}) async {
    return await send(
        transaction:
            Transaction(valueTransfer: transaction).jsonMap(asHex: true));
  }

  Future<dynamic> hash(String value, [bool simple = true]) async {
    try {
      Uri uri =
          api('search/hash', {'value': value, 'simple': simple.toString()});
      var data = await _processGet(uri);
      if (data.containsKey('response_type')) {
        switch (data['response_type'] as String) {
          case 'value_transfer':
            return ValueTransferInfo.fromJson(data);
          case 'block':
            return BlockDetails.fromJson(data);
          // fixme: add support for pending
          // case 'pending':

          // fixme: add support for data requests
          case 'data_request':
          case 'commit':
          case 'reveal':
          case 'tally':
          case 'data_request_report':
          case 'data_request_history':
          case 'mint':
            return MintInfo.fromJson(data);
        }
      }
    } catch (e) {
      throw ExplorerException(code: 0, message: '{"hash": "$e"}');
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

  Future<NetworkBalances> networkBalances({int? page, int? pageSize}) async {
    try {
      return NetworkBalances.fromJson(await _processGet(
          api('network/balances', {"page": page, "page_size": pageSize})));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"network": "${e.message}"}');
    }
  }

  Future<NetworkReputation> reputation({int? page, int? pageSize}) async {
    try {
      return NetworkReputation.fromJson(await _processGet(
          api('network/reputation', {"page": page, "page_size": pageSize})));
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

  Future<dynamic> mempool(
      {required String transactionType,
      int? startEpoch,
      int? stopEpoch}) async {
    // TODO: This was not working on mywitwallet. Should we add a class?
    try {
      return Mempool.fromJson(await _processGet(api('network/mempool', {
        "transaction_type": transactionType,
        "start_epoch": startEpoch,
        "stop_epoch": stopEpoch
      })));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"mempool": "${e.message}"}');
    }
  }

  Future<dynamic> address(
      {required String value,
      required String tab,
      int? page,
      int? pageSize}) async {
    try {
      switch (tab) {
        case 'blocks':
          List<Map<String, dynamic>> data = await _processGet(api(
              'address/blocks',
              {'address': value, 'page': page, 'page_size': pageSize}));
          return AddressBlocks.fromJson(data);
        // case 'details':
        //   var data = await _processGet(api('address', {'value': value}));
        //   return AddressDetails.fromJson(data);
        case 'data_requests_solved':
          var data = await _processGet(api('address/data-requests-solved',
              {'value': value, 'page': page, 'page_size': pageSize}));
          return AddressDataRequestsSolved.fromJson(
              {'address': value, 'data_requests_solved': data});
        case 'data_requests_created':
          // TODO: implement method
          //  waiting on the explorer to return valid response
          break;
        case 'value_transfers':
          var data = await _processGet(api('address/value-transfers',
              {'value': value, 'page': page, 'page_size': pageSize}));
          return AddressValueTransfers.fromJson(data);
      }
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"address": "${e.message}"}');
    }
  }

  Future<Blockchain> blockchain({int? page, int? pageSize}) async {
    try {
      return Blockchain.fromJson(await _processGet(
          api('network/blockchain', {'page': page, 'page_size': pageSize})));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"blockchain": "${e.message}"}');
    }
  }

  Future<Tapi> tapi() async {
    try {
      return Tapi.fromJson(await _processGet(api('network/tapi')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"tapi": "${e.message}"}');
    }
  }

  // TBD
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

  Future<PrioritiesEstimate> valueTransferPriority() async {
    try {
      return PrioritiesEstimate.fromJson(
          await _processGet(api('transaction/priority', {"key": "vtt"})));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"priority": "${e.message}"}');
    }
  }
}
