part of 'radon.dart';

class Reducer{

  static op(int operator, Stats stats){
    var ops = {
      REDUCERS.min: stats.min,
      REDUCERS.max: stats.max,
      REDUCERS.mode: stats.mode,
      REDUCERS.averageMean: stats.mean,
      REDUCERS.averageMeanWeighted: stats,
      REDUCERS.averageMedian: stats,
      REDUCERS.averageMedianWeighted: stats,
      REDUCERS.deviationStandard: stats,
      REDUCERS.deviationAverage: stats,
      REDUCERS.deviationMedian: stats,
      REDUCERS.deviationMaximum: stats,
    };
    return ops[operator];
  }

  bool homogeneous(List<dynamic> values){
    var firstType = values[0].runtimeType;
    for(int i = 0; i < values.length; i ++){
      if(values[i].runtimeType != firstType){
        return false;
      }
    }
    return true;
  }
}