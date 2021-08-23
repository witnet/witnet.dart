import 'dart:convert';
import 'dart:typed_data';

import 'public_key_hash.dart';

import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED, VARINT;
import 'package:witnet/utils.dart' show concatBytes;

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

  String get rawJson => json.encode(jsonMap());

  Map<String, dynamic> jsonMap() => {
        "pkh": pkh.address,
        "time_lock": timeLock,
        "value": value,
      };

  Uint8List get pbBytes {
    return  concatBytes([
      pbField(1, LENGTH_DELIMITED, pkh.pbBytes),
      pbField(2, VARINT, value),
      (timeLock > 0) ? pbField(3, VARINT, timeLock) : Uint8List.fromList([])
    ]);
  }

}
