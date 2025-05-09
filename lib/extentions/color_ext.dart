import '../exports.dart';

extension ColorX on Color {

}

extension ToastX on ToastStats {
  Color toastColor() {
    return switch (this) {
      ToastStats.info => Colors.yellow.shade800,
      ToastStats.error => AppColors.colorRed,
      ToastStats.success => AppColors.timeGreenText,
      ToastStats.warning => Colors.blue,
    };
  }
}
