import 'package:flutter/material.dart';
import 'package:m9_news/services/language_service.dart';
import 'package:http/http.dart' as http;
import 'package:m9_news/utils/language_manager.dart';

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

  Widget _getLanguageFlag(String languageCode) {
    final flagEmoji = {'en': '🇺🇸', 'my': '🇲🇲'}[languageCode] ?? '🌐';

    return Text(flagEmoji, style: const TextStyle(fontSize: 24));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Language'),
      content: SizedBox(
        width: double.maxFinite,
        child: FutureBuilder<List<String>>(
          future: _availableLanguagesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No languages available',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            final availableLanguages = snapshot.data!;

            return ListView(
              shrinkWrap: true,
              children: availableLanguages.map((languageCode) {
                return ListTile(
                  leading: _getLanguageFlag(languageCode),
                  title: FutureBuilder<String>(
                    future: LanguageManager.getLanguageName(
                      languageCode,
                      context,
                    ),
                    builder: (context, nameSnapshot) {
                      if (nameSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Text(languageCode.toUpperCase());
                      }
                      return Text(
                        nameSnapshot.data ?? languageCode.toUpperCase(),
                      );
                    },
                  ),
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
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
