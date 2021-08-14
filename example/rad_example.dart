

import 'package:witnet/schema.dart' show
  RADAggregate,
  RADRetrieve,
  RADRequest,
  RADTally,
  RADType;

import 'package:witnet/radon.dart';


void main() async {

  Stage vm = Stage();
  // runs the radRequest locally - retrieving data from urls

  final response = await vm.runRadRequest(request, printDebug: true);
  print(response);

}

RADRequest request = RADRequest(
  timeLock: 0,
  retrieve: [
    RADRetrieve(
        kind: RADType.HttpGet,
        url: 'https://www.bitstamp.net/api/ticker/',
        script: [130, 24, 119, 130, 24, 100, 100, 108, 97, 115, 116]
    ),
    RADRetrieve(
        kind: RADType.HttpGet,
        url: 'https://api.coindesk.com/v1/bpi/currentprice.json',
        script:
        [132, 24, 119, 130, 24, 102, 99, 98, 112, 105, 130, 24, 102, 99, 85, 83,
          68, 130, 24, 100, 106, 114, 97, 116, 101, 95, 102, 108, 111, 97, 116]
    ),
  ],
  aggregate: RADAggregate(filters: [], reducer: 3),
  tally: RADTally(filters: [], reducer: 3),
);




void testEncodeScript(){
  // A CBOR Encoded RADON script
  List<int> cborScript = [132, 24, 119, 130, 24, 102, 99, 98, 112, 105, 130, 24, 102, 99, 85, 83,
    68, 130, 24, 100, 106, 114, 97, 116, 101, 95, 102, 108, 111, 97, 116];
  // A RADON script
  List<dynamic> radScript = [119, [102, 'bpi'], [102, 'USD'], [100, 'rate_float']];
  List<dynamic> radTest =
  RadonString().parseJSONMap().getMap('bpi').getMap('USD').getFloat('rate_float').encode();
  assert (cborToRad(cborScript) == radScript, 'CBOR to RADON failed.');
  assert (radToCbor(radScript) == cborScript, 'RADON to CBOR failed.');
  assert (radTest == radScript, 'Encoding to RADON failed.');
}