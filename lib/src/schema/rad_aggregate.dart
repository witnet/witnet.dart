import 'dart:convert';

class RADAggregate {
  RADAggregate({
    required this.filters,
    required this.reducer,
  });

  List<dynamic> filters;
  int reducer;

  factory RADAggregate.fromRawJson(String str) =>
      RADAggregate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RADAggregate.fromJson(Map<String, dynamic> json) => RADAggregate(
        filters: List<dynamic>.from(json["filters"].map((x) => x)),
        reducer: json["reducer"],
      );

  Map<String, dynamic> toJson() => {
        "filters": List<dynamic>.from(filters.map((x) => x)),
        "reducer": reducer,
      };
}
