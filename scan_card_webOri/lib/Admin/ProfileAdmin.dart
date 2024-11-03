import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileAdmin extends StatefulWidget {
  @override
  _ProfileAdminState createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? user;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user!.uid).get();

      setState(() {
        _firstNameController.text = userData['prenom'] ?? '';
        _lastNameController.text = userData['nom'] ?? '';
        _emailController.text = userData['email'] ?? '';
      });
    }
  }

  Future<void> _updateProfile() async {
    if (user != null) {
      await _firestore.collection('users').doc(user!.uid).update({
        'pronom': _firstNameController.text,
        'nom': _lastNameController.text,
        'email': _emailController.text,
      });

      // Optionally update the email in FirebaseAuth
      if (_emailController.text != user!.email) {
        await user!.updateEmail(_emailController.text);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return Container(
      color: Color(0xFFE6E9ED),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 25),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Color(0xFF7B809A),
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Profile",
                    style: TextStyle(color: Color(0xFF7B809A), fontSize: 25),
                  ),
                )
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                height: size.height * 0.3,
                width: 900,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('Images/Background.png'),
                    fit: BoxFit.cover, // Ajustement de l'image
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 140),
                child: Container(
                  height: 65,
                  width: 930,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.only(right: 820),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                              "Images/Ellipse.png",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              _emailController.text,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black), // Style de texte en noir (ajustable)
                            ),
                          ),
                        ],
                      )),
                ),
              ),

              // Container(
              //   color: Colors.white,

              // )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 250,
            width: 900,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                const Text("Profile Information"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Bonjour, Décisions : si vous n'arrivez pas à décider, la réponse est non. S’il s’agit de deux chemins également difficiles, choisissez celui qui est le plus douloureux à court terme (éviter la douleur crée une illusion d’égalité).",
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        labelText: 'Nom ',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        labelText: 'Prenom ',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        labelText: 'Email ',
                        prefixIcon: const Icon(Icons.mail_outline),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF183E62),
                      maximumSize: Size(200, 50)),
                  child: const Text('Modifier Profile',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
