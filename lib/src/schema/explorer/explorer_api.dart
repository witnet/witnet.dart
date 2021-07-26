
import 'dart:convert' as convert;
import 'dart:math';

import 'package:witnet/src/schema/explorer/explorer_status.dart';

import '../node_rpc/get_utxo_info.dart';
import 'package:http/http.dart' as http;

class ExplorerAPI {

  ExplorerAPI({
    this.url,
    this.methods,
  });

  final String url;
  final List<String> methods;

  String _buildUrl(String method, Map params){
    return 'https://$url';
  }

  String api(String method){
    return 'api/$method';
  }

  Future<ExplorerStatus> status() async {
    Uri urlEndpoint = Uri.https(url, api('status'));

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(urlEndpoint);
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      return ExplorerStatus.fromJson(jsonResponse);
    }
  }

  Future<List<Utxo>> getUtxoInfo({String address}) async {
    Uri urlEndpoint = Uri.https(url, api('utxos'), {'address': address});
    print('Connecting to $url');
    int balance = 0;
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(urlEndpoint);
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      List<dynamic> utxoList = jsonResponse['utxos'];
      List<Utxo> utxos = [];
      for (int i = 0; i < utxoList.length; i++){
        Map<String, dynamic> _utxoMap = utxoList[i];
        print(_utxoMap);
        Utxo _utxo = Utxo.fromJson(_utxoMap);
        print(_utxo.value);
        utxos.add(_utxo);

        balance += _utxo.value;
      }
      return utxos;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}