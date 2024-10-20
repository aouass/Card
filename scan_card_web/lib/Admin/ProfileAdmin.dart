import 'package:flutter/material.dart';

class ProfileAdmin extends StatefulWidget {
  @override
  _ProfileAdminState createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                height: size.height*0.3,
                width: 900,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('Images/Background.png'),
                    fit: BoxFit.cover, // Ajustement de l'image
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 140),
                child: Container(
                  height: 65,
                  width: 930,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  
                  child: const Padding(
                    padding: EdgeInsets.only(right: 820),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        CircleAvatar(
                      backgroundImage: AssetImage("Images/Ellipse.png",),
                      
                    ),
                    SizedBox(width: 10,),
                    Text("Email")
                      ],
                    )
                    
                  ),
                ),
              ),

              // Container(
              //   color: Colors.white,

              // )
            ],
          ),

          SizedBox(height: 40,),
          Container(
            height: 250,
            width: 900,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                const Text("Profile Information"),
                const SizedBox(height: 10,),
                const Text("Bonjour, je m'appelle Aoua Sow, Décisions : si vous n'arrivez pas à décider, la réponse est non. S’il s’agit de deux chemins également difficiles, choisissez celui qui est le plus douloureux à court terme (éviter la douleur crée une illusion d’égalité).",style: TextStyle(),textAlign: TextAlign.center,),
                const SizedBox(height: 20,),
              
                    SizedBox(
                      height: 30,
                      width: 300,
                      child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 8.0),
                              labelText: 'Nom ',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Color(0xFF2C2C2C))),
                              filled: true,
                              fillColor: Colors.white // Couleur de fond du champ
                              ),
                        ),
                    ),
                      const SizedBox(height: 10,),

                      SizedBox(
                        height: 30,
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 8.0),
                              labelText: 'Prenom ',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Color(0xFF2C2C2C))),
                              filled: true,
                              fillColor: Colors.white // Couleur de fond du champ
                              ),
                        ),
                      ),


                      const SizedBox(height: 10,),

                      SizedBox(
                        height: 30,
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 8.0),
                              labelText: 'Email ',
                              prefixIcon: const Icon(Icons.mail_outline),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Color(0xFF2C2C2C))),
                              filled: true,
                              fillColor: Colors.white // Couleur de fond du champ
                              ),
                        ),
                      ),

                      SizedBox(height:10),             
                               ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF183E62),
                        maximumSize: Size(200, 50)),
                    child: const Text('Modifier Profile',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  
              ],
            ),
          )
        ],
      ),
    );
  }
}
