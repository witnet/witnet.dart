part of 'radon.dart';

class Filter {
  static greaterThan(num value, List<num> values){return values.where((element) => (value > element)).toList();}
  static lessThan(num value, List<num> values){return values.where((element) => (value < element)).toList();}
  static equals(num value, List<num> values){return values.where((element) => (value == element)).toList();}
  static deviationAbsolute(List<num> values){}
  static deviationRelative(List<num> values){}
  static deviationStandard(List<num> values){}
  static top(List<num> values){}
  static bottom(List<num> values){}
  static lessOrEqualThan(List<num> values){}
  static greaterOrEqualThan(List<num> values){}
  static notEquals(List<num> values){}
  static notDeviationAbsolute(List<num> values){}
  static notDeviationRelative(List<num> values){}
  static notDeviationStandard(List<num> values){}
  static notTop(List<num> values){}
  static notBottom(List<num> values){}
}