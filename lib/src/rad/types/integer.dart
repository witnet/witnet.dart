part of 'types.dart';

class RadInteger{
  int _value;
  final String type = TYPES.INTEGER;
  RadInteger(this._value);
  int get value => _value;
  RadInteger absolute() => RadInteger(_value.abs());
  RadFloat asFloat() => RadFloat(_value.toDouble());
  RadString asString() => RadString(_value.toString());
  RadBoolean greaterThan(RadInteger i) => (_value > i._value) ? RadBoolean(true) : RadBoolean(false);
  RadBoolean lessThan(RadInteger i) => (_value < i._value) ? RadBoolean(true) : RadBoolean(false);
  RadInteger modulo(RadInteger i) => RadInteger(_value % i._value);
  RadInteger multiply(RadInteger i) => RadInteger(_value * i._value);
  RadInteger negate(RadInteger i) => RadInteger((_value < 0) ? -_value : _value.abs());
  RadInteger power(RadInteger i) => RadInteger(pow(_value, i._value) as int);
  dynamic op(int op, [dynamic key]){
    Map<int, dynamic> ops = {};
    if(key != null) {
      ops.addAll({
        OP.INTEGER_ASBOLUTE: absolute,
        OP.INTEGER_AS_FLOAT: asFloat,
        OP.INTEGER_AS_STRING: asString,
        OP.INTEGER_GREATER_THAN: greaterThan,
        OP.INTEGER_LESS_THAN: lessThan,
        OP.INTEGER_MODULO: modulo,
        OP.INTEGER_MULTIPLY: multiply,
        OP.INTEGER_NEGATE: negate,
        OP.INTEGER_POWER: power,
      });
      return ops[op](key);
    } else return ops[op];
  }

}
