part of 'virtual_machine.dart';

class Stage {
  Stage();
  Map<String, String> requestCache = {};
  Map<String, dynamic> scriptCache = {};

  Future<Map<String, dynamic>> runRadRequest(RADRequest radRequest,
      {bool printDebug = false}) async {
    int boxWidth = 37;
    if (printDebug) {
      print('╔════════════════════════════════════════════╗');
      print('║ Witnet data request local execution report ║');
      print('╚═╤══════════════════════════════════════════╝');
      print('  │');
    }

    List<RetrieveReport> reports = [];
    // retrieve
    Stopwatch stopwatch = new Stopwatch()..start();
    await retrievalStage(radRequest, reports);
    var timeElapsed =
        (stopwatch.elapsedMicroseconds * 0.001).toStringAsPrecision(3);

    if (printDebug) {
      print('╔════════════════════════════════════════════╗');
      print('║ Witnet data request local execution report ║');
      print('╚═╤══════════════════════════════════════════╝');
      print('  │');
      print('  │  ┌──────────────────────────────────────┐');
      print('  ├──┤ ${padStr('Retrieval Stage', ' ', boxWidth)}│');
      print('  │  ├──────────────────────────────────────┤');
      print(
          '  │  │ ${padStr('Number of retrieved data sources: ${reports.length}', ' ', boxWidth)}│');
      print('  │  └──────────────────────────────────────┘');
      print('  │ ');
      for (int i = 0; i < reports.length; i++) {
        print('  │  [ Source #$i ]');
        var report = reports[i];
        report.printDebug();
      }
    }

    stopwatch = new Stopwatch()..start();
    RADAggregate aggregate = radRequest.aggregate;
    stopwatch = new Stopwatch()..start();

    var ag = aggregateStage(reports, aggregate);
    timeElapsed =
        (stopwatch.elapsedMicroseconds * 0.001).toStringAsPrecision(3);
    if (printDebug) {
      print('  │  ┌──────────────────────────────────────┐');
      print('  ├──┤ ${padStr('Aggregation Stage', ' ', boxWidth)}│');
      print('  │  ├──────────────────────────────────────┤');
      print(
          '  │  │ ${padStr('Execution time: $timeElapsed ms', ' ', boxWidth)}│');
      print(
          '  │  │ ${padStr('Result is ${typeConversion(ag)}: $ag', ' ', boxWidth)}│');
      print('  │  └──────────────────────────────────────┘');
      print('  │');
      stopwatch = new Stopwatch()..start();
      print('  │  ┌──────────────────────────────────────┐');
      print('  └──┤ ${padStr('Tally Stage', ' ', boxWidth)}│');
      print('     ├──────────────────────────────────────┤');
      print(
          '     │ ${padStr('Execution time: ${(stopwatch.elapsedMicroseconds * 0.001).toStringAsPrecision(3)} ms', ' ', boxWidth)}│');
      print(
          '     │ ${padStr('Result is ${typeConversion(ag)}: $ag', ' ', boxWidth)}│');
      print('     └──────────────────────────────────────┘');
    }
    return {'retrieval': reports, 'aggregate': ag, 'tally': ag};
  }

  Future<void> retrievalStage(
      RADRequest radRequest, List<RetrieveReport> reports) async {
    // Retrieve the sources

    for (int i = 0; i < radRequest.retrieve.length; i++) {
      Stopwatch stopwatch = new Stopwatch()..start();

      var retrieve = radRequest.retrieve[i];
      var result = '';
      if (requestCache.containsKey(retrieve.url)) {
        result = requestCache[retrieve.url]!;
      } else {
        var webClient = RadonWebClient();
        result = await webClient.retrieve(retrieve.url);
        requestCache[retrieve.url] = result;
      }

      var resp = processScript(result, retrieve.script.toList());
      var trace = resp['trace'];
      var script = resp['script'];

      // Store the result
      reports.add(RetrieveReport(
          time: (stopwatch.elapsedMicroseconds * 0.001),
          trace: trace,
          script: script));
    }
  }

  dynamic aggregateStage(List<RetrieveReport> reports, RADAggregate aggregate) {
    List<num> values = [];
    for (int i = 0; i < reports.length; i++) {
      RetrieveReport report = reports[i];

      if (report.trace.last[1] == null) {
        report.trace.removeLast();
      }

      values.add(report.trace.last[1].value);
    }
    Stats stats = Stats.fromData(values);

    return Reducer.op(aggregate.reducer, stats);
  }

  dynamic tallyStage() {}

  dynamic processScript(String data, List<int> script) {
    List<dynamic> radScript = cborToRad(script);
    RadString root = RadString(data);
    List<dynamic> opStack = [];
    opStack.add([root.runtimeType.toString(), root]);
    if (radScript[0] == OP.STRING_PARSE_JSON_MAP) {
      opStack.add(['RadonMap', RadMap.fromJson(json.decode(data))]);
    }
    for (int i = 1; i < radScript.length; i++) {
      var lastOp = opStack.last[1];
      var _op = radScript[i];
      var currentOp;
      if (_op.runtimeType == int) {
        currentOp = lastOp.op(_op);
      } else {
        currentOp = lastOp.op(_op[0], _op[1]);
      }
      opStack.add([currentOp.runtimeType.toString(), currentOp]);
    }

    return {'trace': opStack, 'script': radScript};
  }
}

String padStr(String data, String char, int length) {
  var paddedStr = data;
  for (int i = 0; i < length - data.length; i++) {
    paddedStr += char;
  }
  return paddedStr;
}

List<dynamic> rawValues(List<dynamic> values) {
  List<dynamic> results = [];
  for (int i = 0; i < values.length; i++) {
    results.add(values[i].value);
  }
  return results;
}

String typeConversion(dynamic val) {
  switch (val.runtimeType) {
    case double:
      {
        return 'Float';
      }
    case int:
      {
        return 'Integer';
      }
    case List:
      {
        return 'List';
      }
  }
  return '';
}
