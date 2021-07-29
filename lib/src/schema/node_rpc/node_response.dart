import 'response_error.dart';
import 'get_transaction.dart';
import 'get_utxo_info.dart';

class NodeResponse {
  NodeResponse({
    this.response,
  });

  dynamic response;

  factory NodeResponse.parse(Map<String, dynamic> json) {
    var resp;
    if (json.containsKey('error')) {
      resp = ResponseError.fromJson(json);
    } else if (json.containsKey('transaction')) {
      resp = TransactionResponse.fromJson(json);
    } else if (json.containsKey('utxos')) {
      resp = UtxoInfo.fromJson(json);
    } else {
      resp = ResponseError.fromJson(json);
    }
    return NodeResponse(response: resp);
  }
}
