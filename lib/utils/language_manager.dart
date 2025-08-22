import 'package:flutter/material.dart';
import 'package:m9_news/l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:m9_news/services/language_service.dart';
import 'package:http/http.dart' as http;

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
    return Locale(languageCode, '');
  }

  static String getLanguageName(String languageCode, BuildContext context) {
    final localizations = AppLocalizations.of(context);
    switch (languageCode) {
      case 'en':
        return localizations?.english ?? 'English';
      case 'my':
        return localizations?.myanmar ?? 'Myanmar';
      default:
        return languageCode.toUpperCase();
    }
  }

  // Check if a language is available in API
  static Future<bool> isLanguageAvailable(String languageCode) async {
    try {
      final languageService = LanguageService(client: http.Client());
      final availableLanguages = await languageService
          .getAvailableLanguageCodes();
      return availableLanguages.contains(languageCode);
    } catch (e) {
      // If API fails, assume only en and my are available
      return ['en', 'my'].contains(languageCode);
    }
  }
}
