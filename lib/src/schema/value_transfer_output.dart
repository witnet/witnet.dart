import 'dart:convert';

import 'dart:typed_data';

import '../utils/protobuf/serializer.dart';
import '../utils/transformations/transformations.dart';
import 'public_key_hash.dart';

class ValueTransferOutput {
  ValueTransferOutput({
    required this.pkh,
    required this.timeLock,
    required this.value,
  });

  PublicKeyHash pkh;
  int value;
  int timeLock;

  factory ValueTransferOutput.fromRawJson(String str) =>
      ValueTransferOutput.fromJson(json.decode(str));

  factory ValueTransferOutput.fromJson(Map<String, dynamic> json) =>
      ValueTransferOutput(
        pkh: PublicKeyHash.fromAddress(json["pkh"]),
        timeLock: json["time_lock"],
        value: json["value"],
      );

  String get rawJson => json.encode(jsonMap);

  Map<String, dynamic> get jsonMap => {
        "pkh": pkh.address,
        "time_lock": timeLock,
        "value": value,
      };

  Uint8List get pbBytes {
    List<int> _timeLock = [];
    if (timeLock > 0) {
      _timeLock =
          concatBytes([varInt(BigInt.from(24)), varInt(BigInt.from(timeLock))])
              .toList();
    }
    var content = concatBytes([
      pkh.pbBytes,
      indexHeader,
      varInt(BigInt.from(value)),
      Uint8List.fromList(_timeLock)
    ]);
    return concatBytes([outputHeader, bytesSerializer(content)]);
  }
}
