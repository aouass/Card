import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_card/User/CarteScannee.dart';
import 'package:scan_card/User/ContactUser.dart';

class AcceuilUser extends StatelessWidget {
  Uint8List? _imageBytes;
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

  final ImagePicker _picker = ImagePicker();
  Future<File?> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _imageBytes = await pickedImage.readAsBytes();

      _applyOCR(_imageBytes);

      return File(pickedImage.path);
    }
    return null;
  }

  Future<void> _applyOCR(dynamic image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    textRecognizer.close();
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
              String role = userData['role'] ?? 'Rôle inconnu';
              String nom = userData['nom'] ?? 'Nom inconnu';
              String prenom = userData['prenom'] ?? 'Prenom inconnu';

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 1),
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xFF21396A)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 90, right: 90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage('image/Ellipse.png'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Salut ,$prenom $nom ", //$nom  $prenom
                                      style: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //bloc du milieu
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
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),

                            //Image d'acceuil
                            Container(
                              height: 170,
                              width: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  image: AssetImage('image/Group.png'),
                                  fit: BoxFit.cover, // Ajustement de l'image
                                ),
                              ),
                            ),

                            SizedBox(height: 34),

                            Row(
                              children: [
                                Container(
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
                                        offset:
                                            Offset(0, 6), // changes position
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CarteScannee()),
                                          );
                                        },
                                        icon: Icon(Icons.document_scanner),
                                        color: Color(0xFFF9754E),
                                        iconSize: 30,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Scanner une ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "carte de visite",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 105,
                                      width: 154,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: Offset(
                                                0, 6), // changes position
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons
                                                .domain_verification_rounded),
                                            color: Color(0xFFF9754E),
                                            iconSize: 30,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            "Domaine",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 34),

                            Row(
                              children: [
                                Container(
                                  height: 130,
                                  width: 145,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset:
                                            Offset(0, 6), // changes position
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 80),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.category_outlined),
                                          color: Color(0xFFF9754E),
                                          iconSize: 40,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 60),
                                        child: Text(
                                          "Catégorie",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 145,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: Offset(
                                                0, 6), // changes position
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 80),
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ContactUser()),
                                                );
                                              },
                                              icon: Icon(
                                                  Icons.contact_page_outlined),
                                              color: Color(0xFFF9754E),
                                              iconSize: 40,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(right: 60),
                                            child: Text(
                                              "Contacts",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              );
            }));
  }
}

// const SizedBox(
//     height: 20,
//   ),

// Column(
//   children: [
//     Container(
//       height: 100,
//       width: 370,
//       decoration: BoxDecoration(
//         color: Color(0xFF000000).withOpacity(0.2),
//         borderRadius: BorderRadius.circular(20),
//       ),

//       // child: Row(
//       //   crossAxisAlignment: CrossAxisAlignment.center,
//       //   children: [
//       //     const SizedBox(
//       //       width: 15,
//       //     ),
//       //     // L'image à gauche
//       //     ClipRRect(
//       //       borderRadius: BorderRadius.circular(10),
//       //       child: Container(
//       //         width: 130, // Largeur de l'image
//       //         height: 60, // Hauteur de l'image
//       //         color: Colors.white, // Fond blanc
//       //       ),
//       //     ),
//       //     const SizedBox(
//       //         width:
//       //             20), // Espacement entre l'image et les textes
//       //     // Les textes
//       //     const Column(
//       //       crossAxisAlignment: CrossAxisAlignment.start,
//       //       children: [
//       //         SizedBox(
//       //           height: 30,
//       //         ),
//       //         Text(
//       //           'Profession',
//       //           style: TextStyle(
//       //             fontWeight: FontWeight.bold,
//       //             fontSize: 16,
//       //           ),
//       //         ),
//       //         Text(
//       //           'Email',
//       //           style: TextStyle(
//       //             fontWeight: FontWeight.normal,
//       //             fontSize: 14,
//       //           ),
//       //         ),
//       //       ],
//       //     ),
//       //     const SizedBox(
//       //       width: 70,
//       //     ),
//       //     // L'icône circulaire à droite
//       //     const CircleAvatar(
//       //       backgroundColor:
//       //           Colors.blueGrey, // Couleur de fond bleu-gris
//       //       radius: 20,
//       //       child: Icon(
//       //         Icons.more_horiz, // Icône "..." dans le cercle
//       //         color: Colors.white,
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     ),
//   ],
// ),
