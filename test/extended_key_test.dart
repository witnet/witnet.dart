import 'package:witnet/constants.dart';
import 'package:witnet/witnet.dart';
import 'package:test/test.dart';

String mnemonic = 'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
List<List<String>> expectedAddresses = [
  ["m/3h/4919h/0h/0/0","wit174la8pevl74hczcpfepgmt036zkmjen4hu8zzs"],
  ["m/3h/4919h/0h/0/1","wit1cetlhcpqc3jxqxap6egql5py4jrgwnfzfsm6l7"],
  ["m/3h/4919h/0h/0/2","wit1667qawge388lfthfrzry8nxjqjzgcz2qkxlez9"],
  ["m/3h/4919h/0h/0/3","wit1slaeuu4qx2qjt7f4wga6pxyzhdslk92448mqy5"],
  ["m/3h/4919h/0h/0/4","wit1yzwneswsfpr2rwdzfxn9r02y37kme7cpmqpsjn"],
  ["m/3h/4919h/0h/0/5","wit1hnevye0s0zr98ly4mu2052jqrzwp60q5m2w9l8"],
  ["m/3h/4919h/0h/0/6","wit1hz6ehwn7wqcrmqvhtanapld780wd4w8347tq0h"],
  ["m/3h/4919h/0h/0/7","wit13jgcz7lm4lkmvm4hlyfxv009y6y62k8tcjm4pa"],
  ["m/3h/4919h/0h/0/8","wit1fyg823m3fwspudk4gkgtxp3cx8s2537jzmj5jm"],
  ["m/3h/4919h/0h/0/9","wit12uvsgwrnq3zvsf4eqxlchcs0ts7mqac5ushl2x"],
];

main() async {

  test('XPRV', (){
    expect(xprvTest(), true);
  });

  test('XPUB', (){
    expect(xpubTest(), true);
  });
}

bool xprvTest(){
  Xprv masterNode = Xprv.fromMnemonic(mnemonic: mnemonic);
  Xprv xprv = masterNode / KEYPATH_PURPOSE / KEYPATH_COIN_TYPE / KEYPATH_ACCOUNT;
  Xprv externalXprv = xprv / EXTERNAL_KEYCHAIN;
  for(int i = 0; i < 10; i++){
    Xprv private = externalXprv / i;
    if (expectedAddresses[i][1] != private.address.address) return false;
  }
  return true;
}

bool xpubTest(){
  Xprv masterNode = Xprv.fromMnemonic(mnemonic: mnemonic);
  Xprv xprv = masterNode / KEYPATH_PURPOSE / KEYPATH_COIN_TYPE / KEYPATH_ACCOUNT;
  Xprv externalXprv = xprv / EXTERNAL_KEYCHAIN;
  Xpub externalXpub = externalXprv.toXpub();
  for(int i = 0; i < 10; i++){
    Xpub public = externalXpub / i;
    if (expectedAddresses[i][1] != public.address) return false;
  }
  return true;
}