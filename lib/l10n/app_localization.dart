import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
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
      'chat': '�ျတ်',
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

  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get helloReader =>
      _localizedValues[locale.languageCode]!['helloReader']!;
  String get discoverNews =>
      _localizedValues[locale.languageCode]!['discoverNews']!;
  String get categories =>
      _localizedValues[locale.languageCode]!['categories']!;
  String get all => _localizedValues[locale.languageCode]!['all']!;
  String get noNews => _localizedValues[locale.languageCode]!['noNews']!;
  String get readMore => _localizedValues[locale.languageCode]!['readMore']!;
  String get retry => _localizedValues[locale.languageCode]!['retry']!;
  String get errorMessage =>
      _localizedValues[locale.languageCode]!['errorMessage']!;
  String get contactUs => _localizedValues[locale.languageCode]!['contactUs']!;
  String get call => _localizedValues[locale.languageCode]!['call']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get chat => _localizedValues[locale.languageCode]!['chat']!;
  String get refresh => _localizedValues[locale.languageCode]!['refresh']!;
  String get football => _localizedValues[locale.languageCode]!['football']!;
  String get cartoon => _localizedValues[locale.languageCode]!['cartoon']!;
  String get game => _localizedValues[locale.languageCode]!['game']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get myanmar => _localizedValues[locale.languageCode]!['myanmar']!;
  String get selectLanguage =>
      _localizedValues[locale.languageCode]!['selectLanguage']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get privacyPolicy =>
      _localizedValues[locale.languageCode]!['privacyPolicy']!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'my'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
