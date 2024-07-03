import 'dart:typed_data';

ByteData getBufferCopy(ByteData source) {
  return Uint8List.fromList(source.buffer.asUint8List()).buffer.asByteData();
}
