



class CoinInfo {
  final String path;
  final Object network; //NetworkType or int
  final int decimals;
  final String address;
  final int gasLimit;

  CoinInfo(this.path, this.network, this.decimals, {this.address, this.gasLimit});
}