import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class ListeCarteUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

              // StreamBuilder pour récupérer les contacts
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('contacts')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Aucun contact trouvé"));
                  }

                  final contacts = snapshot.data!.docs;

                  return Column(
                    children: contacts.map((contact) {
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
                              // Image à gauche
                              Container(
                                width: 110,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 20),
                              // Texte au milieu
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      contact['profession'] ?? 'Profession',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      contact['email'] ?? 'Email',
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
                                backgroundColor: const Color(0xFFF9754E),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _showOptionsBottomSheet(context, contact);
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

              const SizedBox(height: 40),

              // StreamBuilder pour récupérer les cartes scannées
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('cartes_scannees')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("Aucune carte scannée trouvée"));
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
                              // Image à gauche
                              Container(
                                width: 110,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 20),
                              // Texte au milieu
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      carte['titre'] ?? 'Titre',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      carte['description'] ?? 'Description',
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
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 220,
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
                  _deleteItem(doc);
                  Navigator.pop(context);
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
              // ListTile(
              //   leading: const Icon(Icons.file_copy, color: Colors.orange),
              //   title: const Text('Exporter en CSV'),
              //   onTap: () {
              //     _exportAsCSV(doc);
              //     Navigator.pop(context);
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  void _deleteItem(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('contacts').doc(doc.id).delete();
    // Même chose pour 'cartes_scannees'
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

  // void _exportAsCSV(DocumentSnapshot doc) {
  //   // Exporter les données sous forme de CSV
  //   final data = doc.data();
  //   final csvData = "Profession,Email\n${data?['profession']},${data?['email']}";
  //   // Partager ou sauvegarder le fichier CSV
  //   Share.share(csvData, subject: 'Contact exporté en CSV');
  // }
}
