part of 'types.dart';

class RadFloat {
  double _value;
  RadFloat(this._value);
  final String type = TYPES.FLOAT;
  double get value => _value;

  @override
  String toString() {
    return 'RadFloat($_value)';
  }

  RadFloat absolute() => RadFloat(_value.abs());
  RadString asString() => RadString(_value.toString());
  RadInteger ceiling() => RadInteger(_value.ceil());
  RadInteger floor() => RadInteger(_value.floor());
  RadBoolean greaterThan(RadFloat i) {
    if (_value > i._value) {
      return RadBoolean(true);
    }
    return RadBoolean(false);
  }

  RadBoolean lessThan(RadFloat i) {
    if (_value < i._value) {
      return RadBoolean(true);
    }
    return RadBoolean(false);
  }

  RadInteger modulo(dynamic i) => RadInteger((_value % i.toInt()) as int);

  RadFloat multiply(num i) {
    return RadFloat(_value * i.toDouble());
  }

  RadFloat negate(dynamic i) => RadFloat((_value > 0) ? -_value : _value.abs());
  RadFloat power(dynamic i) => RadFloat(pow(_value, i) as double);

  RadInteger round() => RadInteger(_value.round());

  RadFloat truncate(int precision) =>
      RadFloat(double.parse((_value).toStringAsPrecision(precision)));

  dynamic op(int op, [dynamic key]) {
    Map<int, dynamic> ops = {};
    if (key != null) {
      ops.addAll({
        OP.FLOAT_ABSOLUTE: absolute,
        OP.FLOAT_AS_STRING: asString,
        OP.FLOAT_CEILING: ceiling,
        OP.FLOAT_FLOOR: floor,
        OP.FLOAT_GREATER_THAN: greaterThan,
        OP.FLOAT_LESS_THAN: lessThan,
        OP.FLOAT_MODULO: modulo,
        OP.FLOAT_MULTIPLY: multiply,
        OP.FLOAT_NEGATE: negate,
        OP.FLOAT_POWER: power,
        OP.FLOAT_ROUND: round,
        OP.FLOAT_TRUNCATE: truncate,
      });
      return ops[op](key);
    } else
      return ops[op];
  }
}
