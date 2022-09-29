part of 'radon.dart';

List<dynamic> concat(List<dynamic> script, dynamic op) {
  List<dynamic> _script = [];
  _script.addAll(script);
  _script.add(op);
  return _script;
}

class RadType {
  List<dynamic> script = [];
  RadType(this.script);
  void initScript(List<dynamic> data) {
    script.addAll(data);
  }

  List<dynamic> encode() {
    return script;
  }
}

class RadonArray extends RadType {
  RadonArray(List script) : super(script);
  RadonInteger count() => RadonInteger(concat(script, OP.ARRAY_COUNT));
  RadonArray filter(List i) => RadonArray(concat(script, [OP.ARRAY_FILTER, i]));
  RadonArray getArray(int i) =>
      RadonArray(concat(script, [OP.ARRAY_GET_ARRAY, i]));
  RadonBoolean getBoolean(int i) =>
      RadonBoolean(concat(script, [OP.ARRAY_GET_BOOLEAN, i]));
  RadonBytes getBytes(int i) =>
      RadonBytes(concat(script, [OP.ARRAY_GET_BYTES, i]));
  RadonFloat getFloat(int i) =>
      RadonFloat(concat(script, [OP.ARRAY_GET_FLOAT, i]));
  RadonInteger getInteger(int i) =>
      RadonInteger(concat(script, [OP.ARRAY_GET_INTEGER, i]));
  RadonMap getMap(int i) => RadonMap(concat(script, [OP.ARRAY_GET_MAP, i]));
  RadonString getString(int i) =>
      RadonString(concat(script, [OP.ARRAY_GET_STRING, i]));
  RadonArray map(int i) => RadonArray(concat(script, [OP.ARRAY_MAP, i]));
  RadonArray reduce(int i) => RadonArray(concat(script, [OP.ARRAY_REDUCE, i]));
  RadonArray sort(int i) => RadonArray(concat(script, [OP.ARRAY_SORT, i]));
}

class RadonBoolean extends RadType {
  RadonBoolean(List script) : super(script);
  RadonString asString() => RadonString(concat(script, OP.BOOLEAN_AS_STRING));
  RadonBoolean negate() => RadonBoolean(concat(script, OP.BOOLEAN_NEGATE));
}

class RadonBytes extends RadType {
  RadonBytes(List script) : super(script);
  RadonString asString() => RadonString(concat(script, OP.BYTES_AS_STRING));
  RadonString hash() => RadonString(concat(script, OP.BYTES_HASH));
}

class RadonFloat extends RadType {
  RadonFloat(List script) : super(script);
  RadonFloat absolute() => RadonFloat(concat(script, OP.FLOAT_ABSOLUTE));
  RadonString asString() => RadonString(concat(script, OP.FLOAT_AS_STRING));
  RadonInteger ceiling() => RadonInteger(concat(script, OP.FLOAT_CEILING));
  RadonInteger floor() => RadonInteger(concat(script, OP.FLOAT_FLOOR));
  RadonBoolean greaterThan(double i) =>
      RadonBoolean(concat(script, [OP.FLOAT_GREATER_THAN, i]));
  RadonBoolean lessThan(double i) =>
      RadonBoolean(concat(script, [OP.FLOAT_LESS_THAN, i]));
  RadonInteger modulo(int i) =>
      RadonInteger(concat(script, [OP.FLOAT_MODULO, i]));
  RadonFloat multiply(num i) =>
      RadonFloat(concat(script, [OP.FLOAT_MULTIPLY, i]));
  RadonFloat negate() => RadonFloat(concat(script, OP.FLOAT_NEGATE));
  RadonFloat power(int i) => RadonFloat(concat(script, [OP.FLOAT_POWER, i]));
  RadonInteger round() => RadonInteger(concat(script, OP.FLOAT_ROUND));
  RadonFloat truncate(int i) =>
      RadonFloat(concat(script, [OP.FLOAT_TRUNCATE, i]));
}

class RadonInteger extends RadType {
  RadonInteger(List script) : super(script);
  RadonInteger absolute() => RadonInteger(concat(script, OP.INTEGER_ASBOLUTE));
  RadonFloat asFloat() => RadonFloat(concat(script, OP.INTEGER_AS_FLOAT));
  RadonString asString() => RadonString(concat(script, OP.INTEGER_AS_STRING));
  RadonBoolean greaterThan(int i) =>
      RadonBoolean(concat(script, [OP.INTEGER_GREATER_THAN, i]));
  RadonBoolean lessThan(int i) =>
      RadonBoolean(concat(script, [OP.INTEGER_LESS_THAN, i]));
  RadonInteger modulo(int i) =>
      RadonInteger(concat(script, [OP.INTEGER_MODULO, i]));
  RadonInteger multiply(int i) =>
      RadonInteger(concat(script, [OP.INTEGER_MULTIPLY, i]));
  RadonInteger negate() => RadonInteger(concat(script, OP.INTEGER_NEGATE));
  RadonInteger power(int i) =>
      RadonInteger(concat(script, [OP.INTEGER_POWER, i]));
}

const List emptyList = [];

