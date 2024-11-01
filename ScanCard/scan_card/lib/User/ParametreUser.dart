import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_contacts/properties/email.dart';
import 'package:flutter_contacts/properties/phone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_card/Service/auth_service_User.dart';
import 'package:scan_card/User/LanguageSelectionPage.dart';
import 'package:scan_card/generated/l10n.dart';

class ParametreUser extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// fonction pour envoyer un email de réinitialisation de mot de passe lorsque l'utilisateur clique sur le conteneur "Réinitialiser mot de passe".
  Future<void> _resetPasswordForCurrentUser() async {
  try {
    // Récupérer l'utilisateur actuellement connecté
    final user = _auth.currentUser;
    if (user != null && user.email != null) {
      // Envoyer l'email de réinitialisation au compte connecté
      await _auth.sendPasswordResetEmail(email: user.email!);
      // Afficher un message de succès (par exemple, un SnackBar)
      print("Email de réinitialisation envoyé à ${user.email}");
    } else {
      print("Aucun utilisateur connecté ou adresse e-mail manquante");
    }
  } catch (e) {
    // Gérer les erreurs ici
    print("Erreur lors de l'envoi de l'email de réinitialisation : $e");
  }
}


  void _showEmailDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Réinitialiser le mot de passe"),
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: "Entrez votre adresse email",
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Ferme le dialog
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                String email = emailController.text.trim();
                if (email.isNotEmpty) {
                  _resetPasswordForCurrentUser();
                  Navigator.of(context).pop(); // Ferme le dialog après l'envoi
                } else {
                  // Gérer le cas où l'email est vide (facultatif)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Veuillez entrer un email valide")),
                  );
                }
              },
              child: Text(S.of(context).reset),
            ),
          ],
        );
      },
    );
  }

  
Future<void> _saveContactsToPhone(BuildContext context) async {
  // Obtenez l'utilisateur connecté
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Utilisateur non connecté")),
    );
    return;
  }

  // Demander la permission d'accéder aux contacts
  var status = await Permission.contacts.request();
  if (status.isGranted) {
    try {
      // Récupérer les contacts de l'utilisateur connecté dans Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('userId', isEqualTo: currentUser.uid)
          .get();

      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        // Vérifiez si les champs requis sont présents
        if (data.containsKey('nom') && data.containsKey('prenom') && data.containsKey('email') && data.containsKey('personnel')) {
          // Créer un contact
          Contact newContact = Contact()
            ..name.first = data['nom']
            ..name.last = data['prenom']
            ..emails = [Email(data['email'], label: EmailLabel.home)]
            ..phones = [Phone(data['personnel'], label: PhoneLabel.mobile)];

          // Enregistrer le contact
          await FlutterContacts.insertContact(newContact);
        } else {
          // Log ou gestion de l'absence de certaines données
          print("Les champs requis sont manquants pour ce contact.");
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contacts sauvegardés avec succès")),
      );
    } catch (e) {
      // Gérer les erreurs éventuelles
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la sauvegarde des contacts : $e")),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Permission d'accès aux contacts refusée")),
    );
  }
}



  void _confirmSaveContacts(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).contactSave),
          content: const Text(
              "Voulez-vous sauvegarder les contacts  dans votre téléphone ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
                _saveContactsToPhone(context);
              },
              child: Text(S.of(context).save),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) async {
  // Vérifie si l'utilisateur est connecté
  final user = AuthService().currentUser;
  if (user == null) {
    // Si aucun utilisateur n'est connecté, ne pas afficher le dialogue
    return;
  }

  // Si un utilisateur est connecté, affiche la boîte de dialogue
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Déconnexion"),
        content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le dialogue
            },
            child: Text(S.of(context).no),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le dialogue
              AuthService().signOut(context); // Appelle la méthode de déconnexion
            },
            child: Text(S.of(context).yes),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 60,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 6), // changes position
                      ),
                    ],
                  ),
                  child: Row(children: [
                    Image.asset(
                      'image/Logo_ScanCard.png',
                      width: 85,
                      height: 85,
                    ),
                    const SizedBox(
                      width: 200,
                    ),
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('image/Ellipse.png'),
                    ),
                  ])),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LanguageSelectionPage()),
                  );
                },
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF21396A),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 6), // changes position
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.language_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      Text(
                        "Langues",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  _showEmailDialog(
                      context); // Ouvre le dialog pour entrer l'email
                },
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF21396A),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 6), // changes position
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.cached_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "Rénitialiser mot de passe",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  _confirmSaveContacts(context);
                },
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF21396A),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 6), // changes position
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.backup_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Sauvegarde automatique",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "des contacts",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  _showLogoutConfirmationDialog(context);
                },
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF21396A),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 6), // changes position
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.settings_power_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        "Deconnexion",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
