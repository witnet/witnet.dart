import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
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

class PaginatedRequest<T> {
  int page;
  int total;
  int totalPages;
  int firstPage;
  int lastPage;
  T data;

  PaginatedRequest({
    required this.page,
    required this.total,
    required this.totalPages,
    required this.firstPage,
    required this.lastPage,
    required this.data,
  });
}

enum ExplorerMode {
  production,
  development,
}

class RetryHttpClient {
  RetryHttpClient() : retryClient = RetryClient(http.Client());

  RetryClient retryClient;

  Future<dynamic> _makeHttpRequest(
      Future<http.Response> Function(Uri uri, {dynamic body}) requestMethod,
      Uri uri,
      dynamic data,
      {bool getVersion = false}) async {
    http.Response? response;
    try {
      response = await requestMethod(uri, body: data);
    } on http.ClientException catch (e) {
      if (e.message.contains('Client is already closed')) {
        retryClient = RetryClient(http.Client());
        response = await requestMethod(uri, body: data);
      }
    }
    if (response != null) {
      if (response.statusCode ~/ 100 == 2) {
        if (getVersion) {
          return response.headers["x-version"].toString();
        }
        dynamic result = convert.jsonDecode(response.body);
        if (response.headers["x-pagination"] != null) {
          dynamic paginationHeaders =
              convert.jsonDecode(response.headers["x-pagination"] as String);

          return PaginatedRequest(
            data: result,
            firstPage: paginationHeaders["first_page"] ?? 0,
            lastPage: paginationHeaders["last_page"] ?? 0,
            page: paginationHeaders["page"] ?? 0,
            total: paginationHeaders["total"] ?? 0,
            totalPages: paginationHeaders["total_pages"] ?? 0,
          );
        } else {
          return result;
        }
      } else if (response.statusCode == 500) {
        throw HttpException(response.reasonPhrase!);
      }
      throw ExplorerException(
          code: response.statusCode, message: response.reasonPhrase!);
    }
  }

  Future<dynamic> get(Uri uri, {bool getVersion = false}) async {
    return _makeHttpRequest((Uri uri, {dynamic body}) async {
      return await retryClient.get(uri);
    }, uri, null, getVersion: getVersion);
  }

