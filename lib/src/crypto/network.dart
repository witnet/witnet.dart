Map<String, Network> networks = {
  'WIT': Network(
      path: '',
      address: 'wit',
      feeLimit: 0,
      decimals: 9,
      network: NetworkType.WitnetMainnet),
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
      {required this.path,
      required this.network,
      required this.decimals,
      required this.address,
      required this.feeLimit});
}
