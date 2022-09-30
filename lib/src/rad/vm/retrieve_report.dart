part of 'virtual_machine.dart';

class RetrieveReport {
  double time;
  List<dynamic> trace;
  List<dynamic> script;
  RetrieveReport({required this.time, required this.trace, required this.script});

  void printDebug() {
    print('  │  Number of executed operators: ${script.length}');
    print('  │  Execution time: ${time.toStringAsPrecision(3)} ms');
    print('  │  Execution trace:');
    for(int i = 0; i < trace.length; i ++){
    var _type = trace[i][0];
    var _item = trace[i][1];
    print('  │    [$i] $_type: $_item');
    }
  }

}