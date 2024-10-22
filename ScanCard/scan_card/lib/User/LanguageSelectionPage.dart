import 'package:flutter/material.dart';
import 'package:scan_card/generated/l10n.dart'; // Import des traductions

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).choose_language), // Titre traduit
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text('Français'),
            onTap: () {
              _changeLanguage(context, const Locale('fr'));
            },
          ),
          ListTile(
            title: Text('English'),
            onTap: () {
              _changeLanguage(context, const Locale('en'));
            },
          ),
        ],
      ),
    );
  }

  void _changeLanguage(BuildContext context, Locale locale) {
    // Met à jour la locale dans l'application
    S.load(locale);
    Navigator.of(context).pop(); // Retourne à la page précédente
  }
}
