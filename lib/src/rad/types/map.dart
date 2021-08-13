
import 'dart:collection';
import 'dart:convert';


import 'array.dart';
import 'boolean.dart';
import 'bytes.dart';
import 'float.dart';
import 'integer.dart';
import 'string.dart';
import 'types.dart' show RadTypes, typesList, typesMap, TYPES;
import '../util.dart';
import '../exceptions.dart';
import '../op_codes.dart';

class RadMap extends MapBase {
  Map _value;
  RadMap(this._value);
  final String type = TYPES.MAP;
  Map get value => _value;
  @override
  String toString(){
    return '$_value';
  }

  factory RadMap.fromJson(Map<String, dynamic> jsonMap){
    RadMap radonMap = RadMap({});
    jsonMap.forEach((key, value) {
      if(typesMap.containsKey(value.runtimeType.toString())){
        // if the value is a dart type
        Type type = typesMap[value.runtimeType.toString()]!;
        if(value.runtimeType.toString() == '_InternalLinkedHashMap<String, dynamic>'){
          radonMap[key]= RadTypes.instance(RadMap, value, {});
        } else {
          radonMap[key] = RadTypes.instance(type, value, {});
        }
      } else if (typesList.contains(value.runtimeType)){
        // if the value is a RadonType
        radonMap[key] =
            RadTypes.instance(value.runtimeType, value, {});
      }
    });
    return radonMap;
  }

  @override
  operator [](Object? key) {
    return _value[key];
  }
  @override
  void operator []=(key, value) {
    _value[key]= value;
    if(typesMap.containsKey(value.runtimeType.toString())){
      // if the value is a dart type
      Type type = typesMap[value.runtimeType.toString()]!;
      _value[key]= RadTypes.instance(type, value, {});
    } else if (typesList.contains(value.runtimeType)){
      // if the value is a RadonType
      _value[key]= value;
    }
  }

  @override
  void clear() {
    _value.clear();
  }

  @override
  Iterable get keys => _value.keys;

  @override
  remove(Object? key) {
    _value.remove(key);
  }

  RadArray getArray(String key){
    if(_value.containsKey(key)){
      var value = _value[key];
      if (value.runtimeType.toString() == 'RadArray<dynamic>'){
        return value as RadArray;
      } else {
        throw RadError('RadMap', 'getArray', 'value is not an Array.');
      }
    } else {
      throw RadError('RadMap', 'getArray', 'key $key is not in the Map.');
    }
  }
  RadBoolean getBoolean(String key){
    if(_value.containsKey(key)){
      var value = _value[key];
      if (value.runtimeType == RadBoolean){
        return value as RadBoolean;
      } else {
        throw RadError('RadMap', 'getBoolean', 'value is not an Boolean.');
      }
    } else {
      throw RadError('RadMap', 'getBoolean', 'key $key is not in the Map.');
    }
  }
  RadBytes getBytes(String key){
    if(_value.containsKey(key)){
      var value = _value[key];
      if (value.runtimeType == RadBytes){
        return value as RadBytes;
      } else {
        throw RadError('RadMap', 'getBytes', 'value is not Bytes.');
      }
    } else {
      throw RadError('RadMap', 'getBytes', 'key $key is not in the Map.');
    }
  }
  RadFloat getFloat(String key){
    if(_value.containsKey(key)){
      var value = _value[key];
      if (value.runtimeType == RadFloat){
        return value as RadFloat;
      } else{
        if(value.runtimeType == RadString) {
          return value.asFloat();
        }
        throw RadError('RadMap', 'getFloat', 'value is not RadFloat.');
      }
    } else {
      throw RadError('RadMap', 'getFloat', 'key $key is not in the Map.');
    }
  }
  RadInteger getInteger(String key){
    if(_value.containsKey(key)){
      var value = _value[key];
      if (value.runtimeType == RadInteger){
        return value as RadInteger;
      } else {
        throw RadError('RadMap', 'getInteger', 'value is not an integer.');
      }
    } else {
      throw RadError('RadMap', 'getInteger', 'key $key is not in the Map.');
    }
  }
  RadMap getMap(String key){
    if(_value.containsKey(key)){
      var value = _value[key];
      if (value.runtimeType == RadMap){
        return value as RadMap;
      } else {
        throw RadError('RadMap', 'getInteger', 'value is not a map.');
      }
    } else {
      throw RadError('RadMap', 'getInteger', 'key $key is not in the Map.');
    }
  }
  RadString getString(String key){
    if(_value.containsKey(key)){
      var value = _value[key];
      if (value.runtimeType == RadString){
        return value as RadString;
      } else {
        throw RadError('RadMap', 'getString', 'value is not String.');
      }
    } else {
      throw RadError('RadMap', 'getString', 'key $key is not in the Map.');
    }
  }


  dynamic processScript(String data,List<int> script){
    var radScript = cborToRad(script);
    var root = RadString(data).op(radScript[0]);
    print(radScript);
    print(data);
    print('Data Type: ${data.runtimeType}');

    List<dynamic> opStack = [];
    opStack.add(root);
    for (int i = 1; i < radScript.length; i ++ ){
      print(opStack[i]);
      var lastOp = opStack.last[1];
      var _op = radScript[i];
      var currentOp;
      if(_op.runtimeType == int){
        currentOp = lastOp.op(_op);
      } else {
        currentOp = lastOp.op(_op[0], _op[1]);
      }
      opStack.add([currentOp.runtimeType.toString(), currentOp]);
    }

    return {'trace': opStack, 'script': radScript};
  }

  dynamic op(int op, [dynamic key]){
    Map<int, dynamic> ops = {};
    if(key != null) {
      ops.addAll({
        OP.MAP_GET_ARRAY: getArray,
        OP.MAP_GET_BOOLEAN: getBoolean,
        OP.MAP_GET_BYTES: getBytes,
        OP.MAP_GET_FLOAT: getFloat,
        OP.MAP_GET_INTEGER: getInteger,
        OP.MAP_GET_MAP: getMap,
        OP.MAP_GET_STRING: getString,
      });
      return ops[op](key);
    } else return ops[op];
  }

}
