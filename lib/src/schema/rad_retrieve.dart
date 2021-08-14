import 'dart:convert' show json;
import 'dart:typed_data' show Uint8List;

import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED;
import 'package:witnet/utils.dart' show concatBytes;

class RADRetrieve {
  RADRetrieve({
    required this.kind,
    required this.script,
    required this.url,
  });

  int kind;
  List<int> script;
  String url;

  factory RADRetrieve.fromRawJson(String str) =>
      RADRetrieve.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RADRetrieve.fromJson(Map<String, dynamic> json) => RADRetrieve(
        kind: (json["kind"] == 'HTTP-GET') ? 0 : 1,
        script: List<int>.from(json["script"].map((x) => x)),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "kind": (kind == 0) ? 'HTTP-GET' : 'HTTP-POST',
        "script": List<dynamic>.from(script.map((x) => x)),
        "url": url,
      };

  Uint8List get pbBytes {
    final urlBytes = pbField(2, LENGTH_DELIMITED, Uint8List.fromList(url.codeUnits));
    final scriptBytes = pbField(3, LENGTH_DELIMITED, Uint8List.fromList(script));
    return concatBytes([urlBytes, scriptBytes]);
  }

  int get weight {
    // RADType: 1 byte
    return script.length + url.codeUnits.length + 1;
  }

}
