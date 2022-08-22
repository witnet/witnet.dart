part of 'schema.dart';

class RADAggregate {
  RADAggregate({
    required this.filters,
    required this.reducer,
  });

  List<RADFilter> filters;
  int reducer;

  factory RADAggregate.fromRawJson(String str) =>
      RADAggregate.fromJson(json.decode(str));

  String toRawJson() => json.encode(jsonMap());

  factory RADAggregate.fromJson(Map<String, dynamic> json) => RADAggregate(
        filters: List<RADFilter>.from(json["filters"].map((x) => RADFilter.fromJson(x))),
        reducer: json["reducer"],
      );

  Map<String, dynamic> jsonMap({bool asHex=false}) => {
        "filters": List<dynamic>.from(filters.map((x) => x.jsonMap(asHex: asHex))),
        "reducer": reducer,
      };

  Uint8List get pbBytes {
    final filtersBytes = (filters.length > 0) ?pbField(1, LENGTH_DELIMITED, concatBytes(List<Uint8List>.from(filters.map((e) => e.pbBytes)))) : Uint8List.fromList([]);
    final reducerBytes = pbField(2, VARINT, reducer);
    return concatBytes([filtersBytes, reducerBytes]);
  }

  int get weight {
    // reducer 4 bytes
    var filtersWeight = 0;
    for (var filter in filters) filtersWeight += filter.weight;
    return filtersWeight + 4;
  }
}
