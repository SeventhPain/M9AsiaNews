import 'package:flutter/material.dart';
import 'package:m9_news/l10n/app_localization.dart';
import 'package:m9_news/services/language_service.dart';
import 'package:http/http.dart' as http;

class LanguageDialog extends StatefulWidget {
  final String currentLanguage;

  const LanguageDialog({Key? key, required this.currentLanguage})
    : super(key: key);

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  late Future<List<String>> _availableLanguagesFuture;
  final LanguageService _languageService = LanguageService(
    client: http.Client(),
  );

  @override
  void initState() {
    super.initState();
    _availableLanguagesFuture = _languageService.getAvailableLanguageCodes();
  }

  String _getLanguageName(String languageCode, BuildContext context) {
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

  Widget _getLanguageFlag(String languageCode) {
    final flagEmoji = {'en': '🇺🇸', 'my': '🇲🇲'}[languageCode] ?? '🌐';

    return Text(flagEmoji, style: const TextStyle(fontSize: 24));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(localizations?.selectLanguage ?? 'Select Language'),
      content: SizedBox(
        width: double.maxFinite,
        child: FutureBuilder<List<String>>(
          future: _availableLanguagesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Failed to load languages',
                  style: TextStyle(color: Colors.red[700]),
                ),
              );
            }

            final availableLanguages = snapshot.data ?? ['en', 'my'];

            return ListView(
              shrinkWrap: true,
              children: availableLanguages.map((languageCode) {
                return ListTile(
                  leading: _getLanguageFlag(languageCode),
                  title: Text(_getLanguageName(languageCode, context)),
                  trailing: widget.currentLanguage == languageCode
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    Navigator.of(context).pop(languageCode);
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localizations?.cancel ?? 'Cancel'),
        ),
      ],
    );
  }
}
