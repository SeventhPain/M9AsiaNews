import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class LanguageService {
  static const String baseUrl = 'https://gamb.be.prmr.site/api/v1';

  final http.Client client;

  LanguageService({required this.client});

  Future<Map<String, Map<String, String>>> fetchAllLanguageStrings() async {
    try {
      final response = await client
          .get(
            Uri.parse('$baseUrl/language'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true && data['data'] is Map) {
          final Map<String, dynamic> languagesData = data['data'];

          // Convert to Map<String, Map<String, String>>
          final Map<String, Map<String, String>> result = {};

          languagesData.forEach((languageCode, strings) {
            if (strings is Map) {
              result[languageCode] = strings.map(
                (key, value) => MapEntry(key, value.toString()),
              );
            }
          });

          return result;
        }
      }

      throw Exception('Failed to load language strings from API');
    } catch (e) {
      if (kDebugMode) {
        print('Language API error: $e');
      }
      throw e;
    }
  }

  // New method to get available language codes
  Future<List<String>> getAvailableLanguageCodes() async {
    try {
      final languages = await fetchAllLanguageStrings();
      return languages.keys.toList();
    } catch (e) {
      // Fallback to default languages if API fails
      return ['en', 'my'];
    }
  }
}
