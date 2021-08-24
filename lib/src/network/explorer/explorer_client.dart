import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io' show HttpException;

import 'package:witnet/data_structures.dart' show Utxo;
import 'package:witnet/schema.dart' show VTTransaction;
import 'explorer_api.dart'
    show
        AddressBlocks,
        AddressDataRequestsSolved,
        AddressDetails,
        AddressValueTransfers,
        Blockchain,
        ExplorerError,
        ExplorerException,
        Home,
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

  Future<Map<String, dynamic>> _process(Uri uri) async {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      // response is okay
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 500) {
      throw HttpException(response.reasonPhrase!);
    }
    throw ExplorerException(code: response.statusCode, message: response.reasonPhrase!);
  }

  Future<List<Utxo>> getUtxoInfo({required String address}) async {
    Uri urlEndpoint = api('utxos', {'address': address});
    print(urlEndpoint);
    int balance = 0;
    // Await the http get response, then decode the json-formatted response.
    try {
      var response = await http.get(urlEndpoint);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        List<dynamic> utxoList = jsonResponse['utxos'];
        List<Utxo> utxos = [];
        for (int i = 0; i < utxoList.length; i++) {
          Map<String, dynamic> _utxoMap = utxoList[i];
          Utxo _utxo = Utxo.fromJson(_utxoMap);
          utxos.add(_utxo);

          balance += _utxo.value;
        }
        return utxos;
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
      return [];
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
  }

  Future<dynamic> hash(String value, bool utxos) async {
    try {
      Uri uri = api('hash', {'value': value, 'utxos': 'True'});
      var data = await _process(uri);
      return data;
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"hash": "${e.message}"}');
    }
  }

  Future<Home> home() async {
    try {
      return Home.fromJson(await _process(api('home')));
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"home": "${e.message}"}');
    }
  }

  Future<Network> network() async {
    try {
      return Network.fromJson(await _process(api('network')));
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"network": "${e.message}"}');
    }
  }

  Future<Status> status() async {
    try {
      return Status.fromJson(await _process(api('status')));
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"status": "${e.message}"}');
    }
  }

  Future<dynamic> pending() async {
    try {
      return await _process(api('pending'));
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"pending": "${e.message}"}');
    }
  }

  Future<dynamic> reputation() async {
    try {
      return await _process(api('reputation'));
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"reputation": "${e.message}"}');
    }
  }

  Future<dynamic> richList({int start = 0, int stop = 1000}) async {
    try {
      return await _process(
          api('richlist', {'start': '$start', 'stop': '$stop'}));
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"richList": "${e.message}"}');
    }
  }

  Future<dynamic> address(
      {required String value,
      required String tab,
      int limit = 0,
      epoch = 1}) async {
    try {
      var data = await _process(api('address', {'value': value, 'tab': tab}));
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
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"address": "${e.message}"}');
    }
  }

  Future<Blockchain> blockchain({int block = -100}) async {
    try {
      return Blockchain.fromJson(
          await _process(api('blockchain', {'block': '$block'})));
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"blockchain": "${e.message}"}');
    }
  }

  Future<Tapi> tapi() async {
    try {
      return Tapi.fromJson(await _process(api('tapi')));
    } on ExplorerException catch(e) {
      throw ExplorerException(code: e.code, message: '{"tapi": "${e.message}"}');
    }
  }

  Future<dynamic> send([bool test = false]) async {
    // TODO: implement send method
  }
}
