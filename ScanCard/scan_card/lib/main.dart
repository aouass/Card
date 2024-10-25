import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/User/SplashScreen1.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';  // Chemin vers le fichier généré
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Assure-toi que firebase_options.dart est bien configuré
  );
  runApp(


    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // Définir les délégués pour les localisations
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Définir les langues supportées
      supportedLocales: [
        const Locale('en', 'US'), // anglais
        const Locale('fr', 'FR'), // français
        // Ajoute d'autres langues ici
      ],

      locale: Locale('fr'), // Langue par défaut
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