class RadonMap extends RadType {
  RadonMap([List script = emptyList]) : super(script);
  RadonArray getArray(String key) =>
      RadonArray(concat(script, [OP.MAP_GET_ARRAY, key]));
  RadonBoolean getBoolean(String key) =>
      RadonBoolean(concat(script, [OP.MAP_GET_BOOLEAN, key]));
  RadonBytes getBytes(String key) =>
      RadonBytes(concat(script, [OP.MAP_GET_BYTES, key]));
  RadonFloat getFloat(String key) =>
      RadonFloat(concat(script, [OP.MAP_GET_FLOAT, key]));
  RadonInteger getInteger(String key) =>
      RadonInteger(concat(script, [OP.MAP_GET_INTEGER, key]));
  RadonMap getMap(String key) =>
      RadonMap(concat(script, [OP.MAP_GET_MAP, key]));
  RadonString getString(String key) =>
      RadonString(concat(script, [OP.MAP_GET_STRING, key]));
  RadonArray keys() => RadonArray(concat(script, OP.MAP_KEYS));
  RadonArray valuesAsArray() =>
      RadonArray(concat(script, OP.MAP_VALUES_AS_ARRAY));
}

class RadonString extends RadType {
  RadonString([List? script]) : super((script == null) ? [] : script);
  RadonBoolean asBoolean() =>
      RadonBoolean(concat(script, OP.STRING_AS_BOOLEAN));
  RadonFloat asFloat() => RadonFloat(concat(script, OP.STRING_AS_FLOAT));
  RadonInteger asInteger() =>
      RadonInteger(concat(script, OP.STRING_AS_INTEGER));
  RadonInteger length() => RadonInteger(concat(script, OP.STRING_LENGTH));
  RadonBoolean match(Map<String, dynamic> key, bool state) =>
      RadonBoolean(concat(script, [OP.STRING_MATCH, key, state]));
  RadonArray parseJSONArray() =>
      RadonArray(concat(script, OP.STRING_PARSE_JSON_ARRAY));
  RadonMap parseJSONMap() => RadonMap(concat([], OP.STRING_PARSE_JSON_MAP));
  RadonString toLowerCase() =>
      RadonString(concat(script, OP.STRING_TO_LOWER_CASE));
  RadonString toUpperCase() =>
      RadonString(concat(script, OP.STRING_TO_UPPER_CASE));
}

class Request {}

class Source extends RadType {
  final String url;
  List<dynamic> stack = [];

  Source(this.url, [List? script]) : super((script == null) ? [] : script);
  RadonArray parseJSONArray() => RadonString().parseJSONArray();
}

class Witnet {
  final String url;

  Witnet(this.url);

  static RADRetrieve Source(String url, dynamic script,
      [RADType kind = RADType.HttpGet]) {
    return RADRetrieve(
      kind: kind,
      url: bytesToString(Uint8List.fromList(toUtf8Bytes(url))),
      script: radToCbor(script.encode()),
    );
  }

  static RADRetrieve GraphQLSource(
      String url, String body, Map<String, String> headers, dynamic script,
      [RADType kind = RADType.HttpPost]) {
    String _body = _formatBody(body);
    return RADRetrieve(
        kind: kind,
        url: url,
        script: radToCbor(script.encode()),
        body: stringToBytes(_body),
        headers: List<StringPair>.from(headers.entries
            .toList()
            .map((e) => StringPair(left: e.key, right: e.value))));
  }

  static RADAggregate Aggregator() {
    return RADAggregate();
  }

  static RADTally Tally() {
    return RADTally();
  }

  static DataRequest Request() {
    return DataRequest();
  }

  static List<dynamic> Script(RadType type) => type.encode();
}

class DataRequest {
  DataRequest();
  DataRequestOutput _dro = DataRequestOutput();
  final RADRequest _request = RADRequest();

  RADRequest get request => _request;

  DataRequest addSource(RADRetrieve source) {
    var _data = _dro.jsonMap();
    _data['data_request']['retrieve'].add(source.jsonMap());
    _dro = DataRequestOutput.fromJson(_data);
    //_dro.dataRequest.retrieve.add(source);
    return this;
  }

  DataRequest setAggregator(RADAggregate aggregator) {
    _dro.dataRequest.aggregate = aggregator;
    return this;
  }

  DataRequest setTally(RADTally tally) {
    _dro.dataRequest.tally = tally;
    return this;
  }

  DataRequest setQuorum(int witnesses, int minConsensusPercentage) {
    _dro.witnesses = witnesses;
    if (minConsensusPercentage < 51 || minConsensusPercentage > 99) {
      throw RangeError('`minConsensusPercentage` needs to be > 50 and < 100');
    }
    _dro.minConsensusPercentage = minConsensusPercentage;

    return this;
  }

  DataRequest setFees(num reward, num commitAndRevealFee) {
    _dro.commitAndRevealFee = Int64(commitAndRevealFee.toInt());
    _dro.witnessReward = Int64(reward.toInt());

    return this;
  }

  DataRequest setCollateral(int collateral) {
    if (collateral >= 1000000000) {
      _dro.collateral = Int64(collateral);
    } else {
      throw RangeError('`collateral (in nanoWits)` needs to be >= 1 WIT');
    }
    return this;
  }

  DataRequest schedule(int timestamp) {
    _dro.dataRequest.timeLock = Int64(timestamp);
    return this;
  }

  DataRequest setTimestamp(int timestamp) {
    return schedule(timestamp);
  }

  DataRequestOutput get output => _dro;
}

String _formatBody(String _body) =>
    '{"query":"${_body.replaceAll('"', '\\"')}"}'.replaceAll(' ', '');

RadonMap parseJSONMap() => RadonString().parseJSONMap();
