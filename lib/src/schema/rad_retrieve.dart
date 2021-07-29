import 'dart:convert';

class RADRetrieve {
  RADRetrieve({
    required this.kind,
    required this.script,
    required this.url,
  });

  String kind;
  List<int> script;
  String url;

  factory RADRetrieve.fromRawJson(String str) => RADRetrieve.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RADRetrieve.fromJson(Map<String, dynamic> json) => RADRetrieve(
    kind: json["kind"],
    script: List<int>.from(json["script"].map((x) => x)),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "script": List<dynamic>.from(script.map((x) => x)),
    "url": url,
  };

}