import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class ListeCarteUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                width: 500,
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
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Text(
                        "Liste de Toutes Les Cartes",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // StreamBuilder pour récupérer les cartes scannées de l'utilisateur
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('CarteScannee')
                    .where('userId', isEqualTo: userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Aucune carte scannée trouvée"));
                  }

                  final cartesScannees = snapshot.data!.docs;

                  return Column(
                    children: cartesScannees.map((carte) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF21396A).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          width: 310,
                          height: 110,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      carte['profession'] ?? 'Profession',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFF9754E),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(carte['personnel'] ?? 'Personnel',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      carte['email'] ?? 'Email',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: const Color(0xFFF9754E),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _showOptionsBottomSheet(context, carte);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsBottomSheet(BuildContext context, DocumentSnapshot doc) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Options',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.blue),
                  title: const Text('Modifier'),
                  onTap: () {
                    Navigator.pop(context);
                    _showEditPopup(context, doc);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Supprimer'),
                  onTap: () {
                    _deleteItem(context, doc, doc);
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.picture_as_pdf, color: Colors.green),
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
          ),
        );
      },
    );
  }

  void _showEditPopup(BuildContext context, DocumentSnapshot doc) {
    final TextEditingController nomController =
        TextEditingController(text: doc['profession']);
        final TextEditingController prenomController =
        TextEditingController(text: doc['profession']);
    final TextEditingController professionController =
        TextEditingController(text: doc['profession']);
    final TextEditingController personnelController =
        TextEditingController(text: doc['personnel']);
    final TextEditingController emailController =
        TextEditingController(text: doc['email']);
    final TextEditingController entrepriseController =
        TextEditingController(text: doc['email']);
    final TextEditingController adresseController =
        TextEditingController(text: doc['email']);
   

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier la carte scannée'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nomController,
                  decoration: const InputDecoration(labelText: 'Profession'),
                ),
                TextField(
                  controller: prenomController,
                  decoration: const InputDecoration(labelText: 'Profession'),
                ),
                TextField(
                  controller: professionController,
                  decoration: const InputDecoration(labelText: 'Profession'),
                ),
                TextField(
                  controller: personnelController,
                  decoration: const InputDecoration(labelText: 'Personnel'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: entrepriseController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: adresseController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('CarteScannee')
                    .doc(doc.id)
                    .update({
                  'profession': professionController.text,
                  'personnel': personnelController.text,
                  'email': emailController.text,
                });
                Navigator.pop(context);
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(BuildContext context, DocumentSnapshot contactDoc, DocumentSnapshot carteScanneeDoc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: const Text('Êtes-vous sûr de vouloir supprimer ces éléments ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                if (contactDoc != null) {
                  await FirebaseFirestore.instance
                      .collection('contacts')
                      .doc(contactDoc.id)
                      .delete();
                }

                if (carteScanneeDoc != null) {
                  await FirebaseFirestore.instance
                      .collection('CarteScannee')
                      .doc(carteScanneeDoc.id)
                      .delete();
                }

                Navigator.of(context).pop();
              },
              child: const Text('Supprimer'),
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

    final bytes = await pdf.save();

    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/contact_export.pdf';
    final file = File(filePath);
    await file.writeAsBytes(bytes);

    final xFile = XFile(filePath);
    Share.shareXFiles([xFile], text: 'Contact en PDF');
  }

  void _exportAsCSV(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data != null) {
      final csvData =
          "Profession,Email\n${data['profession']},${data['email']}";

      Share.share(csvData, subject: 'Contact exporté en CSV');
    } else {
      print('Aucune donnée trouvée pour ce document.');
    }
  }
}
