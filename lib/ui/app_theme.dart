import 'package:infinity_circuit/exports.dart';

class AppTheme with ChangeNotifier {
  static const String poppinsRegular = "Poppins-Regular";
  //
  static const String montRegular = "Mont-Regular";
  static const String montBold = "Mont-Bold";
  static const String montSemiBold = "Mont-SemiBold";

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeData => _themeMode;

  ThemeMode getCurrentTheme() {
    if (UserPreference.containsKey(PrefKeys.theme) ?? false) {
      _themeMode = UserPreference.getString(PrefKeys.theme) == "light"
          ? ThemeMode.light
          : ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    return _themeMode;
  }

  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: montRegular,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.blue,
        brightness: Brightness.dark,
      ),
    );
  }

  void setDarkMode() async {
    _themeMode = ThemeMode.dark;
    UserPreference.putString(PrefKeys.theme, 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeMode = ThemeMode.light;
    UserPreference.putString(PrefKeys.theme, 'light');
    notifyListeners();
  }
}
