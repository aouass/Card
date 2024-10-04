import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/User/SplashScreen1.dart'; // Assurez-vous que cela correspond à votre structure de projet
// import 'firebase_options.dart';
// import 'generated/l10n.dart'; 
class LanguageSelectionPage extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  LanguageSelectionPage({required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                onLocaleChange(Locale('fr')); // Changer vers le français
              },
              child: Text('Français'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onLocaleChange(Locale('en')); // Changer vers l'anglais
              },
              child: Text('English'),
            ),
          ],
        ),
      ),
    );
  }
}