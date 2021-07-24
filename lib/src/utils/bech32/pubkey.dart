/// A representation of a Segwit Bech32 address. This class can be used to obtain the `scriptPubKey`.
class PubKey {
  PubKey(this.hrp, this.version, this.program);

  final String hrp;
  final int version;
  final List<int> program;

  String get scriptPubKey {
    var v = version == 0 ? version : version + 0x50;
    return ([v, program.length] + program)
        .map((c) => c.toRadixString(16).padLeft(2, '0'))
        .toList()
        .join('');
  }
}