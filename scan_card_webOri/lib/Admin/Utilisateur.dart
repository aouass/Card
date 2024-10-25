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
          const Padding(
            padding: EdgeInsets.only(left: 50, top: 25),
            child: Row(
              children: [
                Icon(
                  Icons.groups_outlined,
                  color: Color(0xFF7B809A),
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Utilisateur",
                    style: TextStyle(color: Color(0xFF7B809A), fontSize: 25),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height:20 ,),

          Container(
           
            height: 480,
            width:800,
            decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
            padding: const EdgeInsets.only(left: 70),
            child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Nom du client')),
                DataColumn(label: Text('Entreprise')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Téléphone')),
              ],
              rows: [
                _buildDataRow('Jane Cooper', 'Microsoft', 'jane@microsoft.com', true),
                _buildDataRow('Floyd Miles', 'Yahoo', 'floyd@yahoo.com', false),
                _buildDataRow('Ronald Richards', 'Adobe', 'ronald@adobe.com', false),
                _buildDataRow('Marvin McKinney', 'Tesla', 'marvin@tesla.com', true),
                _buildDataRow('Jerome Bell', 'Google', 'jerome@google.com', true),
                _buildDataRow('Kathryn Murphy', 'Microsoft', 'kathryn@microsoft.com', true),
                _buildDataRow('Jacob Jones', 'Yahoo', 'jacob@yahoo.com', true),
                _buildDataRow('Kristin Watson', 'Facebook', 'kristin@facebook.com', false),
              ],
            ),
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