  Future<dynamic> post(Uri uri, Map<String, dynamic> postData) async {
    return _makeHttpRequest(
      (Uri uri, {dynamic body}) async {
        return await retryClient.post(uri, body: json.encode(body), headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        });
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
    Map<String, String> queryParams =
        params.map((key, value) => MapEntry(key, value.toString()));
    bool hasParams = queryParams.length > 0;
    if (SSL) {
      Uri? uriResult;
      if (hasParams) {
        uriResult = Uri.https(url, 'api/$method', queryParams);
      } else {
        uriResult = Uri.https(url, 'api/$method');
      }
      return uriResult;
    } else {
      return Uri.http(url, 'api/$method', queryParams);
    }
  }

  Future<List<Utxo>> getUtxoInfo({required String address}) async {
    Uri urlEndpoint = api('address/utxos', {'addresses': address});

    // Await the http get response, then decode the json-formatted response.
    try {
      var response = await client.get(urlEndpoint);
      List<dynamic> _utxos = response[0]['utxos'] as List<dynamic>;
      List<Utxo> utxos = [];
      _utxos.forEach((element) {
        utxos.add(Utxo.fromJson(element));
      });

      return utxos;
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
        var response = await client.get(urlCalls[i]);

        response.forEach((value) {
          List<Utxo> _utxos = List<Utxo>.from(value['utxos'].map((ut) {
            return Utxo.fromJson(ut);
          }));
          addressMap[value['address']] = _utxos;
        });
      }

      return addressMap;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> sendVTTransaction(VTTransaction transaction,
      {bool testing = true}) async {
    return await send(
        transaction:
            Transaction(valueTransfer: transaction).jsonMap(asHex: true));
  }

  Future<dynamic> hash(
      {required String value, bool simple = true, bool findAll = true}) async {
    try {
      Map<String, dynamic>? data;
      Uri uri =
          api('search/hash', {'value': value, 'simple': simple.toString()});
      final hashData = await client.get(uri);
      if (hashData != null) {
        data = (await client.get(uri) as PaginatedRequest).data;
      }
      if (data != null &&
          data['response_type'] != null &&
          data['response_type'] != 'pending') {
        switch (data['response_type'] as String) {
          case 'pending':
          case 'value_transfer':
            return ValueTransferInfo.fromJson(data['value_transfer']);
          case 'block':
            return BlockDetails.fromJson(data);
          // TODO: add support for data requests
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
      return null;
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

  Future<PaginatedRequest<NetworkBalances>> networkBalances(
      {int? page, int? pageSize}) async {
    try {
      PaginatedRequest<dynamic> result = await client
          .get(api('network/balances', {"page": page, "page_size": pageSize}));

      return PaginatedRequest(
        data: NetworkBalances.fromJson(result.data),
        firstPage: result.firstPage,
        lastPage: result.lastPage,
        page: result.page,
        total: result.total,
        totalPages: result.totalPages,
      );
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"network": "${e.message}"}');
    }
  }

  Future<NetworkReputation> reputation() async {
    try {
      dynamic result = await client.get(api('network/reputation'));
      return NetworkReputation.fromJson(result);
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

  Future<String> version() async {
    try {
      return await client.get(api('status'), getVersion: true);
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"version": "${e.message}"}');
    }
  }

  Future<dynamic> mempool(
      {required String transactionType,
      int? startEpoch,
      int? stopEpoch}) async {
    // TODO: This was not working on mywitwallet. Should we add a class?
    try {
      return Mempool.fromJson(await client.get(api('network/mempool', {
        "transaction_type": transactionType,
        "start_epoch": startEpoch,
        "stop_epoch": stopEpoch
      })));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"mempool": "${e.message}"}');
    }
  }

  Future<List<dynamic>> getAllResults(PaginatedRequest<dynamic> firstResult,
      String callName, Map<String, dynamic> params) async {
    List<dynamic> data = firstResult.data;
    // The first result is already retrieved, the next page should be the second
    for (int i = 2; i <= firstResult.totalPages; i++) {
      PaginatedRequest<dynamic> result =
          await client.get(api(callName, {...params, 'page': i}));
      data.addAll(result.data);
    }
    return data;
  }

  Future<dynamic> address(
      {required String value,
      required String tab,
      bool findAll = false,
      int page = 1,
      // Maximun page size
      int pageSize = 1000}) async {
    try {
      switch (tab) {
        case 'blocks':
          PaginatedRequest<dynamic> result = await client.get(api(
              'address/blocks',
              {'address': value, 'page': page, 'page_size': pageSize}));
          List<dynamic> data = result.data;
          if (findAll) {
            data = await getAllResults(result, 'address/blocks',
                {'address': value, 'page': page, 'page_size': pageSize});
          }
          return PaginatedRequest(
            data: data.isNotEmpty ? AddressBlocks.fromJson(data) : null,
            firstPage: result.firstPage,
            lastPage: result.lastPage,
            page: result.page,
            total: result.total,
            totalPages: result.totalPages,
          );
        // case 'details':
        //   var data = await client.get(api('address', {'address': value}));
        //   return AddressDetails.fromJson(data);
        case 'data_requests_solved':
          PaginatedRequest<dynamic> result = await client.get(api(
              'address/data-requests-solved',
              {'address': value, 'page': page, 'page_size': pageSize}));
          List<dynamic> data = result.data;
          if (findAll) {
            data = await getAllResults(result, 'address/data-requests-solved',
                {'address': value, 'page': page, 'page_size': pageSize});
          }
          return PaginatedRequest(
            data: AddressDataRequestsSolved.fromJson(
                {'address': value, 'data_requests_solved': data}),
            firstPage: result.firstPage,
            lastPage: result.lastPage,
            page: result.page,
            total: result.total,
            totalPages: result.totalPages,
          );
        case 'data_requests_created':
          // TODO: implement method
          //  waiting on the explorer to return valid response
          break;
        case 'value_transfers':
          PaginatedRequest<dynamic> result = await client.get(api(
              'address/value-transfers',
              {'address': value, 'page': page, 'page_size': pageSize}));
          List<dynamic> data = result.data;
          if (findAll) {
            data = await getAllResults(result, 'address/value-transfers',
                {'address': value, 'page': page, 'page_size': pageSize});
          }
          return PaginatedRequest(
            data: AddressValueTransfers.fromJson(
                {"value_transfers": data, "address": value}),
            firstPage: result.firstPage,
            lastPage: result.lastPage,
            page: result.page,
            total: result.total,
            totalPages: result.totalPages,
          );
      }
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"address": "${e.message}"}');
    }
  }

  Future<PaginatedRequest<Blockchain>> blockchain(
      {int? page, int? pageSize}) async {
    try {
      PaginatedRequest<dynamic> result = await client.get(
          api('network/blockchain', {'page': page, 'page_size': pageSize}));

      return PaginatedRequest(
        data: Blockchain.fromJson(result.data),
        firstPage: result.firstPage,
        lastPage: result.lastPage,
        page: result.page,
        total: result.total,
        totalPages: result.totalPages,
      );
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"blockchain": "${e.message}"}');
    }
  }

  Future<Tapi> tapi() async {
    try {
      return Tapi.fromJson(await client.get(api('network/tapi')));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"tapi": "${e.message}"}');
    }
  }

  Future<dynamic> send(
      {required Map<String, dynamic> transaction, bool test = false}) async {
    try {
      var response = await client.post(api('transaction/send'), transaction);
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
          await client.get(api('transaction/priority', {"key": "vtt"})));
    } on ExplorerException catch (e) {
      throw ExplorerException(
          code: e.code, message: '{"priority": "${e.message}"}');
    }
  }
}
