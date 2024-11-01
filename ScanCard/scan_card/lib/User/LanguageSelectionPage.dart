import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
void _changeLanguage(BuildContext context, Locale locale) async {
  // Met à jour la locale dans l'application
  S.load(locale);
  
  // Récupérer l'ID de l'utilisateur connecté
  String userId = FirebaseAuth.instance.currentUser!.uid;

  // Mettre à jour la langue dans Firestore pour l'utilisateur connecté
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({'language': locale.languageCode});

  Navigator.of(context).pop(); // Retourne à la page précédente
}

}
