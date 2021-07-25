Map<String, Network> networks = {
  'WitnetNode'
  'WIT': Network(
    path: 'm'
  ),

};

enum NetworkType {
  WitnetMainnet,
  WitnetTestnet,
  WitnetDevnet,

}

class Config {
  static final Map<String, Network> tmp = {};
}

class Network {
  final String path;
  final Object network;
  final int decimals;
  final String address;
  final int feeLimit;

  Network(
      {this.path, this.network, this.decimals, this.address, this.feeLimit});
}