part of 'script.dart';

enum Op {
  /// Pop two elements from the stack, push boolean indicating whether they are equal.
  Equal,
  /// Pop bytes from the stack and apply SHA-256 truncated to 160 bits. This is the hash used in Witnet to calculate a PublicKeyHash from a PublicKey.
  Hash160,
  /// Pop bytes from the stack and apply SHA-256.
  Sha256,
  /// Pop PublicKeyHash and Signature from the stack, push boolean indicating whether the signature is valid.
  CheckSig,
  /// Pop integer "n", n PublicKeyHashes, integer "m" and m Signatures. Push boolean indicating whether the signatures are valid.
  CheckMultiSig,
  /// Pop integer "timelock" from the stack, push boolean indicating whether the block timestamp is greater than the timelock.
  CheckTimeLock,
  /// Stop script execution if top-most element of stack is not "true".
  Verify,
  /// Pop boolean from the stack and conditionally execute the next If block.
  If,
  /// Flip execution condition inside an If block.
  Else,
  /// Mark end of If block.
  EndIf,
}

final op_to_function_map = {
  Op.Equal: equalOperator,
  Op.Hash160: hash160Operator,
  Op.Sha256: sha256Operator,
  Op.CheckSig: checkSigOperator,
  Op.CheckMultiSig: 'checkmultisig',
  Op.CheckTimeLock: 'checktimelock',
  Op.Verify: 'verify',
  Op.If: 'if',
  Op.Else: 'else',
  Op.EndIf: 'endif',
};

final op_to_str_map = {
  Op.Equal: 'equal',
  Op.Hash160: 'hash160',
  Op.Sha256: 'sha256',
  Op.CheckSig: 'checksig',
  Op.CheckMultiSig: 'checkmultisig',
  Op.CheckTimeLock: 'checktimelock',
  Op.Verify: 'verify',
  Op.If: 'if',
  Op.Else: 'else',
  Op.EndIf: 'endif',
};

String operatorToString(Op op){
  switch(op){
    case Op.Equal: return 'equal';
    case Op.Hash160: return 'hash160';
    case Op.Sha256: return 'sha256';
    case Op.CheckSig: return 'checksig';
    case Op.CheckMultiSig: return 'checkmultisig';
    case Op.CheckTimeLock: return 'checktimelock';
    case Op.Verify: return 'verify';
    case Op.If: return 'if';
    case Op.Else: return 'else';
    case Op.EndIf: return 'endif';
  }
}

/// Pop two elements from the stack, push boolean indicating whether they are equal.
Stack equalOperator(Stack stack){
  dynamic a = stack.pop();
  dynamic b = stack.pop();
  stack.push(a == b);
  return stack;
}

/// Pop bytes from the stack and apply SHA-256 truncated to 160 bits. This is the hash used in Witnet to calculate a PublicKeyHash from a PublicKey.
Stack hash160Operator(Stack stack) {

  dynamic a = stack.pop();
  return stack;
  hash160(data: stack as Uint8List);

}

/// Pop bytes from the stack and apply SHA-256.
Stack sha256Operator(Stack stack) {

  dynamic a = stack.pop();
  stack.push(sha256(data: a));
  return stack;

}

/// Pop PublicKeyHash and Signature from the stack, push boolean indicating whether the signature is valid.
Stack checkSigOperator(
    Stack stack,
    Uint8List transaction_hash,
    bool disable_signature_verify,
    ) {
  /// TODO:
  PublicKeyHash pkh = stack.pop();
  List<PublicKeyHash> pkhs = [];
  List<KeyedSignature> keyedSignatures = [];

  KeyedSignature keyedSignature = stack.pop();

  Stack result = checkMultiSig(
    pkhs,
    keyedSignatures,
    transaction_hash,
    true,
    stack,
  );

  return stack;
}

/// Pop integer "n", n PublicKeyHashes, integer "m" and m Signatures. Push boolean indicating whether the signatures are valid.
Stack checkMultiSig(List<PublicKeyHash> pkhs,

    List<KeyedSignature> keyed_signatures,
    Uint8List transaction_hash,
    bool disable_signature_verify,
    Stack stack
    ) {
  /// TODO:
  return stack;

}

Stack checkMultiSigOperator(
    Stack stack,
    Uint8List transactionHash,
    bool disableSignatureVerify,
    ) {
  /// TODO

  int m = stack.pop();
  if (m <= 0 || m > 20){
    // bad number of public keys in multi sig
  }


  return stack;
}

/// Pop integer "timelock" from the stack, push boolean indicating whether the block timestamp is greater than the timelock.
Stack checkTimelockOperator(Stack stack) {
  /// TODO
  return stack;
}

/// Stop script execution if top-most element of stack is not "true".
Stack verifyOperator(Stack stack) {
  /// TODO:
  return stack;
}

/// Flip execution condition inside an If block.
Stack ifOperator(Stack stack) {
  /// TODO:
  return stack;
}

/// Flip execution condition inside an If block.
Stack elseOperator(Stack stack) {
  /// TODO:
  return stack;
}

/// Mark end of If block.
Stack endIfOperator(Stack stack) {
  /// TODO:
  return stack;
}
