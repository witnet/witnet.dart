import 'dart:convert';
import 'dart:typed_data';

import 'rad_filter.dart';

import 'package:witnet/protobuf.dart' show pbField, LENGTH_DELIMITED, VARINT;
import 'package:witnet/utils.dart' show concatBytes;

class RADTally {
  RADTally({
     required this.filters,
     required this.reducer,
  });

  late List<RADFilter> filters;
  late int reducer;

  factory RADTally.fromRawJson(String str) =>
      RADTally.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RADTally.fromJson(Map<String, dynamic> json) => RADTally(
    filters: List<RADFilter>.from(json["filters"].map((x) => RADFilter.fromJson(x))),
    reducer: json["reducer"],
  );

  Map<String, dynamic> toJson() => {
    "filters": List<dynamic>.from(filters.map((x) => x)),
    "reducer": reducer,
  };
  Uint8List get pbBytes {
    var filtersBytes = (filters.length > 0) ?pbField(1, LENGTH_DELIMITED, concatBytes(List<Uint8List>.from(filters.map((e) => e.pbBytes)))) : Uint8List.fromList([]);
    var reducerBytes = pbField(2, VARINT, reducer);
    return concatBytes([filtersBytes, reducerBytes]);
  }

  int get weight {
    // reducer: 4 bytes
    var filtersWeight = 0;
    for (var filter in filters) filtersWeight += filter.weight;
    return filtersWeight + 4;
  }
}
