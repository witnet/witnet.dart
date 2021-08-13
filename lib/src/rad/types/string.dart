import 'dart:convert';


import 'types.dart';
import 'array.dart';
import 'boolean.dart';
import 'float.dart';
import 'integer.dart';
import 'map.dart';

import '../exceptions.dart';
import '../op_codes.dart';

class RadString {
  String _value;
  RadString(this._value);
  final String type = TYPES.STRING;
  String toString(){
    return '$value';
  }

  String get value => _value;
  RadBoolean asBoolean() {
    if (value.toLowerCase() == 'true') {
      return RadBoolean(true);
    } else if (value.toLowerCase() == 'false') {
      return RadBoolean(false);
    } else {
      throw RadError(type, 'asBoolean', 'Unable to parse value [$value].');
    }
  }
  RadFloat asFloat() {
    if(double.tryParse(value) != null){
      return RadFloat(double.parse(value));
    } else {
      throw RadError(type, 'asFloat', 'Unable to parse Float from value [$value].');
    }
  }
  RadInteger asInteger() {
    if(int.tryParse(value) != null){
      return RadInteger(int.parse(value));
    } else {
      throw RadError(type, 'asInteger', 'Unable to parse Integer from value [$value].');
    }
  }
  RadInteger length() {
    return RadInteger(value.length);
  }
  RadBoolean match(String other){
    if (value == other){
      return RadBoolean(true);
    }
    return RadBoolean(false);
  }
  RadArray parseJSONArray() {
    try {
      var tmp = json.decode(value);
      assert (tmp.runtimeType == List,'Unable to parse JSON Array from value [$value].');
      return RadArray(tmp);
    } catch (e) {
      throw RadError(type, 'parseJSONArray', e.toString());
    }
  }
  RadMap parseJSONMap() {

    Map<String, dynamic> jsonMap = json.decode(value);
    return RadMap.fromJson(jsonMap);

  }
  RadString toLowerCase() {
    return RadString(value.toLowerCase());
  }
  RadString toUpperCase() {
    return RadString(value.toUpperCase());
  }

  dynamic op(int op, [dynamic key]){
    Map<int, dynamic> ops = {};
    if(key != null) {
      ops.addAll({
        OP.STRING_AS_BOOLEAN: asBoolean,
        OP.STRING_AS_FLOAT: asFloat,
        OP.STRING_AS_INTEGER: asInteger,
        OP.STRING_LENGTH: length,
        OP.STRING_MATCH: match,
        OP.STRING_PARSE_JSON_ARRAY: parseJSONArray,
        OP.STRING_PARSE_JSON_ARRAY: parseJSONMap,
        OP.STRING_TO_LOWER_CASE: toLowerCase,
        OP.STRING_TO_UPPER_CASE: toUpperCase,
      });
      return ops[op](key);
    } else return ops[op];
  }


}