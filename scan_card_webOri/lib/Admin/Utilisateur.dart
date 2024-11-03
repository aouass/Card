import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utilisateur extends StatefulWidget {
  @override
  _UtilisateurState createState() => _UtilisateurState();
}

class _UtilisateurState extends State<Utilisateur> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xFFE6E9ED),
      
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.05, // Ajuste la marge gauche en fonction de la largeur de l'écran
                top: 25,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.groups_2,
                    color: Color(0xFF7B809A),
                    size: 40,
                  ),
                  const SizedBox(width: 20),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Utilisateurs",
                      style: TextStyle(color: Color(0xFF7B809A), fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                double containerWidth = constraints.maxWidth * 0.8;

                return SingleChildScrollView(
                  child: Container(
                    width: containerWidth > 800 ? 800 : containerWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('role', isEqualTo: 'utilisateur')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                  
                          List<DataRow> rows = snapshot.data!.docs.map((doc) {
                            var data = doc.data() as Map<String, dynamic>;
                            return _buildDataRow(
                              data['nom'] ?? 'Nom inconnu',
                              data['prenom'] ?? 'Prenom inconnu',
                              data['email'] ?? 'Email inconnu',
                              doc.id as String, // Passer l'ID du document pour la suppression
                            );
                          }).toList();
                  
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text('Nom du client')),
                                DataColumn(label: Text('Prenom du client')),
                                DataColumn(label: Text('Email')),
                                DataColumn(label: Text('Actions')),
                              ],
                              rows: rows,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      
    );
  }

  DataRow _buildDataRow(String name, String company, String email, String docId) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(company)),
        DataCell(Text(email)),
        DataCell(
          Container(
            height: 30,
            width: 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              
            ),
            child: Center( // Centrer l'icône dans le conteneur
            child: IconButton(
              onPressed: (){
                _showDeleteDialog(docId); // Afficher le dialogue de confirmation
              }, 
              icon: Icon( 
                Icons.delete,
                color: Colors.redAccent,
                size: 20,))
          ),
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmation de suppression"),
          content: Text("Êtes-vous sûr de vouloir supprimer cet utilisateur ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue
              },
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () async {
                await _deleteUser(docId); // Appeler la fonction de suppression
                Navigator.of(context).pop(); // Fermer le dialogue
              },
              child: Text("Supprimer"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteUser(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Utilisateur supprimé avec succès")),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la suppression de l'utilisateur")),
      );
    }
  }
}
