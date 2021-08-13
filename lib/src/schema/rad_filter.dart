import 'dart:convert';
import 'dart:typed_data';

import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED, VARINT;
import 'package:witnet/radon.dart' show radToCbor;
import 'package:witnet/utils.dart' show concatBytes;

class RADFilter {
  late int op;
  late List<int> args;
  RADFilter({required this.op, required this.args});
  @override
  String toString() => '{"op": $op. "args": [$args]}';
  factory RADFilter.fromRawJson(String str) =>
      RADFilter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RADFilter.fromJson(Map<String, dynamic> json) => RADFilter(
    op: json['op'],
    args: List<int>.from(json["args"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "op": op,
    "args": radToCbor([args]),
  };

  Uint8List get pbBytes {
    var opBytes = pbField(1, VARINT, op);
    var argBytes =pbField(2, LENGTH_DELIMITED, Uint8List.fromList(args));
    return concatBytes([opBytes, argBytes]);
  }

  int get weight {
    // op: 4 bytes
    return args.length + 4;
  }
}
