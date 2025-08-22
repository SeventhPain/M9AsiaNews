import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:m9_news/l10n/app_localization.dart';
import 'package:m9_news/utils/constants.dart';
import 'package:m9_news/utils/language_manager.dart';
import 'package:m9_news/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get saved language or use Myanmar as default
  final String languageCode = await LanguageManager.getLanguage();

  // Verify the language is available, fallback to my if not
  final bool isLanguageAvailable = await LanguageManager.isLanguageAvailable(
    languageCode,
  );
  final String finalLanguageCode = isLanguageAvailable ? languageCode : 'my';

  runApp(MyApp(locale: LanguageManager.getLocale(finalLanguageCode)));
}

class MyApp extends StatefulWidget {
  final Locale locale;

  const MyApp({Key? key, required this.locale}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.locale;
  }

  void setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
    await LanguageManager.saveLanguage(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M9 News',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('my', ''),
        // Add more locales as needed, they will be dynamically checked
      ],
      theme: ThemeData(
        primaryColor: AppConstants.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppConstants.primaryColor,
          secondary: AppConstants.accentColor,
        ),
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
