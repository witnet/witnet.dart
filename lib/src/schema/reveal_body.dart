import 'dart:convert' show json;

import 'dart:typed_data';

class RevealBody {
  RevealBody({
    required this.drPointer,
    required this.pkh,
    required this.reveal,
  });

  final String drPointer;
  final String pkh;
  final Uint8List reveal;

  factory RevealBody.fromRawJson(String str) => RevealBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap);

  factory RevealBody.fromJson(Map<String, dynamic> json) => RevealBody(
    drPointer: json["dr_pointer"],
    pkh: json["pkh"],
    reveal: Uint8List.fromList(List<int>.from(json["reveal"].map((x) => x))),
  );

  Map<String, dynamic> get jsonMap => {
    "dr_pointer": drPointer,
    "pkh": pkh,
    "reveal": List<dynamic>.from(reveal.map((x) => x)),
  };
}
/*


*/