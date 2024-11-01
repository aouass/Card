import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utilisateur extends StatefulWidget {
  @override
  _UtilisateurState createState() => _UtilisateurState();
}

class _UtilisateurState extends State<Utilisateur> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0xFFE6E9ED),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 25),
            child: Row(
              children: [
                const Icon(
                  Icons.groups_2,
                  color: Color(0xFF7B809A),
                  size: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Utilisateurs",
                    style: TextStyle(color: Color(0xFF7B809A), fontSize: 25),
                  ),
                ),

                const SizedBox(
            height: 20,
          ),

          
                 
              ],
            ),
          ),

           Container(
              width: 800,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 70),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<DataRow> rows = snapshot.data!.docs.map((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      return _buildDataRow(
                        data['nom'] ?? 'Nom inconnu',
                        data['prenom'] ?? 'Prenon inconnue',
                        data['email'] ?? 'Email inconnu',
                        data['isActive'] ?? false,
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
        ],
      ),
      
    );
  }

  DataRow _buildDataRow(String name, String company, String email, bool isActive) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(company)),
        DataCell(Text(email)),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
