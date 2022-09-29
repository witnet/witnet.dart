import 'dart:convert';

class WalletException {
  WalletException({
    required this.code,
    required this.message,
  });

  final int code;
  final String message;
  @override
  String toString() => 'WalletException(code: $code, message: $message)';
}

class GetWalletInfosResponse {
  GetWalletInfosResponse({
    required this.infos,
  });

  final List<Info> infos;

  factory GetWalletInfosResponse.fromRawJson(String str) =>
      GetWalletInfosResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetWalletInfosResponse.fromJson(Map<String, dynamic> json) =>
      GetWalletInfosResponse(
        infos: List<Info>.from(json["infos"].map((x) => Info.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "infos": List<dynamic>.from(infos.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    required this.id,
    required this.name,
  });

  final String id;
  String? name;

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      id: json["id"],
      name: (json["name"] != null) ? json["name"] : 'null',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class WalletInfo {
  WalletInfo({
    required this.accountBalance,
    required this.availableAccounts,
    required this.birthDate,
    required this.currentAccount,
    required this.description,
    required this.name,
    required this.sessionExpirationSecs,
    required this.sessionId,
  });

  final AccountBalance accountBalance;
  final List<int> availableAccounts;
  final int birthDate;
  final int currentAccount;
  final dynamic description;
  final dynamic name;
  final int sessionExpirationSecs;
  final String sessionId;

  factory WalletInfo.fromRawJson(String str) =>
      WalletInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
        accountBalance: AccountBalance.fromJson(json["account_balance"]),
        availableAccounts:
            List<int>.from(json["available_accounts"].map((x) => x)),
        birthDate: json["birth_date"],
        currentAccount: json["current_account"],
        description: json["description"],
        name: json["name"],
        sessionExpirationSecs: json["session_expiration_secs"],
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "account_balance": accountBalance.toJson(),
        "available_accounts":
            List<dynamic>.from(availableAccounts.map((x) => x)),
        "birth_date": birthDate,
        "current_account": currentAccount,
        "description": description,
        "name": name,
        "session_expiration_secs": sessionExpirationSecs,
        "session_id": sessionId,
      };
}

class AccountBalance {
  AccountBalance({
    required this.confirmed,
    required this.local,
    required this.unconfirmed,
  });

  final Confirmed confirmed;
  final String local;
  final Confirmed unconfirmed;

  factory AccountBalance.fromRawJson(String str) =>
      AccountBalance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountBalance.fromJson(Map<String, dynamic> json) => AccountBalance(
        confirmed: Confirmed.fromJson(json["confirmed"]),
        local: json["local"],
        unconfirmed: Confirmed.fromJson(json["unconfirmed"]),
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed.toJson(),
        "local": local,
        "unconfirmed": unconfirmed.toJson(),
      };
}

class Confirmed {
  Confirmed({
    required this.available,
    required this.locked,
  });

  final String available;
  final String locked;

  factory Confirmed.fromRawJson(String str) =>
      Confirmed.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Confirmed.fromJson(Map<String, dynamic> json) => Confirmed(
        available: json["available"],
        locked: json["locked"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "locked": locked,
      };
}

class GetAddressesResponse {
  GetAddressesResponse({
    required this.addresses,
    required this.total,
  });

  final List<Address> addresses;
  final int total;

  factory GetAddressesResponse.fromRawJson(String str) =>
      GetAddressesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAddressesResponse.fromJson(Map<String, dynamic> json) =>
      GetAddressesResponse(
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "total": total,
      };
}

class Address {
  Address({
    required this.account,
    required this.address,
    required this.index,
    required this.info,
    required this.keychain,
    required this.path,
  });

  final int account;
  final String address;
  final int index;
  final AddressInfo info;
  final int keychain;
  final String path;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        account: json["account"],
        address: json["address"],
        index: json["index"],
        info: AddressInfo.fromJson(json["info"]),
        keychain: json["keychain"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "address": address,
        "index": index,
        "info": info.toJson(),
        "keychain": keychain,
        "path": path,
      };
}

class AddressInfo {
  AddressInfo({
    required this.firstPaymentDate,
    required this.label,
    required this.lastPaymentDate,
    required this.receivedAmount,
    required this.receivedPayments,
  });

  final dynamic firstPaymentDate;
  final dynamic label;
  final dynamic lastPaymentDate;
  final String receivedAmount;
  final List<dynamic> receivedPayments;

  factory AddressInfo.fromRawJson(String str) =>
      AddressInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        firstPaymentDate: json["first_payment_date"],
        label: json["label"],
        lastPaymentDate: json["last_payment_date"],
        receivedAmount: json["received_amount"],
        receivedPayments:
            List<dynamic>.from(json["received_payments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "first_payment_date": firstPaymentDate,
        "label": label,
        "last_payment_date": lastPaymentDate,
        "received_amount": receivedAmount,
        "received_payments": List<dynamic>.from(receivedPayments.map((x) => x)),
      };
}
