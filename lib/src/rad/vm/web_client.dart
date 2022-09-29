part of 'virtual_machine.dart';

class RadonWebClient {
  RadonWebClient();

  Future<String> retrieve(String url) async {
    return await _process(url);
  }

  Future<String> _process(String url) async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    }
    return '';
  }
}
