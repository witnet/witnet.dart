part of 'types.dart';

class RadArray<E> extends ListBase<E>{
  final List<E> _value;
  RadArray(this._value);
  int get length => _value.length;
  final String type = TYPES.ARRAY;
  @override
  String toString(){
    return '$_value';
  }

  @override
  operator [](int index) => _value[index];

  @override
  void operator []=(int index, value) {
    Type type;
    if(typesMap.containsKey(value.runtimeType)){
      type = typesMap[value.runtimeType]!;
      _value[index]= RadTypes.instance(type, value, {});
    } else if (typesList.contains(value.runtimeType)){
      type = value.runtimeType;
    } else {
      type = RadError;
      throw RadError('RadArray', '[]=', '${value.runtimeType} is not a valid type');
    }
    _value[index]= RadTypes.instance(type, value, {});
  }

  @override
  set length(int newLength) {
    _value.length = newLength;
  }

  RadInteger count() => RadInteger(_value.length);
  RadArray getArray(int index){
    if([index].runtimeType.toString() == 'RadArray<dynamic>'){
    return _value[index] as RadArray;
    } else {
      throw RadError('RadArray', 'getArray', 'unable to parse $_value as RadArray.');
    }
  }

  RadBoolean getBoolean(int index){
    if([index].runtimeType.toString() == 'RadBoolean'){
      return _value[index] as RadBoolean;
    } else {
      throw RadError('RadArray', 'getBoolean', 'unable to parse $_value as RadBoolean.');
    }
  }

  RadBytes getBytes(int index){
    if([index].runtimeType.toString() == 'RadBytes'){
      return _value[index] as RadBytes;
    } else {
      throw RadError('RadArray', 'getBytes', 'unable to parse $_value as RadBytes.');
    }
  }

  RadInteger getInteger(int index){
    if(_value[index].runtimeType.toString() == 'RadBytes'){
      return _value[index] as RadInteger;
    } else {
      throw RadError('RadArray', 'getInteger', 'unable to parse $_value as RadInteger.');
    }
  }

  RadMap getMap(int index){
    if(_value[index].runtimeType.toString() == 'RadMap'){
      return _value[index] as RadMap;
    } else {
      try {
        return RadMap.fromJson(_value[index] as Map<String, dynamic>);
      } catch(e){
        throw RadError('RadArray', 'getMap', 'unable to parse $_value as RadMap.');
      }
    }
  }

  RadString getString(int index){
    if(_value[index].runtimeType.toString() == 'RadString'){
      return _value[index] as RadString;
    } else {
      throw RadError('RadArray', 'getString', 'unable to parse $_value as RadString.');
    }
  }

  dynamic op(int op, [dynamic key]){
    Map<int, dynamic> ops = {};
    if(key != null) {
      ops.addAll({
        OP.ARRAY_COUNT: count,
        OP.ARRAY_GET_ARRAY: getArray,
        OP.ARRAY_GET_BOOLEAN: getBoolean,
        OP.ARRAY_GET_BYTES: getBytes,
        OP.ARRAY_GET_INTEGER: getInteger,
        OP.ARRAY_GET_MAP: getMap,
        OP.ARRAY_GET_STRING: getString,
      });
      return ops[op](key);
    } else return ops[op];
  }
}