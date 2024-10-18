import 'package:flutter/material.dart';

class ProfileAdmin extends StatefulWidget {
  @override
  _ProfileAdminState createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  Widget build(BuildContext context) {
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
                height: 130,
                width: 1000,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('Images/Background.png'),
                    fit: BoxFit.cover, // Ajustement de l'image
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 500,
                color: Color(0xFFFFFFFF),
                // decoration: BoxDecoration(),
              )
            ],
          )
        ],
      ),
    );
  }
}
