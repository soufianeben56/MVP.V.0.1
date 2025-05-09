import 'dart:typed_data';

/// A class representing a parsed AC measurement block from a BLE frame
class ParsedAcBlock {
  /// The sequence number of this measurement block
  final int sequence;
  
  /// List of voltage samples (length = samplesPerBlock, typically 40)
  final List<double> voltSamples;
  
  /// List of current samples (length = samplesPerBlock, typically 40)
  final List<double> currSamples;

  ParsedAcBlock({
    required this.sequence,
    required this.voltSamples,
    required this.currSamples,
  });
}

/// A low-level parser for BLE frames containing AC measurements
class BlePacketParser {
  /// Parses a BLE frame containing AC measurement data
  /// 
  /// Packet format (new format without header and RMS values):
  /// - Byte 0-3: uint32 sequence (little endian)
  /// - Byte 4-...: n×SensorData (each SensorData = int16 U*100, uint16 I*10000)
  /// 
  /// Returns a [ParsedAcBlock] object or null if the frame is invalid
  static ParsedAcBlock? parse(Uint8List frame) {
    // Check minimum frame length (sequence = 4 bytes + at least one data pair = 4 bytes)
    if (frame.isEmpty || frame.length < 8) {
      return null;
    }
    
    // Create ByteData view for easy access to binary data
    final byteData = ByteData.sublistView(frame);
    
    // Parse sequence number (uint32, little endian)
    final sequence = byteData.getUint32(0, Endian.little);
    
    // Calculate number of sample pairs (each pair is 4 bytes: 2 bytes voltage + 2 bytes current)
    final numSamplePairs = (frame.length - 4) ~/ 4;
    
    // Parse samples
    final voltSamples = <double>[];
    final currSamples = <double>[];
    
    for (int i = 0; i < numSamplePairs; i++) {
      final offset = 4 + i * 4;
      
      // Parse voltage (int16, 0.01 V/LSB)
      final voltRaw = byteData.getInt16(offset, Endian.little);
      final volt = voltRaw / 100.0;
      voltSamples.add(volt);
      
      // Parse current (uint16, 0.0001 A/LSB)
      final currRaw = byteData.getUint16(offset + 2, Endian.little);
      final curr = currRaw / 10000.0;
      currSamples.add(curr);
    }
    
    return ParsedAcBlock(
      sequence: sequence,
      voltSamples: voltSamples,
      currSamples: currSamples,
    );
  }
} 