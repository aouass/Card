import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:scan_card/User/ContactCarte.dart';
import 'package:scan_card/User/navigation_bar.dart';
import 'package:share_plus/share_plus.dart';

class ContactUser extends StatefulWidget {
  @override
  _ContactUserState createState() => _ContactUserState();
}

class _ContactUserState extends State<ContactUser> {
  String searchQuery = "";
  Stream<QuerySnapshot>? contactStream;

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

  @override
  void initState() {
    super.initState();
    // Initialiser le stream des contacts
    contactStream =
        FirebaseFirestore.instance.collection('contacts').snapshots();
  }

  // Fonction pour rechercher les contacts
  void searchContacts(String query) {
    setState(() {
      searchQuery = query;
      if (query.isNotEmpty) {
        contactStream = FirebaseFirestore.instance
            .collection('contacts')
            .where('categorie', isGreaterThanOrEqualTo: query)
            .where('categorie', isLessThanOrEqualTo: query + '\uf8ff')
            .snapshots();
      } else {
        contactStream =
            FirebaseFirestore.instance.collection('contacts').snapshots();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 85, right: 80, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage('image/profil.jpg'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Salut , $prenom $nom",
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Bloc du milieu
                    Expanded(
                      child: Container(
                        height: 200,
                        width: 500,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyNavigationBar()),
                                          );
                                        },
                                        icon: Icon(
                                            Icons.arrow_back_ios_new_rounded),
                                        iconSize: 30,
                                        color: Color(0xFFF9754E),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          onChanged: (value) =>
                                              searchContacts(value),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 1, right: 1),
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            hintText: "Recherche Contact",
                                            hintStyle: const TextStyle(
                                                color: Color(0xFF000000)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF2C2C2C)),
                                            ),
                                            filled: true,
                                            fillColor: const Color.fromARGB(
                                                243, 243, 243, 243),
                                          ),
                                        ),
                                      ),
                                   
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      const Text("Créer un contact",
                                          style: TextStyle(fontSize: 14)),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ContactCarte()),
                                          );
                                        },
                                        icon: const Icon(
                                            Icons.add_circle_rounded,
                                            color: Color(0xFFF9754E),
                                            size: 40),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 34),
                              Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: contactStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return const Center(
                                          child: Text("Aucun contact trouvé"));
                                    }

                                    final contacts = snapshot.data!.docs;

                                    return ListView.builder(
                                      itemCount: contacts.length,
                                      itemBuilder: (context, index) {
                                        var contact = contacts[index];
                                        return Center(
                                          child: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF21396A)
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                            ),
                                            width: 310,
                                            height: 110,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        contact['profession'] ??
                                                            'Profession',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFFF9754E),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        contact['personnel'] ??
                                                            'Personnel',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        contact['email'] ??
                                                            'Email',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Bouton circulaire à droite pour afficher le popup
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      const Color(0xFFF9754E),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.more_horiz,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      _showOptionsBottomSheet(
                                                          context, contact);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void _showOptionsBottomSheet(BuildContext context, DocumentSnapshot doc) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          height: 310,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Modifier'),
                onTap: () {
                  // Appeler la logique de modification ici
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Supprimer'),
                onTap: () {
                  _deleteItem(context,
                      doc); // Appel de la fonction avec le contexte et le document
                },
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Colors.green),
                title: const Text('Exporter en PDF'),
                onTap: () {
                  _exportAsPDF(doc);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_copy, color: Colors.orange),
                title: const Text('Exporter en CSV'),
                onTap: () {
                  _exportAsCSV(doc);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteItem(BuildContext context, DocumentSnapshot doc) {
    // Afficher une boîte de dialogue de confirmation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmer la suppression'),
          content: Text('Êtes-vous sûr de vouloir supprimer cet élément ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Supprimer l'élément si l'utilisateur confirme
                FirebaseFirestore.instance
                    .collection('contacts')
                    .doc(doc.id)
                    .delete();
                // Vous pouvez également supprimer de 'cartes_scannees' ici
                Navigator.of(context)
                    .pop(); // Fermer la boîte de dialogue après la suppression
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  void _exportAsPDF(DocumentSnapshot doc) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Données exportées: ${doc.data()}"),
          );
        },
      ),
    );

    // Sauvegarder le fichier PDF
    final bytes = await pdf.save();

    // Créer un fichier temporaire pour stocker le PDF
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/contact_export.pdf';
    final file = File(filePath);
    await file.writeAsBytes(bytes);

    // Partager le fichier PDF avec XFile
    final xFile = XFile(filePath);
    Share.shareXFiles([xFile], text: 'Contact en PDF');
  }

  void _exportAsCSV(DocumentSnapshot doc) {
    // Exporter les données sous forme de CSV
    final data = doc.data() as Map<String, dynamic>?; // Cast au bon type
    if (data != null) {
      final csvData =
          "Profession,Email\n${data['profession']},${data['email']}";

      // Partager ou sauvegarder le fichier CSV
      Share.share(csvData, subject: 'Contact exporté en CSV');
    } else {
      print('Aucune donnée trouvée pour ce document.');
    }
  }
}
