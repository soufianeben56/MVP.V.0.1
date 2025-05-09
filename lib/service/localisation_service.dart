import '../exports.dart';
import '../generated/l10n.dart';

class LocalisationNotifier extends ChangeNotifier {
  LocalisationNotifier() {
    fetchLocale();
  }

  Locale _appLocale = const Locale(english);

  Locale get appLocal => _appLocale;
  static const String english = "en";
  static const String german = "de";

  static List<LanguageModel> supportedLocales(BuildContext context) {
    return [
      LanguageModel(
        label: S.of(context).english,
        code: english, /*flag: Assets.svg.english.svg()*/
      ),
      LanguageModel(
        label: S.of(context).german,
        code: german,
        /*flag: Assets.svg.arabic.svg(
          height: SizeConfig.relativeHeight(2.46),
        ),*/
      )
    ];
  }

  void fetchLocale() async {
    bool? isLocalisationStored =
        UserPreference.containsKey(PrefKeys.languageCode);
    isLocalisationStored ??= false;
    if (isLocalisationStored) {
      if (UserPreference.getString(PrefKeys.languageCode) == null) {
        _appLocale = const Locale(english);
        notifyListeners();

        // return;
      } else {
        _appLocale = Locale(UserPreference.getString(PrefKeys.languageCode)!);
        notifyListeners();
      }
    } else {
      _appLocale = const Locale(english);
      UserPreference.putString(PrefKeys.languageCode, english);
      notifyListeners();
    }

    // return;
  }

  void changeLanguage(Locale type) async {
    log(type.languageCode);
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale(german)) {
      _appLocale = const Locale(german);
      await UserPreference.putString(PrefKeys.languageCode, german);
      if (hasListeners) {
        log("message");
        notifyListeners();
      }
      return;
    } else {
      _appLocale = const Locale(english);
      await UserPreference.putString(PrefKeys.languageCode, english);
      if (hasListeners) {
        log("message");
        notifyListeners();
      }
      return;
    }
  }

  String getCurrentLanguageLabel() {
    switch (_appLocale.languageCode) {
      case english:
        return S.current.english;
      case german:
        return S.current.german;
      default:
        return S.current.german;
    }
  }

  String getCurrentLanguageCode() {
    switch (_appLocale.languageCode) {
      case english:
        return "en";
      case german:
        return "de";
      default:
        return "";
    }
  }

  bool isGerman() {
    return _appLocale.languageCode == "de";
  }
}
