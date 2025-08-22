import 'package:flutter/material.dart';
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
    return prefs.getString(_languageKey) ?? 'my'; // Default to Myanmar
  }

  static Locale getLocale(String languageCode) {
    return Locale(languageCode, '');
  }

  // Get language name from API strings
  static Future<String> getLanguageName(
    String languageCode,
    BuildContext context,
  ) async {
    try {
      final languageService = LanguageService(client: http.Client());
      final allLanguages = await languageService.fetchAllLanguageStrings();

      if (allLanguages.containsKey(languageCode)) {
        final languageStrings = allLanguages[languageCode]!;
        return languageStrings['language'] ?? languageCode.toUpperCase();
      }
    } catch (e) {
      // If API fails, return the language code
    }

    return languageCode.toUpperCase();
  }

  // Check if a language is available in API
  static Future<bool> isLanguageAvailable(String languageCode) async {
    try {
      final languageService = LanguageService(client: http.Client());
      final availableLanguages = await languageService
          .getAvailableLanguageCodes();
      return availableLanguages.contains(languageCode);
    } catch (e) {
      return false;
    }
  }
}
