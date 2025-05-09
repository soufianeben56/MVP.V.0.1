// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign in`
  String get sing_in {
    return Intl.message(
      'Sign in',
      name: 'sing_in',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get german {
    return Intl.message(
      'German',
      name: 'german',
      desc: '',
      args: [],
    );
  }

  /// `Hi there`
  String get hiThere {
    return Intl.message(
      'Hi there',
      name: 'hiThere',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `To Infinity Circuit`
  String get toInfinityCircuit {
    return Intl.message(
      'To Infinity Circuit',
      name: 'toInfinityCircuit',
      desc: '',
      args: [],
    );
  }

  /// `Experiment`
  String get experiments {
    return Intl.message(
      'Experiment',
      name: 'experiments',
      desc: '',
      args: [],
    );
  }

  /// `Tutorial`
  String get tutorial {
    return Intl.message(
      'Tutorial',
      name: 'tutorial',
      desc: '',
      args: [],
    );
  }

  /// `Solution`
  String get solution {
    return Intl.message(
      'Solution',
      name: 'solution',
      desc: '',
      args: [],
    );
  }

  /// `Allgemeine Geschäftsbedingungen`
  String get terms_and_condition {
    return Intl.message(
      'Allgemeine Geschäftsbedingungen',
      name: 'terms_and_condition',
      desc: '',
      args: [],
    );
  }

  /// `  Indem Sie fortfahren, stimmen Sie unseren zu`
  String get byContinuing {
    return Intl.message(
      '  Indem Sie fortfahren, stimmen Sie unseren zu',
      name: 'byContinuing',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Infinity Circuit`
  String get infinityCircuit {
    return Intl.message(
      'Infinity Circuit',
      name: 'infinityCircuit',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Do not have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Do not have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Anleitung`
  String get anleitung {
    return Intl.message(
      'Anleitung',
      name: 'anleitung',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email`
  String get enteremail {
    return Intl.message(
      'Enter Email',
      name: 'enteremail',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name`
  String get entername {
    return Intl.message(
      'Enter Name',
      name: 'entername',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enterpassword {
    return Intl.message(
      'Enter Password',
      name: 'enterpassword',
      desc: '',
      args: [],
    );
  }

  /// `Anmeldung`
  String get anmeldung {
    return Intl.message(
      'Anmeldung',
      name: 'anmeldung',
      desc: '',
      args: [],
    );
  }

  /// `Sicherheitshinweise`
  String get sicherheitshinweise {
    return Intl.message(
      'Sicherheitshinweise',
      name: 'sicherheitshinweise',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'meinGerät' key

  /// `Hallo,`
  String get hallo {
    return Intl.message(
      'Hallo,',
      name: 'hallo',
      desc: '',
      args: [],
    );
  }

  /// ` "Lorem ipsum dolor sit amet consectetur. Massa ultricies tristique sed integer fringilla vitae. Eget eget in feugiat ullamcorper donec vitae. Commodo adipiscing leo semper nec ut in dolor fermentum massa. Quam rhoncus vitae scelerisque id tortor accumsan magna. Ridiculus velit eget semper orci nunc lectus faucibus faucibus diam. Vestibulum in sociis amet viverra in."\n                      "Vivamus turpis aliquam felis venenatis cum amet ut euismod augue. At ultrices sit faucibus purus eu in. Nam ut lectus magna egestas ultricies etiam dui. Lacus orci amet quis adipiscing scelerisque pharetra. Ut augue amet sociis rhoncus tempor urna posuere porta aliquam. Tincidunt aliquam libero neque massa dui diam urna tortor. Odio consectetur tortor mi consequat libero eget consectetur. Lorem a sed curabitur nulla at dictumst cursus at. Ipsum enim platea varius adipiscing porttitor vel amet mauris gravida. Nec turpis nisl odio vel volutpat. Enim facilisis dui elit imperdiet duis in donec consectetur mattis.",\n                  `
  String get sicherheitshinweise1 {
    return Intl.message(
      ' "Lorem ipsum dolor sit amet consectetur. Massa ultricies tristique sed integer fringilla vitae. Eget eget in feugiat ullamcorper donec vitae. Commodo adipiscing leo semper nec ut in dolor fermentum massa. Quam rhoncus vitae scelerisque id tortor accumsan magna. Ridiculus velit eget semper orci nunc lectus faucibus faucibus diam. Vestibulum in sociis amet viverra in."\n                      "Vivamus turpis aliquam felis venenatis cum amet ut euismod augue. At ultrices sit faucibus purus eu in. Nam ut lectus magna egestas ultricies etiam dui. Lacus orci amet quis adipiscing scelerisque pharetra. Ut augue amet sociis rhoncus tempor urna posuere porta aliquam. Tincidunt aliquam libero neque massa dui diam urna tortor. Odio consectetur tortor mi consequat libero eget consectetur. Lorem a sed curabitur nulla at dictumst cursus at. Ipsum enim platea varius adipiscing porttitor vel amet mauris gravida. Nec turpis nisl odio vel volutpat. Enim facilisis dui elit imperdiet duis in donec consectetur mattis.",\n                  ',
      name: 'sicherheitshinweise1',
      desc: '',
      args: [],
    );
  }

  /// `Hinweis`
  String get Hinweis {
    return Intl.message(
      'Hinweis',
      name: 'Hinweis',
      desc: '',
      args: [],
    );
  }

  /// `Verwendung des Breadboards:`
  String get VerwendungdesBreadboards {
    return Intl.message(
      'Verwendung des Breadboards:',
      name: 'VerwendungdesBreadboards',
      desc: '',
      args: [],
    );
  }

  /// `Wie zu verwenden`
  String get Wiezuverwenden {
    return Intl.message(
      'Wie zu verwenden',
      name: 'Wiezuverwenden',
      desc: '',
      args: [],
    );
  }

  /// `Sicherheitsunterweisung`
  String get Sicherheitsunterweisung {
    return Intl.message(
      'Sicherheitsunterweisung',
      name: 'Sicherheitsunterweisung',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'device scan' key

  // skipped getter for the 'device list' key
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
