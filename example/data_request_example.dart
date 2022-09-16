import 'package:witnet/node.dart';

import 'package:witnet/radon.dart';
import 'package:witnet/schema.dart';

import 'package:witnet/src/utils/transformations/transformations.dart';

void main() async {
  String nodeIp = '127.0.0.1';
  int nodePort = 21338;
  NodeClient nodeClient = NodeClient(address: nodeIp, port: nodePort);

  graphQlExample();
  BtcUsdExample();
}

void BtcUsdExample() {

  String BtcUsd_6 = '0a8705124e0801123268747470733a2f2f6170692e62696e616e63652e55532f6170692f76332f7472616465733f73796d626f6c3d4254435553441a168418778218646570726963658218571a000f4240185b124d0801122c68747470733a2f2f6170692e62697466696e65782e636f6d2f76312f7075627469636b65722f6274637573641a1b8418778218646a6c6173745f70726963658218571a000f4240185b12480801122d68747470733a2f2f7777772e6269747374616d702e6e65742f6170692f76322f7469636b65722f6274637573641a15841877821864646c6173748218571a000f4240185b12550801123168747470733a2f2f6170692e626974747265782e636f6d2f76332f6d61726b6574732f4254432d5553442f7469636b65721a1e8418778218646d6c6173745472616465526174658218571a000f4240185b12620801123768747470733a2f2f6170692e636f696e626173652e636f6d2f76322f65786368616e67652d72617465733f63757272656e63793d4254431a258618778218666464617461821866657261746573821864635553448218571a000f4240185b125e0801121b68747470733a2f2f6674782e636f6d2f6170692f6d61726b6574731a3d87187782186166726573756c74821182821867646e616d65831875a1674254432f555344f5f4821818008218646570726963658218571a000f4240185b12630801123268747470733a2f2f6170692e6b72616b656e2e636f6d2f302f7075626c69632f5469636b65723f706169723d4254435553441a2b87187782186666726573756c7482186668585842545a55534482186161618216008218571a000f4240185b1a0d0a0908051205fa3fc000001003220d0a0908051205fa40200000100310c0843d180a20c0843d28333080e497d012';
  DataRequestOutput test_dro = DataRequestOutput.fromBuffer(hexToBytes(BtcUsd_6));

  // Retrieve BTC/USD-6 price from Binance.US
  final binance = Witnet.Source(
      'https://api.binance.US/api/v3/trades?symbol=BTCUSD',
      parseJSONMap()
        .getFloat("price")
        .multiply(pow(10, 6))
        .round());

  // Retrieve BTC/USD-6 price from Bitfinex
  final bitfinex = Witnet.Source("https://api.bitfinex.com/v1/pubticker/btcusd",
      parseJSONMap()
        .getFloat("last_price")
        .multiply(pow(10, 6))
        .round());

// Retrieve BTC/USD-6 price from BitStamp
  final bitstamp = Witnet.Source(
      "https://www.bitstamp.net/api/v2/ticker/btcusd",
      parseJSONMap()
        .getFloat("last")
        .multiply(pow(10, 6))
        .round());

  // Retrieve BTC/USD-6 price from Bittrex
  final bittrex = Witnet.Source(
      "https://api.bittrex.com/v3/markets/BTC-USD/ticker",
      parseJSONMap()
        .getFloat("lastTradeRate")
        .multiply(pow(10, 6))
        .round());

  // Retrieve BTC/USD-6 price from Coinbase
  final coinbase = Witnet.Source(
    "https://api.coinbase.com/v2/exchange-rates?currency=BTC",
    parseJSONMap()
      .getMap("data")
      .getMap("rates")
      .getFloat("USD")
      .multiply(pow(10, 6))
      .round());

  // Retrieve BTC/USD-6 price from FTX
  final ftx = Witnet.Source(
    "https://ftx.com/api/markets",
    parseJSONMap() // Parse a `Map` from the retrieved `String`
      .getArray("result") // Access to the `Map` object at `data` key
      .filter(Witnet.Script(
        RadonMap()
          .getString("name")
          .match({"BTC/USD": true}, false)
       )
    )
      .getMap(0) // Get first (and only) element from the resulting Map
      .getFloat(
          "price") // Get the `Float` value associated to the `price` key
      .multiply(pow(10, 6)) // Use 6 digit precision
      .round()); // Cast to integer

  // Retrieve BTC/USD-6 price from Kraken
  final kraken = Witnet.Source(
    "https://api.kraken.com/0/public/Ticker?pair=BTCUSD",
    parseJSONMap()
      .getMap("result")
      .getMap("XXBTZUSD")
      .getArray("a")
      .getFloat(0)
      .multiply(pow(10, 6))
      .round());

  // Filters out any value that is more than 1.5 times the standard
  // deviationaway from the average, then computes the average mean of the
  // values that pass the filter.
  final aggregator = Witnet.Aggregator()
    .addFilter(FILTERS.deviationStandard, 1.5)
    .setReducer(REDUCERS.averageMean);

  // Filters out any value that is more than 2.5 times the standard
  // deviationaway from the average, then computes the average mean of the
  // values that pass the filter.
  final tally = Witnet.Tally()
    .addFilter(FILTERS.deviationStandard, 2.5)
    .setReducer(REDUCERS.averageMean);

  // This is the Witnet.Request object that needs to be exported
  final request = Witnet.Request()
    .addSource(binance)
    .addSource(bitfinex)
    .addSource(bitstamp)
    .addSource(bittrex)
    .addSource(coinbase)
    .addSource(ftx)
    .addSource(kraken)
    .setAggregator(aggregator)
    .setTally(tally)
    .setQuorum(10, 51)
    .setFees(pow(10, 6), pow(10, 6))
    .setCollateral(witToNanoWit(5));

  DataRequestOutput dro = request.output;

  print(bytesToHex(dro.pbBytes));

  assert(test_dro == dro);
}

