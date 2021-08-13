import 'dart:math' as math;

class Stats<T extends num>{

  int count;
  T min;
  T max;
  List<num> data;
  num sum;
  num mean;
  num median;
  dynamic mode;
  num get standardError =>  deviationStandard / math.sqrt(count);
  num get deviationAbsolute {
    // The average of the
    num sumOfAbsDiffFromMean = 0;
    for (var value in data){
      sumOfAbsDiffFromMean += (value - mean).abs();
    }
    final variance = sumOfAbsDiffFromMean / count;
    return variance;
  }
  num get deviationRelative => (100 * deviationStandard) / count;
  num get deviationStandard {
    // variance
    // The average of the squared difference from the Mean
    num sumOfSquaredDiffFromMean = 0;
    for (var value in data) {
      final squareDiffFromMean = math.pow(value - mean, 2);
      sumOfSquaredDiffFromMean += squareDiffFromMean;
    }
    final variance = sumOfSquaredDiffFromMean / count;

    // standardDeviation: sqrt of the variance
    return math.sqrt(variance);
  }

  Stats(this.count, this.max, this.min, this.sum, this.mean, this.median, this.mode, this.data);

  factory Stats.fromData(Iterable<T> source) {
    final list = source.toList()..sort();

    if(list.isEmpty) {
      throw ArgumentError.value(list, 'list', 'Cannot be empty.');
    }
    var map = Map();
    list.forEach((element) {
      if(!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] +=1;
      }
    });
    var highestCount = 0;
    for(var key in map.keys){

      var val = map[key];
      if (val > highestCount) highestCount = val;
    }
    List<dynamic> mode = [];
    for(var key in map.keys){

      var val = map[key];
      if (val == highestCount) mode.add(key);
    }
    final count = list.length;
    final max = list.last;
    final min = list.first;

    num sum = 0;

    for(var value in list){
      sum += value;
    }
    final mean = sum / count;

    // variance
    // The average of the squared difference from the Mean
    num sumOfSquaredDiffFromMean = 0;
    for (var value in list) {
      final squareDiffFromMean = math.pow(value - mean, 2);
      sumOfSquaredDiffFromMean += squareDiffFromMean;
    }
    final variance = sumOfSquaredDiffFromMean / count;

    // standardDeviation: sqrt of the variance
    final standardDeviation = math.sqrt(variance);

    final middleIndex = count ~/ 2;
    num median = list[middleIndex];
    // if length is even, average the "middle" values
    if (count.isEven) {
      median = (list[middleIndex - 1] + median) / 2.0;
    }
    if(count == 0){
      throw ArgumentError.value(source, 'source', 'Cannot be empty.');
    }


    return Stats(count, max, min,sum, mean, median, mode, list);

  }

  void printDebug(){
    print('Statistics:');
    print('  Data: $data');
    print('  Count: $count');
    print('  Min: $min');
    print('  Max: $max');
    print('  Mean: $mean');
    print('  Median: $median');
    print('  Mode: $mode');
    print('  Standard Devation: $deviationStandard');

  }
}