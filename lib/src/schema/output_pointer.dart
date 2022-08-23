part of 'schema.dart';

class OutputPointer {
  OutputPointer({
    required this.transactionId,
    required this.outputIndex,
  });

  Hash transactionId;
  int outputIndex;

  factory OutputPointer.fromString(String str) => OutputPointer(
        transactionId: Hash.fromString(str.split(':')[0]),
        outputIndex: int.parse(str.split(':')[1]),
      );

  String toString() {
    return 'OuputPointer(transactionID: $transactionId, index: $outputIndex)';
  }

  String rawJson({bool asHex = false}) => json.encode(jsonMap(asHex: asHex));

  Map<String, dynamic> jsonMap({bool asHex=false}) =>
      {'output_pointer': '${transactionId.hex}:$outputIndex'};

  Uint8List get pbBytes {
    return concatBytes([
      pbField(1, LENGTH_DELIMITED, transactionId.pbBytes),
      (outputIndex > 0)
          ? pbField(2, VARINT, outputIndex)
          : Uint8List.fromList([])
    ]);
  }
}
