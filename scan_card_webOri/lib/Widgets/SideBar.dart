import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/Admin/Dashboard.dart';
import 'package:scan_card/Admin/ParametreAdmin.dart';
import 'package:scan_card/Admin/ProfileAdmin.dart';
import 'package:scan_card/Admin/Utilisateur.dart';
import 'package:scan_card/Constante/Color.dart';
import 'package:scan_card/service/auth_service_Admin.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int indexSelect = 0;

  final List<Widget> pages = [
    DashboardPage(),
    ProfileAdmin(),
    Utilisateur(),
    ParametreAdmin(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Navig(
              indexSelect: indexSelect,
              onItemSelected: (index) {
                setState(() {
                  indexSelect = index; // Mettre à jour la sélection
                });
              },
            ),
          ),
          Expanded(
              flex: 7,
              child: IndexedStack(
                index: indexSelect,
                children: pages,
              )),
        ],
      ),
    );
  }
}

class Navig extends StatelessWidget {
  // Fonction pour afficher le popup de confirmation
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Voulez-vous vraiment vous déconnecter ?"),
          actions: [
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le popup
              },
            ),
            TextButton(
              child: const Text("Confirmer"),
              onPressed: () async {
                Navigator.of(context).pop(); // Fermer le popup
                AuthServiceAdmin().signOutAdmin(context);
                (); // Appel de la fonction de déconnexion
                // Rediriger vers la page de connexion
              },
            ),
          ],
        );
      },
    );
  }

  final int indexSelect;
  final ValueChanged<int> onItemSelected;

  Future<Map<String, dynamic>> _getUserData() async {
    File? _imageFile;
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

  const Navig({
    super.key,
    required this.indexSelect,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune information utilisateur.'));
          }

          var userData = snapshot.data!;
          String role = userData['role'] ?? 'Rôle inconnu';
          String nom = userData['nom'] ?? 'Nom inconnu';
          String prenom = userData['prenom'] ?? 'Prenom inconnu';

          return Container(
            width: MediaQuery.of(context).size.width * 0.5,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topCenter, // Début du gradient (en haut)
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF3E3D45)
                      .withOpacity(0.5), // Couleur avec opacité
                  const Color(0xFF202020)
                      .withOpacity(0.5), // Couleur avec opacité
                ],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Image.asset(
                        'Images/Logo_ScanCard.png',
                        height: 200,
                        width: 200,
                      ),
                    )),
                Container(
                  width: 250,
                  height: 1,
                  color: Colors.white,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('Images/Ellipse.png'),
                        ),
                        SizedBox(width: 10),
                        Text(
                          " $prenom $nom",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 1,
                  color: Colors.white,
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child:
                          ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  onItemSelected(index); // Gérer la sélection
                                },
                                child: SideScroll(
                                  index: index,
                                  cone: _getIcon(
                                      index), // Icône spécifique pour chaque item
                                  texte: _getText(
                                      index), // Texte spécifique pour chaque item
                                  isSelected: indexSelect == index,
                                ),
                              );
                            },
                          )

                        
                      
                    ),
                    
                  ),
                  
                ),

                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        _showLogoutConfirmationDialog(context);
                      },
                      child: Container(
                        width: 250,
                        height: 45,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter, // Début du gradient (en haut)
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF3E3D45)
                                  .withOpacity(0.5), // Couleur avec opacité
                              const Color(0xFF202020)
                                  .withOpacity(0.5), // Couleur avec opacité
                            ],
                          ),
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
                              width: 50,
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
                  ),)
                
              ],
            ),
          );
        });
  }

  Icon _getIcon(int index) {
    switch (index) {
      case 0:
        return const Icon(
          Icons.dashboard,
          color: Colors.white,
        );
      case 1:
        return const Icon(Icons.person, color: Colors.white);
      case 2:
        return const Icon(Icons.people, color: Colors.white);
      default:
        return const Icon(Icons.settings, color: Colors.white);
    }
  }

  String _getText(int index) {
    switch (index) {
      case 0:
        return "Dashboard";
      case 1:
        return "Profile";
      case 2:
        return "Utilisateurs";
      default:
        return "Parametres";
    }
  }

  Widget SideScroll({
    required int index,
    required Icon cone,
    required String texte,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? colorPrimaime : colorSecondaire,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          cone,
          const SizedBox(width: 10),
          Text(
            texte,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
