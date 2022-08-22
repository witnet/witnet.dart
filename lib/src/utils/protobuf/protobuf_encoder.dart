
import 'dart:typed_data';

import 'package:witnet/src/utils/protobuf/wire_type.dart';
import 'package:witnet/src/utils/transformations/transformations.dart';

class ProtobufWriter{

  Uint8List buffer = Uint8List.fromList([]);

  int encodeZigZag32(int value) => (value << 1) ^ (value >> 31);


  Uint8List writeVarInt32(int value){
    List<int> _value = [];
    while (value >= 0x80) {
      _value.add([(value & 0x7F | 0x80).toInt()][0]);
      value >>= 7;
    }
    _value.add(value.toInt());
    return Uint8List.fromList(_value);
  }

  Uint8List writeVarInt(BigInt value){
    List<int> _value = [];
    while (value >= BigInt.from(0x80)) {
      _value.add([(value & BigInt.from(0x7F) | BigInt.from(0x80)).toInt()][0]);
      value >>= 7;
    }
    _value.add(value.toInt());
    return Uint8List.fromList(_value);
  }

}

class ProtobufReader{
  static const int DEFAULT_RECURSION_LIMIT = 64;
  static const int DEFAULT_SIZE_LIMIT = 64 << 20;

  final Uint8List _buffer;
  int _bufferPos = 0;
  int _currentLimit = -1;
  int _lastTag = 0;
  // int _recursionDepth = 0;
  // final int _recursionLimit;
  final int _sizeLimit;

  ProtobufReader( Uint8List buffer,
    { int recursionLimit = DEFAULT_RECURSION_LIMIT,
      int sizeLimit = DEFAULT_SIZE_LIMIT,
    }) :
      _buffer = buffer,
      // _recursionLimit = recursionLimit,
      _sizeLimit = sizeLimit {
    _currentLimit = _sizeLimit;
  }

  ByteData readByteData(int sizeInBytes){
    return ByteData.view(
      _buffer.buffer,
      _buffer.offsetInBytes + _bufferPos - sizeInBytes,
      sizeInBytes
    );
  }

  int readVarInt(bool signed, int length){
    // Read up to 10 bytes.
    // We use a local [bufferPos] variable to avoid repeatedly loading/store the
    // this._bufferpos field.
    var bufferPos = _bufferPos;
    var bytes = _currentLimit - bufferPos;
    if (bytes > length) bytes = length;
    var result = 0;
    for (var i = 0; i < bytes; i++) {
      var byte = _buffer[bufferPos++];
      result |= (byte & 0x7f) << (i * 7);
      print(result);
      if ((byte & 0x80) == 0) {
        result &= 0xffffffff;
        _bufferPos = bufferPos;

        return signed ? result - 2 * (0x80000000 & result) : result;
      }
    }
    _bufferPos = bufferPos;
    return 0;
    // throw Exception('malformed VarInt');
  }


  int readRawVarInt32(bool signed){
    // Read up to 10 bytes.
    // We use a local [bufferPos] variable to avoid repeatedly loading/store the
    // this._bufferpos field.
    List<int> _data = [];
    var bufferPos = _bufferPos;
    var bytes = _currentLimit - bufferPos;
    print(bytes);
    if (bytes > 10) bytes = 10;
    var result = 0;
    for (var i = 0; i < bytes; i++) {
      var byte = _buffer[bufferPos++];
      print(byte);
      result |= (byte & 0x7f) << (i * 7);
      if ((byte & 0x80) == 0) {
        result &= 0xffffffff;
        _bufferPos = bufferPos;
         signed ? _data.add(result - 2 * (0x80000000 & result)) : _data.add(result);
      }
    }
    _bufferPos = bufferPos;
    print(_data);
    return bytesToBigInt(Uint8List.fromList(_data)).toInt();
    // throw Exception('malformed VarInt');
  }

  int readInt32() => readRawVarInt32(true);
  int readUint32() => readRawVarInt32(false);
  bool readBool() => readRawVarInt32(true) != 0;

  int readEnum() => readInt32();

  void _checkLimit(int increment) {
    assert(_currentLimit != -1);
    _bufferPos += increment;
    if (_bufferPos > _currentLimit) {
      throw Exception('truncated message');
    }
  }

  Uint8List readBytes(){
    var length = readInt32();
    print('length: ' + length.toString());
    _checkLimit(length);
    return Uint8List.view(
        _buffer.buffer, _buffer.offsetInBytes + _bufferPos - length, length);
  }


  bool isAtEnd() => _bufferPos >= _currentLimit;

  int readTag(){
    if(isAtEnd()){
      _lastTag = 0;
      return 0;
    }
    _lastTag = readUint32();
    if(getTagFieldNumber(_lastTag) == 0){
      print('error: invalid Tag');
    }
    return _lastTag;
  }

}