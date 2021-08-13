
class RadError implements Exception{
  String error;
  String type;
  String op;

  RadError(this.type, this.op, this.error);

  @override
  String toString() => 'RadError[$error]';

}