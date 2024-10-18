import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scan_card_web/Admin/Dashboard.dart';
import 'package:scan_card_web/Admin/LoginAdmin.dart';

class AuthServiceAdmin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Inscription Admin
  Future<User?> signUpAdmin(
      String email, String password, String nom, String prenom) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await firebaseFirestore.collection("users").doc(result.user?.uid).set({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'role': 'Admin',
      });
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Connexion Admin
  Future<User?> signInAdmin(
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

        // Vérifier si l'utilisateur est bien un "Admin"
        if (role == 'Admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
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

  // Acceuil Admin
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

  // Déconnexion Admin
  Future<void> signOutAdmin(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginAdmin()),
    );
  }

  // Vérifier l'état de connexion de l'utilisateur
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}
