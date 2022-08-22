import 'dart:typed_data';
import 'serializer.dart';
import 'package:witnet/utils.dart' show concatBytes;

const int TAG_TYPE_BITS = 3;
const int TAG_TYPE_MASK = (1 << TAG_TYPE_BITS) - 1;

enum WIRE_TYPE{
  VARINT,
  FIXED64,
  LENGTH_DELIMITED,
  START_GROUP,
  END_GROUP,
  FIXED32
}
const int VARINT = 0;
const int FIXED64 = 1;
const int LENGTH_DELIMITED = 2;
const int START_GROUP = 3;
const int END_GROUP = 4;
const int FIXED32 = 5;

int getTagFieldNumber(int tag) => tag >> TAG_TYPE_BITS;

int getTagWireType(int tag) => tag & TAG_TYPE_MASK;

int makeTag(int fieldNumber, int tag) => (fieldNumber << TAG_TYPE_BITS) | tag;

Uint8List makeTagBytes(int fieldNumber, int tag) =>
    varIntSerializer(makeTag(fieldNumber, tag));

Uint8List pbField(int fieldNumber, int tag, dynamic value){
  Uint8List _value = Uint8List.fromList([]);
  switch(tag) {
    case VARINT:
      _value = concatBytes([varInt(BigInt.from(value))]);
      break;
    case FIXED64:
    case LENGTH_DELIMITED:
      _value = bytesSerializer(value);
      break;
    case START_GROUP:
    case END_GROUP:
    case FIXED32:
  }
  return concatBytes([makeTagBytes(fieldNumber, tag), _value]);
}