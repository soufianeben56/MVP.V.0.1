import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:infinity_circuit/presentation/views/splash/splash_view.dart';
import 'package:oktoast/oktoast.dart';

import 'exports.dart';
import 'generated/l10n.dart';

class MyApp extends StatefulWidget {
  final String routeName;

  const MyApp({super.key, required this.routeName});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Consumer2<LocalisationNotifier, ThemeNotifier>(
        builder: (context, localisationService, themeNotifier, child) {
          return MaterialApp(
            title: "Infinity Circuit",
            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            navigatorKey: NavigationService.navigationKey,
            theme: themeNotifier.themeData,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: localisationService.appLocal,
            supportedLocales: const [
              Locale('en'), // English
              Locale('de'), // German
            ],
            home: LayoutBuilder(
              builder: (context, constraints) {
                SizeConfig().init(context, constraints);
                return SplashView();
              },
            ),
          );
        },
      ),
    );
  }
}
