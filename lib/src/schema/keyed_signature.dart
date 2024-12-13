part of 'schema.dart';

class KeyedSignature extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('KeyedSignature',
      package: const PackageName('witnet'), createEmptyInstance: create)
    ..aOM<Signature>(1, 'signature', subBuilder: Signature.create)
    ..aOM<PublicKey>(2, 'publicKey', subBuilder: PublicKey.create)
    ..hasRequiredFields = false;

  static KeyedSignature create() => KeyedSignature._();
  static PbList<KeyedSignature> createRepeated() => PbList<KeyedSignature>();

  KeyedSignature._() : super();

  @override
  KeyedSignature clone() => KeyedSignature()..mergeFromMessage(this);

  @override
  KeyedSignature createEmptyInstance() => create();

  factory KeyedSignature({
    Signature? signature,
    PublicKey? publicKey,
  }) {
    final _result = create();
    if (signature != null) {
      _result.signature = signature;
    }
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    return _result;
  }

  @override
  factory KeyedSignature.fromBuffer(List<int> i,
          [ExtensionRegistry r = ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory KeyedSignature.fromRawJson(String str) =>
      KeyedSignature.fromJson(json.decode(str));

  @override
  factory KeyedSignature.fromJson(Map<String, dynamic> json) => KeyedSignature(
        publicKey: PublicKey.fromJson(json["public_key"]),
        signature: Signature.fromJson(json["signature"]),
      );

  factory KeyedSignature.fromAuthorization(
      {required String authorization, required String withdrawer}) {
    PublicKeyHash pkh = PublicKeyHash.fromAddress(withdrawer);
    Uint8List authBytes = hexToBytes(authorization);
    int recoveryId = authBytes[0];
    BigInt r = bytesToBigInt(authBytes.sublist(1, 33));
    BigInt s = bytesToBigInt(authBytes.sublist(33, 65));

    WitSignature signature = WitSignature(r, s);
    WitPublicKey validatorKey = WitPublicKey.recover(
      signature,
      Uint8List(32)..setRange(0, 20, pkh.hash),
      recoveryId,
    );

    return KeyedSignature(
      publicKey: PublicKey(bytes: validatorKey.encode()),
      signature:
          Signature(secp256k1: Secp256k1Signature(der: signature.encode())),
    );
  }

  String toRawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex = false}) => {
        "public_key": publicKey.jsonMap(asHex: asHex),
        "signature": signature.jsonMap(asHex: asHex),
      };

  Uint8List get pbBytes => writeToBuffer();

  @override
  BuilderInfo get info_ => _i;

  @TagNumber(1)
  Signature get signature => $_getN(0);
  @TagNumber(1)
  set signature(Signature v) {
    setField(1, v);
  }

  @TagNumber(1)
  bool hasSignature() => $_has(0);
  @TagNumber(1)
  void clearSignature() => clearField(1);
  @TagNumber(1)
  Signature ensureSignature() => $_ensure(0);

  @TagNumber(2)
  PublicKey get publicKey => $_getN(1);
  @TagNumber(2)
  set publicKey(PublicKey v) {
    setField(2, v);
  }

  @TagNumber(2)
  bool hasPublicKey() => $_has(1);
  @TagNumber(2)
  void clearPublicKey() => clearField(2);
  @TagNumber(2)
  PublicKey ensurePublicKey() => $_ensure(1);
}