void graphQlExample() {

  String VsqDai_6 = '0a890212e8010803124068747470733a2f2f6170692e74686567726170682e636f6d2f7375626772617068732f6e616d652f7375736869737761702f6d617469632d65786368616e67651a2c861877821866646461746182186664706169728218646b746f6b656e3050726963658218571a000f4240185b22527b227175657279223a227b706169722869643a5c223078313032643339626332393334373264633961633365366130613932363161383338623362633664375c22297b746f6b656e3050726963657d7d227d2a200a0c436f6e74656e742d5479706512106170706c69636174696f6e2f6a736f6e1a0d0a0908051205fa3fc000001003220d0a0908051205fa40200000100310c0843d180a20c0843d28333080e497d012';
  DataRequestOutput test_dro = DataRequestOutput.fromBuffer(hexToBytes(VsqDai_6));

  // Retrieve VSQ/DAI-6 price from the SushiSwap DEX API:
  RADRetrieve sushiSwap = Witnet.GraphQLSource(
    'https://api.thegraph.com/subgraphs/name/sushiswap/matic-exchange',
    '{ pair(id: "0x102d39bc293472dc9ac3e6a0a9261a838b3bc6d7") { token0Price }}',
    {"Content-Type": "application/json"},
    parseJSONMap()
      .getMap('data')
      .getMap('pair')
      .getFloat('token0Price')
      .multiply(pow(10, 6))
      .round());

  // Filters out any value that is more than 1.5 times the standard
  // deviationaway from the average, then computes the average mean of the
  // values that pass the filter.
  final aggregator = Witnet.Aggregator()
    .addFilter(FILTERS.deviationStandard, 1.5)
    .setReducer(REDUCERS.averageMean);

  // Filters out any value that is more than 1.5 times the standard
  // deviationaway from the average, then computes the average mean of the
  // values that pass the filter.
  final tally = Witnet.Tally()
    .addFilter(FILTERS.deviationStandard, 2.5)
    .setReducer(REDUCERS.averageMean);

  // This is the Witnet.Request object that needs to be exported
  final request = Witnet.Request()
    .addSource(sushiSwap)
    .setAggregator(aggregator) // Set the aggregator function
    .setTally(tally) // Set the tally function
    .setQuorum(10, 51) // Set witness count and minimum consensus percentage
    .setFees(pow(10, 6), pow(10, 6)) // Set economic incentives
    .setCollateral(witToNanoWit(5)); // Require 5 wits as collateral

  DataRequestOutput dro = request.output;

  assert(test_dro == dro);

}


