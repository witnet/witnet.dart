import 'package:witnet/constants.dart';
import 'package:witnet/witnet.dart';
import 'package:test/test.dart';

String mnemonic =
    'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
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

  test('XPRV Double', () {
    expect(xprvDoubleTest(), true);
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

bool xprvDoubleTest(){
  String xprvDouble = "xprvdouble1ae5gfvwm339antauxg9zf7ads86ex6nj00syqghdsw5fmgu4lfx0s4zs6tt2txhznq8g47tzdhwh6pq2xmq2r92qed5cyykh2wesgzhldyzusksclcf6uq54jyzcm86f3p3nu5jmqm0vdhdf7hmac9ylkgjjlhs3fc3vd7tqsn53evszlseslxrztp00lg5vxrsj2l8caskv6xrs5gw8xnnlhzw5pq0j4yd0rvgw422fz6xeteru54n0lwfprmnwu6zl2e7nktarr6dh5n22ztk305veu4eegnxvr7a96dcrgm7cdqde2gmf2jgveppp77hpzkulx4af0kz2mawcmyxe97csqsjm5h2fx9aw8anfgsn3jp40h8gjy5ap5fgddfr808k7ldspf3xvxfkw8elx9rshhlwuyk29cmnsd3sazak27dndnumdwj9hp34kh7g86kgtarzcsr5dzl9";
  String expectedInternal = "xprv1qrmya03vnt8sa4mlgnnwahv22hlx57gqvjxakyj96y9kn7exnrxhsqrzrjjkm5dd90e569azx4hvtkr9amf5ezvmq9ltkazy0um0t5pq8qm7ea7l";
  String expectedExternal = "xprv1qrzzrpdng7henalmkjl5r782r6d3hec0rfzs0a7tuchfnay84a90gqxsmjc2hfchjek9d9q45xssrqw5uyhzqrxsme89kvxnvtfsvdhdjgkv3zf6";
  var result = Xprv.fromEncryptedXprvDouble(xprvDouble, "password");
  assert(result[0].toSlip32() == expectedInternal);
  assert(result[1].toSlip32() == expectedExternal);
  return true;
}
