part of 'types.dart';

class RadBoolean{
  bool _value;
  RadBoolean(this._value);
  final String type = TYPES.BOOLEAN;

  @override
  String toString() {
    return _value.toString();
  }

  static RadBoolean get False{
    return RadBoolean(false);
  }

  static RadBoolean get True{
    return RadBoolean(true);
  }

  RadString asString() => RadString(_value.toString());

  RadBoolean negate() => (_value == true) ? RadBoolean.True : RadBoolean.False;

  dynamic op(int op, [dynamic key]){
    Map<int, dynamic> ops = {};
    if(key != null) {
      ops.addAll({
        OP.BOOLEAN_AS_STRING: asString,
        OP.BOOLEAN_NEGATE: negate,
      });
      return ops[op](key);
    } else return ops[op];
  }
}