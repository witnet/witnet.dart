import 'dart:collection' show ListBase;
import 'dart:convert' show json;
import 'dart:collection' show MapBase;
import 'dart:math' show pow;
import 'dart:typed_data' show Uint8List;

import 'package:witnet/crypto.dart' show sha256;
import 'package:witnet/utils.dart' show bytesToHex;

import 'package:witnet/radon.dart'
    show OP, RadError, cborToRad;


part 'array.dart';
part 'boolean.dart';
part 'bytes.dart';
part 'float.dart';
part 'integer.dart';
part 'map.dart';
part 'string.dart';

class RadTypes {
  static instance(Type type,
      [dynamic arg, Map<Symbol, dynamic>? namedArguments]) {
    switch (type) {
      case RadArray:
        {
          return RadArray(arg);
        }
      case RadBoolean:
        {
          return RadBoolean(arg);
        }
      case RadBytes:
        {
          return RadBytes(arg);
        }
      case RadFloat:
        {
          return RadFloat(arg);
        }
      case RadInteger:
        {
          return RadInteger(arg);
        }
      case RadMap:
        {
          return RadMap.fromJson(arg);
        }
      case RadString:
        {
          return RadString(arg);
        }
    }
  }
}

var typesList = [
  RadArray,
  RadBoolean,
  RadInteger,
  RadFloat,
  RadString,
  RadBytes,
  RadMap,
];

var typesMap = {
  'List<dynamic>': RadArray,
  'bool': RadBoolean,
  'int': RadInteger,
  'double': RadFloat,
  'String': RadString,
  'Bytes': RadBytes,
  '_InternalLinkedHashMap<String, dynamic>': RadMap,
};

class TYPES {
  static final BOOLEAN = 'RadBoolean';
  static final INTEGER = 'RadInteger';
  static final FLOAT = 'RadFloat';
  static final STRING = 'RadString';
  static final ARRAY = 'RadArray';
  static final MAP = 'RadMap';
  static final BYTES = 'RadBytes';
  static final RESULT = 'RadonResult';
}

class PSEUDOTYPES {
  static final ANY = 'Any';
  static final INNER = 'Inner';
  static final MATCH = 'Match';
  static final SAME = 'Same';
  static final SUBSCRIPT = 'Subscript';
}

class REDUCERS {
  static final min = 0x00;
  static final max = 0x01;
  static final mode = 0x02;
  static final averageMean = 0x03;
  static final averageMeanWeighted = 0x04;
  static final averageMedian = 0x05;
  static final averageMedianWeighted = 0x06;
  static final deviationStandard = 0x07;
  static final deviationAverage = 0x08;
  static final deviationMedian = 0x09;
  static final deviationMaximum = 0x0A;
  static final hashConcatenate = 0x0B;
  static Map<int, String> map = {
    0x00: "min",
    0x01: "max",
    0x02: "mode",
    0x03: "averageMean",
    0x04: "averageMeanWeighted",
    0x05: "averageMedian",
    0x06: "averageMedianWeighted",
    0x07: "deviationStandard",
    0x08: "deviationAverage",
    0x09: "deviationMedian",
    0x0A: "deviationMaximum",
    0x0B: "hashConcatenate",
  };
}

class FILTERS {
  static final greaterThan = 0x00;
  static final lessThan = 0x01;
  static final equals = 0x02;
  static final deviationAbsolute = 0x03;
  static final deviationRelative = 0x04;
  static final deviationStandard = 0x05;
  static final top = 0x06;
  static final bottom = 0x07;
  static final lessOrEqualThan = 0x80;
  static final greaterOrEqualThan = 0x81;
  static final notEquals = 0x82;
  static final notDeviationAbsolute = 0x83;
  static final notDeviationRelative = 0x84;
  static final notDeviationStandard = 0x85;
  static final notTop = 0x86;
  static final notBottom = 0x87;
  static Map<int, String> map = {
    0x00: 'greaterThan',
    0x01: 'lessThan',
    0x02: 'equals',
    0x03: 'deviationAbsolute',
    0x04: 'deviationRelative',
    0x05: 'deviationStandard',
    0x06: 'top',
    0x07: 'bottom',
    0x80: 'lessOrEqualThan',
    0x81: 'greaterOrEqualThan',
    0x82: 'notEquals',
    0x83: 'notDeviationAbsolute',
    0x84: 'notDeviationRelative',
    0x85: 'notDeviationStandard',
    0x86: 'notTop',
    0x87: 'notBottom',
  };
}

