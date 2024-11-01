import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_card/User/CarteScannee.dart';
import 'package:scan_card/User/CategorieUser.dart';
import 'package:scan_card/User/ContactUser.dart';
import 'package:scan_card/User/Domaine.dart';

class AcceuilUser extends StatefulWidget {
  @override
  _AcceuilUserState createState() => _AcceuilUserState();
}

class _AcceuilUserState extends State<AcceuilUser> {
  Uint8List? _imageBytes;
  File? _imageFile;
  String? _imageUrl; // Stocker l'URL de l'image

  Future<Map<String, dynamic>> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return {};
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)  // Utilisation de l'UID de l'utilisateur connecté
        .get();

    return userDoc.data() as Map<String, dynamic>;
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
      await _uploadImageToFirebase();
    }
  }

  Future<void> _uploadImageToFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && _imageFile != null) {
      String filePath = 'profile_images/${user.uid}.jpg';

      try {
        TaskSnapshot snapshot =
            await FirebaseStorage.instance.ref(filePath).putFile(_imageFile!);
        String downloadUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profileImageUrl': downloadUrl,
        });

        setState(() {
          _imageUrl = downloadUrl;
        });
      } catch (e) {
        print('Erreur lors de l\'upload de l\'image : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
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
              String nom = userData['nom'] ?? 'Nom inconnu';
              String prenom = userData['prenom'] ?? 'Prenom inconnu';
              String? profileImageUrl = userData['profileImageUrl'];

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 1),
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xFF21396A)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.only(left: 85, right: 80, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: pickImageFromGallery,
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: _imageUrl != null
                                      ? NetworkImage(_imageUrl!)
                                      : (profileImageUrl != null && profileImageUrl.isNotEmpty
                                          ? NetworkImage(profileImageUrl)
                                          : AssetImage('image/profil.jpg') as ImageProvider),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Text(
                                  "Salut, $prenom $nom",
                                  style: const TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        height: 200,
                        width: 500,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 12),
                                Container(
                                  height: 170,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                      image: AssetImage('image/Rectangle.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 34),
                                Row(
                                  children: [
                                    _buildActionButton(
                                      context,
                                      "Scanner votre carte de visite",
                                      Icons.document_scanner,
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => CarteScannee()),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 12),
                                    _buildActionButton(
                                      context,
                                      "Domaine",
                                      Icons.domain_verification_rounded,
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Domaine()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 34),
                                Row(
                                  children: [
                                    _buildActionButton(
                                      context,
                                      "Catégorie",
                                      Icons.category_outlined,
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => CategorieUser()),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 12),
                                    _buildActionButton(
                                      context,
                                      "Contacts",
                                      Icons.contact_page_outlined,
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ContactUser()),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  Widget _buildActionButton(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return Container(
      height: 105,
      width: 154,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
            color: Color(0xFFF9754E),
            iconSize: 30,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
