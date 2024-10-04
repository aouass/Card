import 'package:flutter/material.dart';

class CarteScannee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 80,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 6), // changes position
                    ),
                  ],
                ),
                child: Row(children: [
                 IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    iconSize: 30,
                    color: Color(0xFFF9754E),
                  ),
                  const SizedBox(
                    width: 200,
                  ),
                   Image.asset(
                    'image/Logo_ScanCard.png',
                    width: 85,
                    height: 85,
                  ),
                ])),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 70),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    iconSize: 20,
                    color: Color(0xFFF9754E),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  height: 100,
                  width: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('image/Group.png'),
                      fit: BoxFit.cover, // Ajustement de l'image
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            // Bouton "Rescan"
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                onPressed: () {
                  // Implémenter l'action pour relancer le scan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9754E), // Couleur du bouton
                  // maximumSize: const Size(50, 40),
                ),
                child: const Text(
                  'Rescan',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        labelText: 'Catégorie...',
                        prefixIcon: const Icon(
                          Icons.category_outlined,
                          color: Color(0xFF21396A),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        labelText: 'Nom...',
                        prefixIcon:
                            const Icon(Icons.person, color: Color(0xFF21396A)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        labelText: 'Profession...',
                        prefixIcon: const Icon(Icons.work_outline_rounded,
                            color: Color(0xFF21396A)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        labelText: 'Email...',
                        prefixIcon: const Icon(Icons.alternate_email,
                            color: Color(0xFF21396A)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        labelText: 'Entreprise...',
                        prefixIcon: const Icon(Icons.business_rounded,
                            color: Color(0xFF21396A)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        labelText: 'Personnel...',
                        prefixIcon: const Icon(Icons.phone_android_rounded,
                            color: Color(0xFF21396A)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        labelText: 'Office...',
                        prefixIcon: const Icon(Icons.phone_missed_rounded,
                            color: Color(0xFF21396A)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        labelText: 'Adresse...',
                        prefixIcon: const Icon(Icons.location_on_outlined,
                            color: Color(0xFF21396A)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                        filled: true,
                        fillColor: Colors.white // Couleur de fond du champ
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Implémenter l'action pour relancer le scan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFF9754E), // Couleur du bouton
                      minimumSize: const Size(30, 30),
                    ),
                    child: const Text(
                      'Ajouter plus de champ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implémenter l'action pour relancer le scan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFF9754E), // Couleur du bouton
                      minimumSize: const Size(30, 30),
                    ),
                    child: const Text(
                      'Enregister',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
