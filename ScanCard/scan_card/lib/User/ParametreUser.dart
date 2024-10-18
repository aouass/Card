import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_card/Service/auth_service_User.dart';

class ParametreUser extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// fonction pour envoyer un email de réinitialisation de mot de passe lorsque l'utilisateur clique sur le conteneur "Réinitialiser mot de passe".
  Future<void> _resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Afficher un message de succès (par exemple, un SnackBar)
      print("Email de réinitialisation envoyé");
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
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                String email = emailController.text.trim();
                if (email.isNotEmpty) {
                  _resetPassword(email);
                  Navigator.of(context).pop(); // Ferme le dialog après l'envoi
                } else {
                  // Gérer le cas où l'email est vide (facultatif)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Veuillez entrer un email valide")),
                  );
                }
              },
              child: const Text("Réinitialiser"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveContactsToPhone(BuildContext context) async {
    // Demander la permission d'accéder aux contacts
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      // Récupérer les contacts de Firestore
      QuerySnapshot snapshot = await _firestore.collection('contacts').get();
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        // Créer un contact
        Contact newContact = Contact(
          givenName: data['nom'], // Assurez-vous que ces clés existent
          familyName: data['prenom'],
          emails: [Item(label: "Email", value: data['email'])],
          phones: [Item(label: "mobile", value: data['personnel'])],
        );
        // Enregistrer le contact
        await ContactsService.addContact(newContact);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contacts sauvegardés avec succès")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Permission d'accès aux contacts refusée")),
      );
    }
  }

  void _confirmSaveContacts(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sauvegarder les contacts"),
          content: const Text(
              "Voulez-vous sauvegarder les contacts de Firestore dans votre téléphone ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
                _saveContactsToPhone(context);
              },
              child: const Text("Sauvegarder"),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Déconnexion"),
          content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
              },
              child: const Text("Non"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
                AuthService()
                    .signOut(context); // Appelle la méthode de déconnexion
              },
              child: const Text("Oui"),
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
                  //  Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
                  // );
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
