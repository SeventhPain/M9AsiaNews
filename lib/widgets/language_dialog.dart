import 'package:flutter/material.dart';
import 'package:m9_news/l10n/app_localization.dart';

class LanguageDialog extends StatelessWidget {
  final String currentLanguage;

  const LanguageDialog({Key? key, required this.currentLanguage})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(localizations?.selectLanguage ?? 'Select Language'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildLanguageTile(
              context,
              'my',
              localizations?.myanmar ?? 'Myanmar',
            ),
            _buildLanguageTile(
              context,
              'en',
              localizations?.english ?? 'English',
            ),
          ],
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

  Widget _buildLanguageTile(
    BuildContext context,
    String languageCode,
    String languageName,
  ) {
    return ListTile(
      leading: _getLanguageFlag(languageCode),
      title: Text(languageName),
      trailing: currentLanguage == languageCode
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        Navigator.of(context).pop(languageCode);
      },
    );
  }

  Widget _getLanguageFlag(String languageCode) {
    final flagEmoji = {'en': '🇺🇸', 'my': '🇲🇲'}[languageCode] ?? '🌐';

    return Text(flagEmoji, style: const TextStyle(fontSize: 24));
  }
}
