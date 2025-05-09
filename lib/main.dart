import 'app.dart';
import 'exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialise Shared Preference
  await UserPreference.getInstance();
  await UserPreference.initializeDefaultCredentials();
  /// <<<<<<<<<<<<<<<<<<<<<<< System Configurations >>>>>>>>>>>>>>>>>>>>>>>>>
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryBackGroundColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  /// Initialise App
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalisationNotifier>(create: (_) => LocalisationNotifier()),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        // Add other providers here if necessary
      ],
      child: MyApp(
        routeName: RoutePaths.splashViewRoute,
      ),
    ),
  );
}
