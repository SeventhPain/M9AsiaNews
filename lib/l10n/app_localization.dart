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

  // Static fallback translations
  static final Map<String, Map<String, String>> _fallbackLocalizedValues = {
    'en': {
      'appName': 'M9 News',
      'helloReader': 'Hello Reader!',
      'discoverNews': 'Discover Latest News',
      'categories': 'Categories',
      'all': 'All',
      'noNews': 'No news available',
      'readMore': 'Read More',
      'retry': 'Retry',
      'errorMessage': 'Something went wrong',
      'contactUs': 'Contact Us',
      'call': 'Call',
      'email': 'Email',
      'chat': 'Chat',
      'refresh': 'Refresh',
      'football': 'Football',
      'cartoon': 'Cartoon',
      'game': 'Game',
      'settings': 'Settings',
      'language': 'Language',
      'english': 'English',
      'myanmar': 'Myanmar',
      'selectLanguage': 'Select Language',
      'cancel': 'Cancel',
      'save': 'Save',
      'privacyPolicy': 'Privacy Policy',
    },
    'my': {
      'appName': 'M9 သတင်း',
      'helloReader': 'စာဖတ်သူ မင်္ဂလာပါ!',
      'discoverNews': 'နောက်ဆုံးရသတင်းများ ရှာဖွေပါ',
      'categories': 'အမျိုးအစားများ',
      'all': 'အားလုံး',
      'noNews': 'သတင်းများ မရှိပါ',
      'readMore': 'ဆက်ဖတ်ရန်',
      'retry': 'ထပ်ကြိုးစားပါ',
      'errorMessage': 'တစ်ခုခု မှားယွင်းနေပါသည်',
      'contactUs': 'ဆက်သွယ်ရန်',
      'call': 'ဖုန်းခေါ်ဆိုရန်',
      'email': 'အီးမေးလ်',
      'chat': 'ချတ်',
      'refresh': 'ပြန်လည်မွမ်းမံရန်',
      'football': 'ဘောလုံး',
      'cartoon': 'ကာတွန်း',
      'game': 'ဂိမ်း',
      'settings': 'ဆက်တင်များ',
      'language': 'ဘာသာစကား',
      'english': 'အင်္ဂလိပ်',
      'myanmar': 'မြန်မာ',
      'selectLanguage': 'ဘာသာစကား ရွေးချယ်ပါ',
      'cancel': 'မလုပ်တော့ပါ',
      'save': 'သိမ်းဆည်းပါ',
      'privacyPolicy': 'ကိုယ်ရေးကိုယ်တာ မူဝါဒ',
    },
  };

  // Initialize - try API first, fallback to static if fails
  Future<void> initialize() async {
    final languageService = LanguageService(client: http.Client());

    try {
      // Try to fetch all languages from API
      final Map<String, Map<String, String>> allLanguages =
          await languageService.fetchAllLanguageStrings();

      // Check if current locale is supported by API
      if (allLanguages.containsKey(locale.languageCode)) {
        _currentStrings = allLanguages[locale.languageCode]!;
        if (kDebugMode) {
          print('Loaded ${locale.languageCode} strings from API');
        }
      } else {
        // If current locale not in API, fallback to static
        throw Exception('Language ${locale.languageCode} not available in API');
      }
    } catch (e) {
      // Fallback to static values if API fails
      if (kDebugMode) {
        print('Using fallback language strings for ${locale.languageCode}: $e');
      }
      _currentStrings =
          _fallbackLocalizedValues[locale.languageCode] ??
          _fallbackLocalizedValues['my']!;
    }
  }

  // Get string with proper fallback handling
  String _getString(String key) {
    // Try current strings (from API or fallback)
    if (_currentStrings.containsKey(key)) {
      return _currentStrings[key]!;
    }

    // Fallback to Myanmar static values
    if (_fallbackLocalizedValues['my']!.containsKey(key)) {
      return _fallbackLocalizedValues['my']![key]!;
    }

    // Final fallback to key itself
    return key;
  }

  // Getters for all strings
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
    return true; // We'll dynamically check availability
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
