import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io' show HttpException;


import 'explorer_status.dart' show ExplorerStatus;
import '../node_rpc/get_utxo_info.dart' show Utxo;

class ExplorerAPI {
  ExplorerAPI({
    required this.url,
    required this.methods,
  });

  final String url;
  final List<String> methods;

  String _buildUrl(String method, Map params) {
    return 'https://$url';
  }

  String api(String method) {
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
    } else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }

  Future<List<Utxo>> getUtxoInfo({required String address}) async {
    Uri urlEndpoint = Uri.https(url, api('utxos'), {'address': address});
    int balance = 0;
    // Await the http get response, then decode the json-formatted response.
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
  }

  Future<Map<String, dynamic>> _process(Uri url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;

    }
    return {};
  }
}
