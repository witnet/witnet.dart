import 'package:witnet/schema.dart' show DRTransaction;
import 'package:witnet/utils.dart' show bytesToHex;

void main() async {
  DRTransaction drTransaction = DRTransaction.fromJson(dataRequest);
  print('Transaction ID: ${bytesToHex(drTransaction.body.hash)}');
  print('Weight: ${drTransaction.body.weight}');
}

var dataRequest = {
  "body":{
    "dr_output":{
      "collateral":2500000000,
      "commit_and_reveal_fee":1,
      "data_request":{
        "aggregate":{"filters":[],"reducer":3},
        "retrieve":[
          {"kind":"HTTP-GET","script":[130,24,119,130,24,100,100,108,97,115,116], "url":"https://www.bitstamp.net/api/ticker/"},
          {"kind":"HTTP-GET","script":[132,24,119,130,24,102,99,98,112,105,130,24,102,99,85,83,68,130,24,100,106,114, 97,116,101,95,102,108,111,97,116],"url":"https://api.coindesk.com/v1/bpi/currentprice.json"}
        ],
        "tally":{"filters":[],"reducer":3},
        "time_lock":0
      },
      "min_consensus_percentage":51,
      "witness_reward":1,
      "witnesses":100
    },
    "inputs":[{"output_pointer":"0000000000000000000000000000000000000000000000000000000000000000:0"}],
    "outputs":[{"pkh":"wit174la8pevl74hczcpfepgmt036zkmjen4hu8zzs","time_lock":0,"value":1000000000}]},
  "signatures":[]};

