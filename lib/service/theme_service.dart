import 'package:infinity_circuit/exports.dart';

class ThemeNotifier with ChangeNotifier {
  late ThemeData _themeData;

  ThemeNotifier() {
    initiateTheme();
  }

  ThemeData get themeData => _themeData;

  void initiateTheme() {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.light) {
      _themeData = lightTheme;
    } else {
      _themeData = lightTheme;
    }
    notifyListeners();
  }

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  final darkTheme = ThemeData(
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
          Colors.grey.withOpacity(0.7)), // Set the scrollbar thumb color.
      trackColor: WidgetStateProperty.all(
          Colors.grey.withOpacity(0.7)), // Set the scrollbar track color.
    ),
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    dividerColor: AppColors.color212121.withOpacity(0.6),
    splashColor: Colors.transparent,
    buttonTheme: const ButtonThemeData(
      splashColor: Colors.transparent,
    ),
  );

  final lightTheme = ThemeData(
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
          Colors.grey.withOpacity(0.7)), // Set the scrollbar thumb color.
      trackColor: WidgetStateProperty.all(
          Colors.grey.withOpacity(0.7)), // Set the scrollbar track color.
    ),
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    dialogTheme: const DialogTheme(),
    datePickerTheme: const DatePickerThemeData(
      surfaceTintColor: Colors.transparent,
    ),
    buttonTheme: const ButtonThemeData(
      splashColor: Colors.transparent,
    ),
  );
}
