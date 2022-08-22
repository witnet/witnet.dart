part of 'radon.dart';

class ANY {
  static final FAIL = 0xFF;
  static final IDENTITY = 0x00;
}

class ARRAY{
  static final COUNT = 0x10;
  static final FILTER = 0x11;
  static final GET_ARRAY = 0x13;
  static final GET_BOOLEAN = 0x14;
  static final GET_BYTES = 0x15;
  static final GET_FLOAT = 0x16;
  static final GET_INTEGER = 0x17;
  static final GET_MAP = 0x18;
  static final GET_STRING = 0x19;
  static final MAP = 0x1A;
  static final REDUCE = 0x1B;
  static final SORT = 0x1D;
}

class BOOLEAN{
  static final AS_STRING = 0x20;
  static final NEGATE = 0x22;
}

class BYTES{
  static final AS_STRING = 0x30;
  static final HASH = 0x31;
}

class FLOAT{
  static final ABSOLUTE = 0x50;
  static final AS_STRING = 0x51;
  static final CEILING = 0x52;
  static final FLOOR = 0x54;
  static final GREATER_THAN = 0x53;
  static final LESS_THAN = 0x55;
  static final MODULO = 0x56;
  static final MULTIPLY = 0x57;
  static final NEGATE = 0x58;
  static final POWER = 0x59;
  static final ROUND = 0x5B;
  static final TRUNCATE = 0x5d;
}

class INTEGER{
  static final ABSOLUTE = 0x40;
  static final AS_FLOAT = 0x41;
  static final AS_STRING = 0x42;
  static final GREATER_THAN = 0x43;
  static final LESS_THAN = 0x44;
  static final MODULO = 0x46;
  static final MULTIPLY = 0x47;
  static final NEGATE = 0x48;
  static final POWER = 0x49;
}

class MAP{
  static final GET_ARRAY = 0x61;
  static final GET_BOOLEAN = 0x62;
  static final GET_BYTES = 0x63;
  static final GET_FLOAT = 0x64;
  static final GET_INTEGER = 0x65;
  static final GET_MAP = 0x66;
  static final GET_STRING = 0x67;
  static final KEYS = 0x68;
  static final VALUES_AS_ARRAY = 0x69;
}

class STRING{
  static final AS_BOOLEAN = 0x70;
  static final AS_FLOAT = 0x72;
  static final AS_INTEGER = 0x73;
  static final LENGTH = 0x74;
  static final MATCH = 0x75;
  static final PARSE_JSON_ARRAY = 0x76;
  static final PARSE_JSON_MAP = 0x77;
  static final PARSE_XML = 0x78;
  static final TO_LOWER_CASE = 0x79;
  static final TO_UPPER_CASE = 0x7A;
}

