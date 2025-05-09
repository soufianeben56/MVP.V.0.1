
import 'dart:io';

extension FileUtils on File {
  double measureFileSize() {
    int sizeInBytes = lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }
}