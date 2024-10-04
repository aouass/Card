import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/User/Login.dart';
import 'package:scan_card/User/navigation_bar.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // Déclaration des contrôleurs pour les champs de texte
  // final TextEditingController Nom = TextEditingController();
  // final TextEditingController Prenom = TextEditingController();
  // final TextEditingController Email = TextEditingController();
  // final TextEditingController Mdp = TextEditingController();

  // Inscription utilisateur
  Future<User?> signUp(
      String email, String password, String nom, String prenom) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await firebaseFirestore.collection("users").doc(result.user?.uid).set({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'role': 'utilisateur',
      });
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Connexion utilisateur
  Future<User?> signIn(
      String email, String password, BuildContext context) async {
    try {
      // Connexion avec Firebase Authentication
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      // Récupérer le document de l'utilisateur dans Firestore
      DocumentSnapshot userDoc =
          await firebaseFirestore.collection("users").doc(user?.uid).get();

      if (userDoc.exists) {
        String role = userDoc['role'];

        // Vérifier si l'utilisateur est bien un "utilisateur"
        if (role == 'utilisateur') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyNavigationBar()),
          );
        } else {
          print("Ce compte n'a pas accès à cette application");
        }
      } else {
        print("utilisateur non trouvé");
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Acceuil utilisateur
  Future<Map<String, dynamic>> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return {};
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    return userDoc.data() as Map<String, dynamic>;
  }

  // // Déconnexion utilisateur
  // Future<void> _logout(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => Login()),
  //   );
  // }

  // Déconnexion utilisateur
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  // Vérifier l'état de connexion de l'utilisateur
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}