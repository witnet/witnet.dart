import 'dart:convert' show json;
import 'dart:typed_data' show Uint8List;

import 'rad_aggregate.dart' show RADAggregate;
import 'rad_retrieve.dart' show RADRetrieve;
import 'rad_tally.dart' show RADTally;

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

  String toRawJson({bool asHex=false}) => json.encode(jsonMap(asHex: asHex));

  factory RADRequest.fromJson(Map<String, dynamic> json) => RADRequest(
        aggregate: RADAggregate.fromJson(json["aggregate"]),
        retrieve: List<RADRetrieve>.from(
            json["retrieve"].map((x) => RADRetrieve.fromJson(x))),
        tally: RADTally.fromJson(json["tally"]),
        timeLock: json["time_lock"],
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
        "aggregate": aggregate.jsonMap(asHex: asHex),
        "retrieve": List<dynamic>.from(retrieve.map((x) => x.jsonMap(asHex: asHex))),
        "tally": tally.jsonMap(asHex: asHex),
        "time_lock": timeLock,
      };

  Uint8List get pbBytes {
    final timeLockBytes = (timeLock > 0) ? pbField(1, VARINT, timeLock) : Uint8List.fromList([]);
    final retrieveBytes = concatBytes(List<Uint8List>.from(retrieve.map((e) => pbField(2, LENGTH_DELIMITED,e.pbBytes))));
    final aggregateBytes = pbField(3, LENGTH_DELIMITED, aggregate.pbBytes);
    final tallyBytes = pbField(4, LENGTH_DELIMITED, tally.pbBytes);
    return concatBytes([timeLockBytes, retrieveBytes, aggregateBytes,tallyBytes]);
  }
}
