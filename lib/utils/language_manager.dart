import 'package:flutter/material.dart';
import 'package:m9_news/l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageManager {
  static const String _languageKey = 'selected_language';

  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'my'; // Myanmar as default
  }

  static Locale getLocale(String languageCode) {
    switch (languageCode) {
      case 'en':
        return const Locale('en', '');
      case 'my':
        return const Locale('my', '');
      default:
        return const Locale('my', ''); // Myanmar as default
    }
  }

  static String getLanguageName(String languageCode, BuildContext context) {
    final localizations = AppLocalizations.of(context);
    switch (languageCode) {
      case 'en':
        return localizations?.english ?? 'English';
      case 'my':
        return localizations?.myanmar ?? 'Myanmar';
      default:
        return localizations?.myanmar ?? 'Myanmar';
    }
  }
}
