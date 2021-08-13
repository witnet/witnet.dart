
import 'op_codes.dart' show OP;

class Source {

}


List<dynamic> concat(List<dynamic> script, dynamic op){
  List<dynamic> _script = [];
  _script.addAll(script);
  _script.add(op);
  return _script;
}

class RadType{
  List<dynamic> script = [];
  RadType(this.script);
  void initScript(List<dynamic> data){
    script.addAll(data);
  }

  List<dynamic> encode() {
    return script;
  }
}

class RadonArray extends RadType{
  RadonArray(List script) : super(script);
  RadonInteger count() {return RadonInteger(concat(script, OP.ARRAY_COUNT));}
  RadonArray filter(int i) {return RadonArray(concat(script, [OP.ARRAY_FILTER, i]));}
  RadonArray getArray(int i) {return RadonArray(concat(script, [OP.ARRAY_GET_ARRAY, i]));}
  RadonBoolean getBoolean(int i) {return RadonBoolean(concat(script, [OP.ARRAY_GET_BOOLEAN, i]));}
  RadonBytes getBytes(int i) {return RadonBytes(concat(script, [OP.ARRAY_GET_BYTES, i]));}
  RadonFloat getFloat(int i) {return RadonFloat(concat(script, [OP.ARRAY_GET_FLOAT, i]));}
  RadonInteger getInteger(int i) {return RadonInteger(concat(script, [OP.ARRAY_GET_INTEGER, i]));}
  RadonMap getMap(int i) {return RadonMap(concat(script, [OP.ARRAY_GET_MAP, i]));}
  RadonString getString(int i) {return RadonString(concat(script, [OP.ARRAY_GET_STRING, i]));}
  RadonArray map(int i) {return RadonArray(concat(script, [OP.ARRAY_MAP, i]));}
  RadonArray reduce(int i) {return RadonArray(concat(script, [OP.ARRAY_REDUCE, i]));}
  RadonArray sort(int i) {return RadonArray(concat(script, [OP.ARRAY_SORT, i]));}
}
class RadonBoolean extends RadType{
  RadonBoolean(List script) : super(script);
  RadonString asString() {return RadonString(concat(script, OP.BOOLEAN_AS_STRING));}
  RadonBoolean negate() {return RadonBoolean(concat(script, OP.BOOLEAN_NEGATE));}
}
class RadonBytes extends RadType{
  RadonBytes(List script) : super(script);
  RadonString asString() {return RadonString(concat(script, OP.BYTES_AS_STRING));}
  RadonString hash() {return RadonString(concat(script, OP.BYTES_HASH));}
}
class RadonFloat extends RadType{
  RadonFloat(List script) : super(script);
  RadonFloat absolute() {return RadonFloat(concat(script, OP.FLOAT_ABSOLUTE));}
  RadonString asString() {return RadonString(concat(script, OP.FLOAT_AS_STRING));}
  RadonInteger ceiling() {return RadonInteger(concat(script, OP.FLOAT_CEILING));}
  RadonInteger floor() {return RadonInteger(concat(script, OP.FLOAT_FLOOR));}
  RadonBoolean greaterThan(double i) {return RadonBoolean(concat(script, [OP.FLOAT_GREATER_THAN, i]));}
  RadonBoolean lessThan(double i) {return RadonBoolean(concat(script, [OP.FLOAT_LESS_THAN, i]));}
  RadonInteger modulo(int i) {return RadonInteger(concat(script, [OP.FLOAT_MODULO, i]));}
  RadonFloat multiply(double i) {return RadonFloat(concat(script, [OP.FLOAT_MULTIPLY, i]));}
  RadonFloat negate() {return RadonFloat(concat(script, OP.FLOAT_NEGATE));}
  RadonFloat power(int i) {return RadonFloat(concat(script, [OP.FLOAT_POWER, i]));}
  RadonInteger round() {return RadonInteger(concat(script, OP.FLOAT_ROUND));}
  RadonFloat truncate(int i) {return RadonFloat(concat(script, [OP.FLOAT_TRUNCATE, i]));}
}
class RadonInteger extends RadType{
  RadonInteger(List script) : super(script);
  RadonInteger absolute() {return RadonInteger(concat(script, OP.INTEGER_ASBOLUTE));}
  RadonFloat asFloat() {return RadonFloat(concat(script, OP.INTEGER_AS_FLOAT));}
  RadonString asString() {return RadonString(concat(script, OP.INTEGER_AS_STRING));}
  RadonBoolean greaterThan(int i){return RadonBoolean(concat(script, [OP.INTEGER_GREATER_THAN, i]));}
  RadonBoolean lessThan(int i){return RadonBoolean(concat(script, [OP.INTEGER_LESS_THAN, i]));}
  RadonInteger modulo(int i){return RadonInteger(concat(script, [OP.INTEGER_MODULO, i]));}
  RadonInteger multiply(int i){return RadonInteger(concat(script, [OP.INTEGER_MULTIPLY, i]));}
  RadonInteger negate() {return RadonInteger(concat(script, OP.INTEGER_NEGATE));}
  RadonInteger power(int i){return RadonInteger(concat(script, [OP.INTEGER_POWER, i]));}
}
class RadonMap extends RadType{
  RadonMap(List script) : super(script);
  RadonArray getArray(String key){return RadonArray(concat(script, [OP.MAP_GET_ARRAY, key]));}
  RadonBoolean getBoolean(String key){return RadonBoolean(concat(script, [OP.MAP_GET_BOOLEAN, key]));}
  RadonBytes getBytes(String key){return RadonBytes(concat(script, [OP.MAP_GET_BYTES, key]));}
  RadonFloat getFloat(String key){return RadonFloat(concat(script, [OP.MAP_GET_FLOAT, key]));}
  RadonInteger getInteger(String key){return RadonInteger(concat(script, [OP.MAP_GET_INTEGER, key]));}
  RadonMap getMap(String key){return RadonMap(concat(script, [OP.MAP_GET_MAP, key]));}
  RadonString getString(String key){return RadonString(concat(script, [OP.MAP_GET_STRING, key]));}
  RadonArray keys() {return RadonArray(concat(script, OP.MAP_KEYS));}
  RadonArray valuesAsArray() {return RadonArray(concat(script, OP.MAP_VALUES_AS_ARRAY));}
}
class RadonString extends RadType{
  RadonString([List? script]) : super((script == null) ? [] : script);
  RadonBoolean asBoolean() {return RadonBoolean(concat(script, OP.STRING_AS_BOOLEAN));}
  RadonFloat asFloat() {return RadonFloat(concat(script, OP.STRING_AS_FLOAT));}
  RadonInteger asInteger() {return RadonInteger(concat(script, OP.STRING_AS_INTEGER));}
  RadonInteger length() {return RadonInteger(concat(script, OP.STRING_LENGTH));}
  RadonBoolean match(String key) {return RadonBoolean(concat(script, [OP.STRING_MATCH, key]));}
  RadonArray parseJSONArray() {return RadonArray(concat(script, OP.STRING_PARSE_JSON_ARRAY));}
  RadonMap parseJSONMap() {return RadonMap(concat([], OP.STRING_PARSE_JSON_MAP));}
  RadonString toLowerCase() {return RadonString(concat(script, OP.STRING_TO_LOWER_CASE));}
  RadonString toUpperCase() {return RadonString(concat(script, OP.STRING_TO_UPPER_CASE));}
}

