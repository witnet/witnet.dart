
import 'types/types.dart';
import 'vm/statistics.dart';

class Reducer{

  static op(int operator, Stats stats){
    var ops = {
      REDUCERS.min: stats.min,
      REDUCERS.max: stats.max,
      REDUCERS.mode: stats.mode,
      REDUCERS.average_mean: stats.mean,
      REDUCERS.average_mean_weighted: stats,
      REDUCERS.average_median: stats,
      REDUCERS.average_median_weighted: stats,
      REDUCERS.deviation_standard: stats,
      REDUCERS.deviation_average: stats,
      REDUCERS.deviation_median: stats,
      REDUCERS.deviation_maximum: stats,
    };
    return ops[operator];
  }

  bool _homogeneous(List<dynamic> values){
    var firstType = values[0].runtimeType;
    for(int i = 0; i < values.length; i ++){
      if(values[i].runtimeType != firstType){
        return false;
      }
    }
    return true;
  }
}