class OP {
  static final ANY_FAIL = ANY.FAIL;
  static final ANY_IDENTITY = ANY.IDENTITY;
  static final ARRAY_COUNT = ARRAY.COUNT;
  static final ARRAY_FILTER = ARRAY.FILTER;
  static final ARRAY_GET_ARRAY = ARRAY.GET_ARRAY;
  static final ARRAY_GET_BOOLEAN = ARRAY.GET_BOOLEAN;
  static final ARRAY_GET_BYTES = ARRAY.GET_BYTES;
  static final ARRAY_GET_FLOAT = ARRAY.GET_FLOAT;
  static final ARRAY_GET_INTEGER = ARRAY.GET_INTEGER;
  static final ARRAY_GET_MAP = ARRAY.GET_MAP;
  static final ARRAY_GET_STRING = ARRAY.GET_STRING;
  static final ARRAY_MAP = ARRAY.GET_ARRAY;
  static final ARRAY_REDUCE = ARRAY.REDUCE;
  static final ARRAY_SORT = ARRAY.SORT;
  static final BOOLEAN_AS_STRING = BOOLEAN.AS_STRING;
  static final BOOLEAN_NEGATE = BOOLEAN.NEGATE;
  static final BYTES_AS_STRING = BYTES.AS_STRING;
  static final BYTES_HASH = BYTES.HASH;
  static final FLOAT_ABSOLUTE = FLOAT.ABSOLUTE;
  static final FLOAT_AS_STRING = FLOAT.AS_STRING;
  static final FLOAT_CEILING = FLOAT.CEILING;
  static final FLOAT_FLOOR = FLOAT.FLOOR;
  static final FLOAT_GREATER_THAN = FLOAT.GREATER_THAN;
  static final FLOAT_LESS_THAN = FLOAT.LESS_THAN;
  static final FLOAT_MODULO = FLOAT.MODULO;
  static final FLOAT_MULTIPLY = FLOAT.MULTIPLY;
  static final FLOAT_NEGATE = FLOAT.NEGATE;
  static final FLOAT_POWER = FLOAT.POWER;
  static final FLOAT_ROUND = FLOAT.ROUND;
  static final FLOAT_TRUNCATE = FLOAT.TRUNCATE;
  static final INTEGER_ASBOLUTE = INTEGER.ABSOLUTE;
  static final INTEGER_AS_FLOAT = INTEGER.AS_FLOAT;
  static final INTEGER_AS_STRING = INTEGER.AS_STRING;
  static final INTEGER_GREATER_THAN = INTEGER.GREATER_THAN;
  static final INTEGER_LESS_THAN = INTEGER.LESS_THAN;
  static final INTEGER_MODULO = INTEGER.MODULO;
  static final INTEGER_MULTIPLY = INTEGER.MULTIPLY;
  static final INTEGER_NEGATE = INTEGER.NEGATE;
  static final INTEGER_POWER = INTEGER.POWER;
  static final MAP_GET_ARRAY = MAP.GET_ARRAY;
  static final MAP_GET_BOOLEAN = MAP.GET_BOOLEAN;
  static final MAP_GET_BYTES = MAP.GET_BYTES;
  static final MAP_GET_FLOAT = MAP.GET_FLOAT;
  static final MAP_GET_INTEGER = MAP.GET_INTEGER;
  static final MAP_GET_MAP = MAP.GET_MAP;
  static final MAP_GET_STRING = MAP.GET_STRING;
  static final MAP_KEYS = MAP.KEYS;
  static final MAP_VALUES_AS_ARRAY = MAP.VALUES_AS_ARRAY;
  static final STRING_AS_BOOLEAN = STRING.AS_BOOLEAN;
  static final STRING_AS_FLOAT = STRING.AS_FLOAT;
  static final STRING_AS_INTEGER = STRING.AS_INTEGER;
  static final STRING_LENGTH = STRING.LENGTH;
  static final STRING_MATCH = STRING.MATCH;
  static final STRING_PARSE_JSON_ARRAY = STRING.PARSE_JSON_ARRAY;
  static final STRING_PARSE_JSON_MAP = STRING.PARSE_JSON_MAP;
  static final STRING_TO_LOWER_CASE = STRING.TO_LOWER_CASE;
  static final STRING_TO_UPPER_CASE = STRING.TO_UPPER_CASE;
}
final Map<int, String> OP_STR = {
  OP.ANY_FAIL: 'Any.Fail',
  OP.ANY_IDENTITY: 'Any.Identity',
  OP.ARRAY_COUNT:'Array.count',
  OP.ARRAY_GET_ARRAY:'Array.getArray',
  OP.ARRAY_GET_BOOLEAN:'Array.getBoolean',
  OP.ARRAY_GET_BYTES:'Array.getBytes',
  OP.ARRAY_GET_INTEGER:'Array.getInteger',
  OP.ARRAY_GET_MAP:'Array.getMap',
  OP.ARRAY_GET_STRING:'Array.getString',
  OP.BOOLEAN_AS_STRING: 'Boolean.asString',
  OP.BOOLEAN_NEGATE: 'Boolean.negate',
  OP.BYTES_AS_STRING: 'Bytes.asString',
  OP.BYTES_HASH: 'Bytes.hash',
  OP.FLOAT_ABSOLUTE: 'Float.absolute',
  OP.FLOAT_AS_STRING: 'Float.asString',
  OP.FLOAT_CEILING: 'Float.ceiling',
  OP.FLOAT_FLOOR: 'Float.floor',
  OP.FLOAT_GREATER_THAN: 'Float.greaterThan',
  OP.FLOAT_LESS_THAN: 'Float.lessThan',
  OP.FLOAT_MODULO: 'Float.modulo',
  OP.FLOAT_MULTIPLY: 'Float.multiply',
  OP.FLOAT_NEGATE: 'Float.negate',
  OP.FLOAT_POWER: 'Float.power',
  OP.FLOAT_ROUND: 'Float.round',
  OP.FLOAT_TRUNCATE: 'Float.truncate',
  OP.INTEGER_ASBOLUTE: 'Integer.absolute',
  OP.INTEGER_AS_FLOAT: 'Integer.asFloat',
  OP.INTEGER_AS_STRING: 'Integer.asString',
  OP.INTEGER_GREATER_THAN: 'Integer.greaterThan',
  OP.INTEGER_LESS_THAN: 'Integer.lessThan',
  OP.INTEGER_MODULO: 'Integer.modulo',
  OP.INTEGER_MULTIPLY: 'Integer.multiply',
  OP.INTEGER_NEGATE: 'Integer.negate',
  OP.INTEGER_POWER: 'Integer.power',
  OP.MAP_GET_ARRAY: 'Map.getArray',
  OP.MAP_GET_BOOLEAN: 'Map.getBoolean',
  OP.MAP_GET_BYTES: 'Map.getBytes',
  OP.MAP_GET_FLOAT: 'Map.getFloat',
  OP.MAP_GET_INTEGER: 'Map.getInteger',
  OP.MAP_GET_MAP: 'Map.getMap',
  OP.MAP_GET_STRING: 'Map.getString',
  OP.STRING_AS_BOOLEAN: 'String.asBoolean',
  OP.STRING_AS_FLOAT: 'String.asFloat',
  OP.STRING_AS_INTEGER: 'String.asInteger',
  OP.STRING_LENGTH: 'String.length',
  OP.STRING_MATCH: 'String.match',
  OP.STRING_PARSE_JSON_ARRAY: 'String.parseJSONArray',
  OP.STRING_PARSE_JSON_MAP: 'String.parseJSONMap',
  OP.STRING_TO_LOWER_CASE: 'String.toLowerCase',
  OP.STRING_TO_UPPER_CASE: 'String.toUpperCase',
};

