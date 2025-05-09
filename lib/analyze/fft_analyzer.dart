import 'dart:math' as math;
import 'dart:core';

/// Signal processor for frequency-domain analysis using FFT
class FftAnalyzer {
  /// Computes the phase angle between voltage and current waveforms in degrees
  /// using Discrete Fourier Transform (DFT)
  ///
  /// Parameters:
  /// - [u]: List of voltage samples
  /// - [i]: List of current samples
  ///
  /// Returns the phase angle in degrees. Positive values indicate that current
  /// leads voltage, negative values indicate that voltage leads current.
  static double computePhaseDeg(List<double> u, List<double> i) {
    // Validate input
    if (u.isEmpty || i.isEmpty || u.length != i.length) {
      throw ArgumentError('Voltage and current arrays must be non-empty and of equal length');
    }
    
    // Perform DFT on both signals
    final uSpectrum = computeDFT(u);
    final iSpectrum = computeDFT(i);
    
    // Find the frequency component with the highest amplitude (fundamental frequency)
    int fundamentalIndex = 1;  // Start from 1 to skip DC component
    double maxMagnitude = 0.0;
    
    for (int k = 1; k < u.length ~/ 2; k++) {
      double magnitude = math.sqrt(
          uSpectrum[k].real * uSpectrum[k].real + 
          uSpectrum[k].imaginary * uSpectrum[k].imaginary
      );
      
      if (magnitude > maxMagnitude) {
        maxMagnitude = magnitude;
        fundamentalIndex = k;
      }
    }
    
    // Get phase angles at the fundamental frequency
    double phaseU = math.atan2(uSpectrum[fundamentalIndex].imaginary, 
                               uSpectrum[fundamentalIndex].real);
    double phaseI = math.atan2(iSpectrum[fundamentalIndex].imaginary, 
                               iSpectrum[fundamentalIndex].real);
    
    // Calculate phase difference
    double phaseDiff = phaseI - phaseU;
    
    // Normalize to [-π, π] range
    while (phaseDiff > math.pi) phaseDiff -= 2 * math.pi;
    while (phaseDiff < -math.pi) phaseDiff += 2 * math.pi;
    
    // Convert to degrees
    double phaseDeg = phaseDiff * 180.0 / math.pi;
    
    return phaseDeg;
  }
  
  /// Computes the Discrete Fourier Transform (DFT) of a signal
  static List<ComplexNumber> computeDFT(List<double> signal) {
    int N = signal.length;
    List<ComplexNumber> result = List<ComplexNumber>.generate(N, (_) => ComplexNumber(0, 0));
    
    for (int k = 0; k < N; k++) {
      double real = 0.0;
      double imag = 0.0;
      
      for (int n = 0; n < N; n++) {
        double angle = 2 * math.pi * k * n / N;
        real += signal[n] * math.cos(angle);
        imag -= signal[n] * math.sin(angle);
      }
      
      result[k] = ComplexNumber(real, imag);
    }
    
    return result;
  }
  
  /// Normalizes a signal to have zero mean and unit variance
  static List<double> normalizeSignal(List<double> signal) {
    // Calculate mean
    double sum = 0.0;
    for (final value in signal) {
      sum += value;
    }
    final mean = sum / signal.length;
    
    // Calculate standard deviation
    double sumSquaredDifferences = 0.0;
    for (final value in signal) {
      final diff = value - mean;
      sumSquaredDifferences += diff * diff;
    }
    final stdDev = math.sqrt(sumSquaredDifferences / signal.length);
    
    // Normalize signal
    final normalized = List<double>.filled(signal.length, 0.0);
    if (stdDev > 0.0001) {  // Avoid division by near-zero
      for (int i = 0; i < signal.length; i++) {
        normalized[i] = (signal[i] - mean) / stdDev;
      }
    }
    
    return normalized;
  }
}

/// Simple complex number representation
class ComplexNumber {
  final double real;
  final double imaginary;
  
  ComplexNumber(this.real, this.imaginary);
}