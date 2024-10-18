import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scan_card/User/AcceuilUser.dart';
import 'package:scan_card/User/ListeCarteUser.dart';
import 'package:scan_card/User/ParametreUser.dart';
import 'package:scan_card/User/ProfileUser.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  // Index pour suivre l'onglet actif
  int _selectedIndex = 0;

  // Rôle de l'utilisateur

  // Liste des pages par rôle

  final List<Widget> UtilisateurPages = [
    AcceuilUser(), // Page d'accueil Utilisateur
    ProfileUser(),
    ListeCarteUser(),
    ParametreUser(),
  ];

  @override
  void initState() {
    super.initState();
    _getUser(); // Appel pour récupérer le rôle de l'utilisateur
  }

  // Fonction pour récupérer le rôle de l'utilisateur connecté depuis Firebase
  Future<void> _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(
              'users') // Assurez-vous que votre collection d'utilisateurs s'appelle 'Users'
          .doc(user.uid)
          .get();
    }
  }

  // Méthode pour gérer le changement d'onglet
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index; // Met à jour l'index de l'onglet actif
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> selectedPages;

    // Sélectionner les pages en fonction du rôle de l'utilisateur

    {
      selectedPages = UtilisateurPages;
    }

    return Scaffold(
      // Affiche la page correspondant à l'onglet actif
      body: selectedPages[_selectedIndex],

      // Barre de navigation en bas
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 2), // changes position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
          child: GNav(
            color: const Color(0xFFC4C4C4), // Couleur des icônes inactives
            activeColor: const Color(0xFFFFFFFF), // Couleur des icônes actives
            tabBackgroundColor:
                const Color(0xFFF9754E), // Couleur de fond de l'onglet actif
            padding: const EdgeInsets.all(16), // Padding autour des icônes
            gap: 8, // Espace entre les icônes et les labels
            onTabChange:
                _onTabChange, // Fonction appelée lorsque l'utilisateur change d'onglet
            tabs: const [
              GButton(
                icon: Icons.home_filled, // Icône pour Formateur
                text: 'Acceuil',
              ),
              GButton(
                icon: Icons.person, // Icône des notifications
                text: 'Profile',
              ),
              GButton(
                icon: Icons.credit_card, // Icône des messages
                text: 'Liste',
              ),
              GButton(
                icon: Icons.settings_suggest_outlined, // Icône des tickets
                text: 'Parametre',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
