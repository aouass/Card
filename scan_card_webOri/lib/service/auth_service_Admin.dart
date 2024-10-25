import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/Admin/Dashboard.dart';
import 'package:scan_card/Admin/LoginAdmin.dart';
import 'package:scan_card/Widgets/SideBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceAdmin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Inscription Admin
  Future<User?> signUpAdmin(
      String email, String password, String nom, String prenom) async {
    try {
      // Créer un nouvel utilisateur avec Firebase Authentication
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Récupérer l'ID de l'utilisateur créé
      String userId = result.user!.uid;

      // Ajouter l'utilisateur à Firestore
      await firebaseFirestore.collection("users").doc(userId).set({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'role': 'Admin',
      });

      print("Inscription réussie pour l'email: $email avec ID: $userId");
      return result.user;
    } catch (e) {
      print("Erreur lors de l'inscription: ${e.toString()}");
      return null;
    }
  }

  // Connexion Admin
  Future<User?> signInAdmin(
    String email, String password, BuildContext context) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = result.user;

    // Vérifier si l'utilisateur existe dans Firestore
    DocumentSnapshot userDoc =
        await firebaseFirestore.collection("users").doc(user?.uid).get();

    if (userDoc.exists) {
      String role = userDoc['role'];

      // Vérifier si l'utilisateur est bien un "Admin"
      if (role == 'Admin') {
        // Enregistrer l'état de connexion dans SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // Rediriger vers la page principale après la connexion
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Sidebar()),
        );
      } else {
        print("Ce compte n'a pas accès à cette application");
      }
    } else {
      print("Utilisateur non trouvé dans Firestore");
    }

    return user;
  } catch (e) {
    print("Erreur lors de la connexion: ${e.toString()}");
    return null;
  }
}

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
