import 'package:test/test.dart';
import 'package:witnet/constants.dart';
import 'package:witnet/witnet.dart';

String mnemonic =
    'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';

String masterNodeXprv =
    "xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvu566tn6";

List<List<String>> expectedAddresses = [
  ["m/3h/4919h/0h/0/0", "wit174la8pevl74hczcpfepgmt036zkmjen4hu8zzs"],
  ["m/3h/4919h/0h/0/1", "wit1cetlhcpqc3jxqxap6egql5py4jrgwnfzfsm6l7"],
  ["m/3h/4919h/0h/0/2", "wit1667qawge388lfthfrzry8nxjqjzgcz2qkxlez9"],
  ["m/3h/4919h/0h/0/3", "wit1slaeuu4qx2qjt7f4wga6pxyzhdslk92448mqy5"],
  ["m/3h/4919h/0h/0/4", "wit1yzwneswsfpr2rwdzfxn9r02y37kme7cpmqpsjn"],
  ["m/3h/4919h/0h/0/5", "wit1hnevye0s0zr98ly4mu2052jqrzwp60q5m2w9l8"],
  ["m/3h/4919h/0h/0/6", "wit1hz6ehwn7wqcrmqvhtanapld780wd4w8347tq0h"],
  ["m/3h/4919h/0h/0/7", "wit13jgcz7lm4lkmvm4hlyfxv009y6y62k8tcjm4pa"],
  ["m/3h/4919h/0h/0/8", "wit1fyg823m3fwspudk4gkgtxp3cx8s2537jzmj5jm"],
  ["m/3h/4919h/0h/0/9", "wit12uvsgwrnq3zvsf4eqxlchcs0ts7mqac5ushl2x"],
];

main() async {
  test('XPRV', () {
    expect(xprvTest(), true);
  });

  test('XPUB', () {
    expect(xpubTest(), true);
  });

  test('Index Aware XPRV', () {
    expect(indexAwareXprvTest(), true);
  });

  test('Encrypted Index Aware XPRV', () {
    expect(encryptedIndexAwareXprvTest(), true);
  });
}

bool xprvTest() {
  Xprv masterNode = Xprv.fromMnemonic(mnemonic: mnemonic);
  Xprv xprv =
      masterNode / KEYPATH_PURPOSE / KEYPATH_COIN_TYPE / KEYPATH_ACCOUNT;
  Xprv externalXprv = xprv / EXTERNAL_KEYCHAIN;
  for (int i = 0; i < 10; i++) {
    Xprv private = externalXprv / i;
    if (expectedAddresses[i][1] != private.address.address) return false;
  }
  return true;
}

bool xpubTest() {
  Xprv masterNode = Xprv.fromMnemonic(mnemonic: mnemonic);
  Xprv xprv =
      masterNode / KEYPATH_PURPOSE / KEYPATH_COIN_TYPE / KEYPATH_ACCOUNT;
  Xprv externalXprv = xprv / EXTERNAL_KEYCHAIN;
  Xpub externalXpub = externalXprv.toXpub();
  for (int i = 0; i < 10; i++) {
    Xpub public = externalXpub / i;
    if (expectedAddresses[i][1] != public.address) return false;
  }
  return true;
}

bool indexAwareXprvTest() {
  Xprv xprv = Xprv.fromMnemonic(mnemonic: mnemonic);

  /// Test Zero indexes
  String xprvString =
      "xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvuqqqqqqqqqqqqqs0qn8x";
  assert(xprvString ==
      xprv.toIndexAwareSlip32(externalIndex: 0, internalIndex: 0));

  List<dynamic> indexedXprvData = Xprv.fromIndexAwareXprv(xprvString);

  Xprv indexedXprv = indexedXprvData[0];
  int externalIndex = indexedXprvData[1];
  int internalIndex = indexedXprvData[2];

  assert(masterNodeXprv == indexedXprv.toSlip32());
  assert(externalIndex == 0);
  assert(internalIndex == 0);

  /// Test other indexes
  xprvString =
      "xprv1qpujxsyd4hfu0dtwa524vac84e09mjsgnh5h9crl8wrqg58z5wmsuqqcxlqmar3fjhkprndzkpnp2xlze76g4hu7g7c4r4r2m2e6y8xlvuqqqqfvqqqqraq829yg8";
  int expectedExternalIndex = 300;
  int expectedInternalIndex = 500;
  assert(xprvString ==
      xprv.toIndexAwareSlip32(
          externalIndex: expectedExternalIndex,
          internalIndex: expectedInternalIndex));

  indexedXprvData = Xprv.fromIndexAwareXprv(xprvString);

  indexedXprv = indexedXprvData[0];
  externalIndex = indexedXprvData[1];
  internalIndex = indexedXprvData[2];

  assert(masterNodeXprv == indexedXprv.toSlip32());
  assert(externalIndex == expectedExternalIndex);
  assert(internalIndex == expectedInternalIndex);

  return true;

  /// Test Encrypted Index Aware XPRV
}

bool encryptedIndexAwareXprvTest() {
  String xprvString =
      "xprv19aer5vfuyaqt4ljlzarpymqasskdv7kwh3kmfp5m78wxjfdpgx7gvht95px38ylh7tl2xqgwezf3fujcupfkj64hzdqvwd0y3txhk7yk6xxd77dal0klxlfh854n6laxh6yvl24cqa7k9d8ljkn6x0ly223hu8l4ywpvmtdpg6mhs6mrhg05auqq2hl58c2v5y9grdzatmtarxeprka8udtlwzpnpfg8enrlt20ne8n4h5j7a4kf8wa4zvcad4wwdc7v53w6wqc286jnevm8kydtc9jfr4gt3mxsm3mqvv8zk5nzs92q38fmtv";
  List<dynamic> indexedXprvData =
      Xprv.fromIndexAwareEncryptedXprv(xprvString, "password");
  Xprv indexedXprv = indexedXprvData[0];
  int externalIndex = indexedXprvData[1];
  int internalIndex = indexedXprvData[2];

  assert(masterNodeXprv == indexedXprv.toSlip32());
  assert(externalIndex == 0);
  assert(internalIndex == 0);

  return true;
}
