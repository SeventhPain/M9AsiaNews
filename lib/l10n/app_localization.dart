import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m9_news/services/language_service.dart';
import 'package:http/http.dart' as http;

class AppLocalizations {
  final Locale locale;
  Map<String, String> _currentStrings = {};

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Initialize - load language strings from API
  Future<void> initialize() async {
    final languageService = LanguageService(client: http.Client());

    try {
      // Fetch all languages from API
      final Map<String, Map<String, String>> allLanguages =
          await languageService.fetchAllLanguageStrings();

      // Get strings for current locale
      if (allLanguages.containsKey(locale.languageCode)) {
        _currentStrings = allLanguages[locale.languageCode]!;
        if (kDebugMode) {
          print('Loaded ${locale.languageCode} strings from API');
        }
      } else {
        // If current locale not found, use first available language or empty
        final availableLanguages = allLanguages.keys.toList();
        if (availableLanguages.isNotEmpty) {
          _currentStrings = allLanguages[availableLanguages.first]!;
        } else {
          _currentStrings = {};
        }
      }
    } catch (e) {
      // If API fails completely, use empty strings
      if (kDebugMode) {
        print('Failed to load language strings from API: $e');
      }
      _currentStrings = {};
    }
  }

  // Get string from API response
  String _getString(String key) {
    return _currentStrings[key] ?? key; // Return key as fallback if not found
  }

  // Getters for all strings - these will return the key if not found in API
  String get appName => _getString('appName');
  String get helloReader => _getString('helloReader');
  String get discoverNews => _getString('discoverNews');
  String get categories => _getString('categories');
  String get all => _getString('all');
  String get noNews => _getString('noNews');
  String get readMore => _getString('readMore');
  String get retry => _getString('retry');
  String get errorMessage => _getString('errorMessage');
  String get contactUs => _getString('contactUs');
  String get call => _getString('call');
  String get email => _getString('email');
  String get chat => _getString('chat');
  String get refresh => _getString('refresh');
  String get football => _getString('football');
  String get cartoon => _getString('cartoon');
  String get game => _getString('game');
  String get settings => _getString('settings');
  String get language => _getString('language');
  String get english => _getString('english');
  String get myanmar => _getString('myanmar');
  String get selectLanguage => _getString('selectLanguage');
  String get cancel => _getString('cancel');
  String get save => _getString('save');
  String get privacyPolicy => _getString('privacyPolicy');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Support all languages that might come from API
    return true;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final appLocalizations = AppLocalizations(locale);
    await appLocalizations.initialize();
    return appLocalizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
