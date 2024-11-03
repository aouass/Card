import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class AdminService {
//   final CollectionReference userCollection =
//       FirebaseFirestore.instance.collection('users');

//   // Récupérer tous les utilisateurs
//   Stream<List<Map<String, dynamic>>> getAllUsers() {
//     return userCollection.snapshots().map((snapshot) => snapshot.docs
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .toList());
//   }

//   // Supprimer un utilisateur
//   Future<void> deleteUser(String userId) async {
//     return await userCollection.doc(userId).delete();
//   }

//   // Supprimer une carte
//   Future<void> deleteCard(String cardId) async {
//     return await FirebaseFirestore.instance
//         .collection('cards')
//         .doc(cardId)
//         .delete();
//   }
// }

class ParametreAdmin extends StatefulWidget {
  @override
  _ParametreAdminState createState() => _ParametreAdminState();
}

class _ParametreAdminState extends State<ParametreAdmin> {

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
    return Dialog(
      child: Container(
        height: 250,
        width: 500, // Largeur souhaitée de la boîte de dialogue
        padding: EdgeInsets.all(16), // Espace intérieur pour aérer le contenu
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Réinitialiser le mot de passe",
              style: TextStyle(
                fontSize: 20, // Taille de texte augmentée pour le titre
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Entrez votre adresse email",
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Annuler",style: TextStyle(color: Colors.black,fontSize: 15),),
                ),
                TextButton(
                  onPressed: () {
                    String email = emailController.text.trim();
                    if (email.isNotEmpty) {
                      _resetPassword(email);
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Veuillez entrer un email valide"),
                        ),
                      );
                    }
                  },
                  child: Text("Réinitialiser",style: TextStyle(color: Colors.black,fontSize: 15),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0xFFE6E9ED),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 15),
            child: Row(
              children: [
                Icon(
                  Icons.settings_suggest,
                  color: Color(0xFF7B809A),
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Parametres",
                    style: TextStyle(color: Color(0xFF7B809A), fontSize: 25),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: 940,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    height: 150,
                    width: 850,
                    decoration: BoxDecoration(
                        color: Color(0xFF21396A),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.cached_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              width: 150,
                            ),
                            const Text(
                              "Renitialiser mot de passe",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 110,
                            ),
                            IconButton(
                                onPressed: () {
                                   _showEmailDialog(context); // Ouvre le dialog pour entrer l'email;
                                },
                                icon: Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 40,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
