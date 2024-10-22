import 'package:flutter/material.dart';

// class AdminService {
//   final CollectionReference userCollection =
//       FirebaseFirestore.instance.collection('users');

//   // Récupérer tous les utilisateurs
//   Stream<List<Map<String, dynamic>>> getAllUsers() {
//     return userCollection.snapshots().map((snapshot) => snapshot.docs
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .toList());
//   }

//   // Supprimer un utilisateur
//   Future<void> deleteUser(String userId) async {
//     return await userCollection.doc(userId).delete();
//   }

//   // Supprimer une carte
//   Future<void> deleteCard(String cardId) async {
//     return await FirebaseFirestore.instance
//         .collection('cards')
//         .doc(cardId)
//         .delete();
//   }
// }

class ParametreAdmin extends StatefulWidget {
  @override
  _ParametreAdminState createState() => _ParametreAdminState();
}

class _ParametreAdminState extends State<ParametreAdmin> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0xFFE6E9ED),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 15),
            child: Row(
              children: [
                Icon(
                  Icons.settings_suggest,
                  color: Color(0xFF7B809A),
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Parametres",
                    style: TextStyle(color: Color(0xFF7B809A), fontSize: 25),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: 940,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    height: 150,
                    width: 850,
                    decoration: BoxDecoration(
                        color: Color(0xFF21396A),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.groups,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              width: 150,
                            ),
                            const Text(
                              "Comptes Utilisateurs",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 150,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 40,
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.cached_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              width: 150,
                            ),
                            const Text(
                              "Renitialiser mot de passe",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 110,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 40,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 270,
            width: 800,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 90),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Nom du client')),
                    DataColumn(label: Text('Entreprise')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Statut')),
                  ],
                  rows: [
                    _buildDataRow(
                        'Jane Cooper', 'Microsoft', 'jane@microsoft.com', true),
                    _buildDataRow(
                        'Floyd Miles', 'Yahoo', 'floyd@yahoo.com', false),
                    _buildDataRow(
                        'Ronald Richards', 'Adobe', 'ronald@adobe.com', false),
                    _buildDataRow(
                        'Marvin McKinney', 'Tesla', 'marvin@tesla.com', true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
      String name, String company, String email, bool isActive) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(company)),
        DataCell(Text(email)),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? Colors.green[100] : Colors.red[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isActive ? 'Active' : 'Inactive',
              style: TextStyle(
                color: isActive ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