/*

0a8705
124e0801123268747470733a2f2f6170692e62696e616e63652e55532f6170692f76332f7472616465733f73796d626f6c3d4254435553441a168418778218646570726963658218571a000f4240185b 12 4d 0801122c68747470733a2f2f6170692e62697466696e65782e636f6d2f76312f7075627469636b65722f6274637573641a1b8418778218646a6c6173745f70726963658218571a000f4240185b12480801122d68747470733a2f2f7777772e6269747374616d702e6e65742f6170692f76322f7469636b65722f6274637573641a15841877821864646c6173748218571a000f4240185b12550801123168747470733a2f2f6170692e626974747265782e636f6d2f76332f6d61726b6574732f4254432d5553442f7469636b65721a1e8418778218646d6c6173745472616465526174658218571a000f4240185b12620801123768747470733a2f2f6170692e636f696e626173652e636f6d2f76322f65786368616e67652d72617465733f63757272656e63793d4254431a258618778218666464617461821866657261746573821864635553448218571a000f4240185b125e0801121b68747470733a2f2f6674782e636f6d2f6170692f6d61726b6574731a3d87187782186166726573756c74821182821867646e616d65831875a1674254432f555344f5f4821818008218646570726963658218571a000f4240185b12630801123268747470733a2f2f6170692e6b72616b656e2e636f6d2f302f7075626c69632f5469636b65723f706169723d4254435553441a2b87187782186666726573756c7482186668585842545a55534482186161618216008218571a000f4240185b1a0d

0a0908051205fa3fc000001003220d0a0908051205fa40200000100310c0843d180a20c0843d28333080e497d012
0a9505
12500801123268747470733a2f2f6170692e62696e616e63652e55532f6170692f76332f7472616465733f73796d626f6c3d4254435553441a168418778218646570726963658218571a000f4240185b 2200 12 4f0801122c68747470733a2f2f6170692e62697466696e65782e636f6d2f76312f7075627469636b65722f6274637573641a1b8418778218646a6c6173745f70726963658218571a000f4240185b2200124a0801122d68747470733a2f2f7777772e6269747374616d702e6e65742f6170692f76322f7469636b65722f6274637573641a15841877821864646c6173748218571a000f4240185b220012570801123168747470733a2f2f6170692e626974747265782e636f6d2f76332f6d61726b6574732f4254432d5553442f7469636b65721a1e8418778218646d6c6173745472616465526174658218571a000f4240185b220012640801123768747470733a2f2f6170692e636f696e626173652e636f6d2f76322f65786368616e67652d72617465733f63757272656e63793d4254431a258618778218666464617461821866657261746573821864635553448218571a000f4240185b220012600801121b68747470733a2f2f6674782e636f6d2f6170692f6d61726b6574731a3d87187782186166726573756c74821182821867646e616d65831875a1674254432f555344f5f4821818008218646570726963658218571a000f4240185b220012650801123268747470733a2f2f6170692e6b72616b656e2e636f6d2f302f7075626c69632f5469636b65723f706169723d4254435553441a2b87187782186666726573756c7482186668585842545a55534482186161618216008218571a000f4240185b22001a0d
0a0908051205fa3fc000001003220d0a0908051205fa40200000100310c0843d180a20c0843d28333080e497d012





 */