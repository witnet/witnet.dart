import 'dart:convert';
import 'dart:typed_data';

import 'rad_aggregate.dart';
import 'rad_retrieve.dart';
import 'rad_tally.dart';

import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED, VARINT;
import 'package:witnet/utils.dart' show concatBytes;

class RADRequest {
  RADRequest({
    required this.aggregate,
    required this.retrieve,
    required this.tally,
    required this.timeLock,
  });

  RADAggregate aggregate;
  List<RADRetrieve> retrieve;
  RADTally tally;
  int timeLock;

  factory RADRequest.fromRawJson(String str) =>
      RADRequest.fromJson(json.decode(str));

  get weight {
   // timeLock 8 bytes
   var retrievalsWeight = 0;
   for(var retrieval in retrieve) retrievalsWeight += retrieval.weight;
   return retrievalsWeight + aggregate.weight + tally.weight + 8;
  }

  String toRawJson() => json.encode(toJson());

  factory RADRequest.fromJson(Map<String, dynamic> json) => RADRequest(
        aggregate: RADAggregate.fromJson(json["aggregate"]),
        retrieve: List<RADRetrieve>.from(
            json["retrieve"].map((x) => RADRetrieve.fromJson(x))),
        tally: RADTally.fromJson(json["tally"]),
        timeLock: json["time_lock"],
      );

  Map<String, dynamic> toJson() => {
        "aggregate": aggregate.toJson(),
        "retrieve": List<dynamic>.from(retrieve.map((x) => x.toJson())),
        "tally": tally.toJson(),
        "time_lock": timeLock,
      };

  Uint8List get pbBytes {
    var timeLockBytes = (timeLock > 0) ? pbField(1, VARINT, timeLock) : Uint8List.fromList([]);
    var retrieveBytes = concatBytes(List<Uint8List>.from(retrieve.map((e) => pbField(2, LENGTH_DELIMITED,e.pbBytes))));
    var aggregateBytes = pbField(3, LENGTH_DELIMITED, aggregate.pbBytes);
    var tallyBytes = pbField(4, LENGTH_DELIMITED, tally.pbBytes);
    return concatBytes([timeLockBytes, retrieveBytes, aggregateBytes,tallyBytes]);
  }
}