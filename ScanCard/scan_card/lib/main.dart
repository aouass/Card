import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scan_card/User/LanguageSelectionPage.dart';
import 'package:scan_card/User/SplashScreen1.dart';
import 'generated/l10n.dart'; // Le fichier généré pour la gestion des langues
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialisation nécessaire avant Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en'); // Par défaut, anglais

  // Fonction pour changer la langue
  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale, // La langue actuelle
      supportedLocales: [
        const Locale('en', ''), // Anglais
        const Locale('fr', ''), // Français
      ],
      localizationsDelegates: [
        AppLocalizations.delegate, // Gestion des textes localisés
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: LanguageSelectionPage(onLocaleChange: _changeLanguage), // On passe la fonction de changement de langue
    );
  }
}
