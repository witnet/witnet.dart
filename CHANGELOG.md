## 0.2.9
- Throw 'Insufficient funds' error when covering UTXOS
- Retry failing requests to the explorer

## 0.2.8
- Update AddressDataRequestsSolved `fromJson` and `toJson`
- Update AddressBlocks `jsonMap` result

## 0.2.7
- Fix error getting inputs from hash

## 0.2.6
- Fix type error when getting pending transaction from hash

## 0.2.5
- Add validation for XPRV checksum
- Add `address_info` endpoint for the Explorer
- Add BlockDetails type for the Explorer
- Export additional classes for the Explorer

## 0.2.4
- Throw error when getMultiUtxoInfo fails

## 0.2.3
- Add `valueTransferPriority` method

## 0.2.2
- Fix send transaction method
- Format style

## 0.2.1
- Add `fixnum` dependency to use `^1.1.0`

## 0.2.0
- Migrate protobuf schema from a custom solution to a native supported version of protobuf
- Fix _handle() method to buffer the socket response
- Fix RAD Retrieve JSON output 
- Update to `test@^1.21.6` 
- Update to `xml@^6.1.0`
- Export AES codec as part of this package
- Fix return type for timelock from int64 to int
- Remove print statements
- Remove unused imports
- Remove dead code
- Fix protobuf schema for data requests
- Sort unused schema objects to the bottom of the schema file
- Fix PublicKey JSON parsing
- Fix TallyTransaction JSON parsing
- Add RNG source for generating rad requests
- Add `mempool` method
- Correct protobuf schema for data requests 
- Add `sendVTTransaction` and `sendDRTransaction` methods, previously it was required to use the `inventory` method
- Add `ConsensusConstants` JSON to the protobuf schema and as a return type in the node client
- Refactor: return types for peer methods to return a list of peers instead of a raw JSON map
- Fix publicKey number of bytes 

## 0.1.4
- ability to clear UtxoPool
- removed print statements used for testing

## 0.1.3
- Xpub and more

## 0.1.2
- Updated Explorer API

## 0.1.1
- initial release candidate 

## 0.1.0
- Initial version
