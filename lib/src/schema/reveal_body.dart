part of 'schema.dart';

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

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  factory RevealBody.fromJson(Map<String, dynamic> json) => RevealBody(
    drPointer: json["dr_pointer"],
    pkh: json["pkh"],
    reveal: Uint8List.fromList(List<int>.from(json["reveal"].map((x) => x))),
  );

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
    "dr_pointer": drPointer,
    "pkh": pkh,
    "reveal": (asHex)
        ? bytesToHex(Uint8List.fromList(List<int>.from(reveal.map((x) => x))))
        : List<int>.from(reveal.map((x) => x))
  };
}
/*


*/