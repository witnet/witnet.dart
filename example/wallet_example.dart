import 'package:witnet/src/network/wallet/wallet_api.dart';
import 'package:witnet/src/network/wallet/wallet_client.dart';

WalletClient client = WalletClient('127.0.0.1', 11212);

void main() async {
  try{
    var mnemonic = await client.createMnemonics(length: 12);
    print(mnemonic);
  } on WalletException catch(e){
    print(e.message);
  }
}
