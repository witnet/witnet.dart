import 'dart:convert';

import 'rad_aggregate.dart';
import 'rad_retrieve.dart';
class DataRequest {
  DataRequest({
    required this.aggregate,
    required this.retrieve,
    required this.tally,
    required this.timeLock,
  });

  RADAggregate aggregate;
  List<RADRetrieve> retrieve;
  RADAggregate tally;
  int timeLock;

  factory DataRequest.fromRawJson(String str) => DataRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataRequest.fromJson(Map<String, dynamic> json) => DataRequest(
    aggregate: RADAggregate.fromJson(json["aggregate"]),
    retrieve: List<RADRetrieve>.from(json["retrieve"].map((x) => RADRetrieve.fromJson(x))),
    tally: RADAggregate.fromJson(json["tally"]),
    timeLock: json["time_lock"],
  );

  Map<String, dynamic> toJson() => {
    "aggregate": aggregate.toJson(),
    "retrieve": List<dynamic>.from(retrieve.map((x) => x.toJson())),
    "tally": tally.toJson(),
    "time_lock": timeLock,
  };
}