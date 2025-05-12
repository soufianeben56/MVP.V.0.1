import 'app.dart';
import 'exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  runApp(MyAppWithInitialLoading());
}

class MyAppWithInitialLoading extends StatelessWidget {
  const MyAppWithInitialLoading({super.key});

  Future<void> _initializeApp() async {
    print("[MyAppWithInitialLoading] _initializeApp: Start");
    try {
      /// Initialise Shared Preference
      print("[MyAppWithInitialLoading] _initializeApp: Initializing UserPreference.getInstance()...");
      await UserPreference.getInstance();
      print("[MyAppWithInitialLoading] _initializeApp: UserPreference.getInstance() done.");
      print("[MyAppWithInitialLoading] _initializeApp: Initializing UserPreference.initializeDefaultCredentials()...");
      await UserPreference.initializeDefaultCredentials();
      print("[MyAppWithInitialLoading] _initializeApp: UserPreference.initializeDefaultCredentials() done.");
      // Add any other asynchronous initialization here
      print("[MyAppWithInitialLoading] _initializeApp: End");
    } catch (e, s) {
      print("[MyAppWithInitialLoading] _initializeApp: Error: $e");
      print("[MyAppWithInitialLoading] _initializeApp: Stacktrace: $s");
      rethrow; // Re-throw the error so FutureBuilder can see it
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Ensure MaterialApp is imported if not covered by 'exports.dart'
      home: FutureBuilder<void>(
        future: _initializeApp(),
        builder: (context, snapshot) {
          print("[MyAppWithInitialLoading] FutureBuilder: snapshot.connectionState = ${snapshot.connectionState}");
          if (snapshot.hasError) {
            print("[MyAppWithInitialLoading] FutureBuilder: snapshot.hasError = true, error = ${snapshot.error}");
            print("[MyAppWithInitialLoading] FutureBuilder: error stacktrace = ${snapshot.stackTrace}");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print("[MyAppWithInitialLoading] FutureBuilder: Initialisation failed. Showing error.");
              return Scaffold(
                body: Center(
                  child: Text('Error initializing app: ${snapshot.error}'),
                ),
              );
            }
            print("[MyAppWithInitialLoading] FutureBuilder: Initialisation complete. Loading main application...");
            
            // Stelle den ursprünglichen App-Start wieder her
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<LocalisationNotifier>(create: (_) => LocalisationNotifier()),
                ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
                // Add other providers here if necessary
              ],
              child: MyApp(
                routeName: RoutePaths.splashViewRoute,
              ),
            );
          } else {
            print("[MyAppWithInitialLoading] FutureBuilder: Showing loading indicator.");
            // Show loading indicator while waiting for initialization
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
