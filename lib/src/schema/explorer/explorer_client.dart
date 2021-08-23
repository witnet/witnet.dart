import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io' show HttpException;

import 'package:witnet/data_structures.dart' show Utxo;
import 'package:witnet/schema.dart' show VTTransaction;
import 'package:witnet/src/schema/explorer/explorer_api.dart' show
  Home,
  Network,
  Status,
  AddressBlocks,
  AddressDetails,
  AddressDataRequestsSolved,
  AddressValueTransfers;

enum ExplorerMode {
  production,
  development,
}

class ExplorerClient {
  ExplorerClient(  {
    required this.url,
    required this.mode,
  }): SSL = (mode == ExplorerMode.production) ? true : false;


  final String url;
  final ExplorerMode mode;
  late bool SSL;

  Uri api(String method, [Map<String, dynamic> params = const {}]) {
    if(SSL){
      return Uri.https(url, 'api/$method', params);
    } else {
      return Uri.http(url, 'api/$method', params);
    }
  }

  Future<List<Utxo>> getUtxoInfo({required String address}) async {
    Uri urlEndpoint = api('utxos', {'address': address});
    print(urlEndpoint);
    int balance = 0;
    // Await the http get response, then decode the json-formatted response.
    try{
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
    } catch (e){
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> _process(Uri uri) async {
    var response = await http.get(uri);
    print(uri.toString());
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }
    return {'error':'null'};
  }

  Future<dynamic> sendVTTransaction(VTTransaction transaction, {bool testing=true}) async {
    Uri uri = Uri.dataFromString('content');
    http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: transaction.jsonMap,
      encoding: convert.utf8,
    );
  }

  Future<dynamic> hash(String value, bool utxos) async{
    Uri uri = api('hash', {'value': value, 'utxos': 'True'});
    var data = await _process(uri);
    return data;
  }

  Future<dynamic> home() async{

    return Home.fromJson(await _process(api('home')));
  }

  Future<dynamic> network() async{
    return Network.fromJson(await _process(api('network')));
  }

  Future<dynamic> status() async{
    return Status.fromJson(await _process(api('status')));
  }

  Future<dynamic> pending() async{
    return await _process(api('pending'));
  }

  Future<dynamic> reputation() async{
    return await _process(api('reputation'));;
  }

  Future<dynamic> richList({int start=0, int stop=1000}) async{
    return await _process(api('richlist', {'start': '$start', 'stop': '$stop'}));
  }

  Future<dynamic> address({ required String value, required String tab,  int limit=0, epoch=1}) async{
    var data = await _process(api('address', {'value': value, 'tab': tab}));
    switch (tab){
      case 'blocks': return AddressBlocks.fromJson(data);
      case 'details': return AddressDetails.fromJson(data);
      case 'data_requests_solved': return AddressDataRequestsSolved.fromJson(data);
      case 'data_requests_launched': break;
      case 'value_transfers': return AddressValueTransfers.fromJson(data);
    }
    return data;
  }

  Future<dynamic> blockchain({int block = -100}) async {
    return await _process(api('blockchain', {'block': '$block'}));
  }

  Future<dynamic> tapi([String action='init']) async {
    return await _process(api('tapi'));
  }

  Future<dynamic> send([bool test=false]) async {
    // TODO: implement send method
  }
}