Map<String, Map<String, List<dynamic>>> typeSystem = {
  PSEUDOTYPES.ANY: {
    'identity': [
      0x00,
      [PSEUDOTYPES.SAME]
    ],
  },
  TYPES.ARRAY: {
    'count': [
      0x10,
      [TYPES.INTEGER]
    ],
    'filter': [
      0x11,
      [PSEUDOTYPES.SAME]
    ],
    //flatten: [0x12, [PSEUDOTYPES.INNER]],
    'getArray': [
      0x13,
      [PSEUDOTYPES.INNER]
    ],
    'getBoolean': [
      0x14,
      [TYPES.BOOLEAN]
    ],
    'getBytes': [
      0x15,
      [TYPES.BYTES]
    ],
    'getFloat': [
      0x16,
      [TYPES.FLOAT]
    ],
    'getInteger': [
      0x17,
      [TYPES.INTEGER]
    ],
    'getMap': [
      0x18,
      [TYPES.MAP]
    ],
    'getString': [
      0x19,
      [TYPES.STRING]
    ],
    'map': [
      0x1A,
      [PSEUDOTYPES.SUBSCRIPT]
    ],
    'reduce': [
      0x1B,
      [PSEUDOTYPES.INNER]
    ],
    //some: [0x1C, [TYPES.BOOLEAN]],
    'sort': [
      0x1D,
      [PSEUDOTYPES.SAME]
    ],
    //take: [0x1E, [PSEUDOTYPES.SAME]],
  },
  TYPES.BOOLEAN: {
    'asString': [
      0x20,
      [TYPES.STRING]
    ],
    //match: [0x21, [PSEUDOTYPES.MATCH]],
    'negate': [
      0x22,
      [TYPES.BOOLEAN]
    ],
  },
  TYPES.BYTES: {
    'asString': [
      0x30,
      [TYPES.STRING]
    ],
    'hash': [
      0x31,
      [TYPES.BYTES]
    ],
    //'length': [0x32, [TYPES.INTEGER]]
  },
  TYPES.FLOAT: {
    'absolute': [
      0x50,
      [TYPES.FLOAT]
    ],
    'asString': [
      0x51,
      [TYPES.STRING]
    ],
    'ceiling': [
      0x52,
      [TYPES.INTEGER]
    ],
    'floor': [
      0x54,
      [TYPES.INTEGER]
    ],
    'greaterThan': [
      0x53,
      [TYPES.BOOLEAN]
    ],
    'lessThan': [
      0x55,
      [TYPES.BOOLEAN]
    ],
    'modulo': [
      0x56,
      [TYPES.FLOAT]
    ],
    'multiply': [
      0x57,
      [TYPES.FLOAT]
    ],
    'negate': [
      0x58,
      [TYPES.FLOAT]
    ],
    'power': [
      0x59,
      [TYPES.FLOAT]
    ],
    //'reciprocal': [0x5A, [TYPES.FLOAT]],
    'round': [
      0x5B,
      [TYPES.INTEGER]
    ],
    //'sum': [0x5C, [TYPES.FLOAT]],
    'truncate': [
      0x5d,
      [TYPES.INTEGER]
    ],
  },
  TYPES.INTEGER: {
    'absolute': [
      0x40,
      [TYPES.INTEGER]
    ],
    'asFloat': [
      0x41,
      [TYPES.FLOAT]
    ],
    'asString': [
      0x42,
      [TYPES.STRING]
    ],
    'greaterThan': [
      0x43,
      [TYPES.BOOLEAN]
    ],
    'lessThan': [
      0x44,
      [TYPES.BOOLEAN]
    ],
    //'match': [0x45, [PSEUDOTYPES.MATCH]],
    'modulo': [
      0x46,
      [TYPES.INTEGER]
    ],
    'multiply': [
      0x47,
      [TYPES.INTEGER]
    ],
    'negate': [
      0x48,
      [TYPES.INTEGER]
    ],
    'power': [
      0x49,
      [TYPES.INTEGER]
    ],
    //'reciprocal': [0x4A, [TYPES.FLOAT]],
    //'sum': [0x4B, [TYPES.INTEGER]]
  },
  TYPES.MAP: {
    //entries: [0x60, [PSEUDOTYPES.SAME]],
    'getArray': [
      0x61,
      [TYPES.ARRAY]
    ],
    'getBoolean': [
      0x62,
      [TYPES.BOOLEAN]
    ],
    'getBytes': [
      0x63,
      [TYPES.BYTES]
    ],
    'getFloat': [
      0x64,
      [TYPES.FLOAT]
    ],
    'getInteger': [
      0x65,
      [TYPES.INTEGER]
    ],
    'getMap': [
      0x66,
      [TYPES.MAP]
    ],
    'getString': [
      0x67,
      [TYPES.STRING]
    ],
    'keys': [
      0x68,
      [TYPES.ARRAY, TYPES.STRING]
    ],
    'valuesAsArray': [
      0x69,
      [TYPES.ARRAY, TYPES.ARRAY]
    ],
    //valuesAsBoolean: [0x6A, [TYPES.ARRAY, TYPES.BOOLEAN]],
    //valuesAsBytes: [0x6B, [TYPES.ARRAY, TYPES.BYTES]],
    //valuesAsInteger: [0x6C, [TYPES.ARRAY, TYPES.INTEGER]],
    //valuesAsFloat: [0x6D, [TYPES.ARRAY, TYPES.FLOAT]],
    //valuesAsMap: [0x6E, [TYPES.ARRAY, TYPES.MAP]],
    //valuesAsString: [0x6F, [TYPES.ARRAY, TYPES.STRING]],
  },
  TYPES.STRING: {
    'asBoolean': [
      0x70,
      [TYPES.BOOLEAN]
    ],
    //asBytes: [0x71, [TYPES.BYTES]],
    'asFloat': [
      0x72,
      [TYPES.FLOAT]
    ],
    'asInteger': [
      0x73,
      [TYPES.INTEGER]
    ],
    'length': [
      0x74,
      [TYPES.INTEGER]
    ],
    'match': [
      0x75,
      [PSEUDOTYPES.MATCH]
    ],
    'parseJSONArray': [
      0x76,
      [TYPES.ARRAY]
    ],
    'parseJSONMap': [
      0x77,
      [TYPES.MAP]
    ],
    //parseXML: [0x78, [TYPES.MAP]],
    'toLowerCase': [
      0x79,
      [TYPES.STRING]
    ],
    'toUpperCase': [
      0x7A,
      [TYPES.STRING]
    ],
  },
};
