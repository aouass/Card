import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/User/DomainesP.dart';
import 'package:scan_card/User/navigation_bar.dart';

class Domaine extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

//fonction pour le nombre total Technologie
  Future<int> _getTechnologieCount(String userId) async {
    QuerySnapshot contacts = await firestore
        .collection('contacts')
        .where('domaine', isEqualTo: 'Technologie')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    QuerySnapshot cartes = await firestore
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Technologie')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    return contacts.size + cartes.size;
  }

//fonction pour le nombre total Santé
  Future<int> _getSanteCount(String userId) async {
    QuerySnapshot contacts = await firestore
        .collection('contacts')
        .where('domaine', isEqualTo: 'Santé')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    QuerySnapshot cartes = await firestore
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Santé')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    return contacts.size + cartes.size;
  }

//fonction pour le nombre total Marketing
  Future<int> _getMarketingCount(String userId) async {
    QuerySnapshot contacts = await firestore
        .collection('contacts')
        .where('domaine', isEqualTo: 'Marketing')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    QuerySnapshot cartes = await firestore
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Marketing')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    return contacts.size + cartes.size;
  }

//fonction pour le nombre total Immobilier
  Future<int> _getImmobilierCount(String userId) async {
    QuerySnapshot contacts = await firestore
        .collection('contacts')
        .where('domaine', isEqualTo: 'Immobilier')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    QuerySnapshot cartes = await firestore
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Immobilier')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    return contacts.size + cartes.size;
  }

//fonction pour le nombre total Education
  Future<int> _getEducationCount(String userId) async {
    QuerySnapshot contacts = await firestore
        .collection('contacts')
        .where('domaine', isEqualTo: 'Education')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    QuerySnapshot cartes = await firestore
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Education')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    return contacts.size + cartes.size;
  }

//fonction pour le nombre total Tourisme
  Future<int> _getTourismeCount(String userId) async {
    QuerySnapshot contacts = await firestore
        .collection('contacts')
        .where('domaine', isEqualTo: 'Tourisme')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    QuerySnapshot cartes = await firestore
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Tourisme')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    return contacts.size + cartes.size;
  }

//fonction pour le nombre total Energie
  Future<int> _getEnergieCount(String userId) async {
    QuerySnapshot contacts = await firestore
        .collection('contacts')
        .where('domaine', isEqualTo: 'Energie')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    QuerySnapshot cartes = await firestore
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Energie')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    return contacts.size + cartes.size;
  }

//fonction pour le nombre total Environnement
  Future<int> _getEnvironnementCount(String userId) async {
    QuerySnapshot contacts = await firestore
        .collection('contacts')
        .where('domaine', isEqualTo: 'Environnement')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    QuerySnapshot cartes = await firestore
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Environnement')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    return contacts.size + cartes.size;
  }

//fonction pour le nombre total Autres
  Future<int> _getAutresCount(String userId) async {
    QuerySnapshot contacts = await firestore
        .collection('contacts')
        .where('domaine', isEqualTo: 'Autres')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    QuerySnapshot cartes = await firestore
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Autres')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();

    return contacts.size + cartes.size;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 45,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyNavigationBar()),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      iconSize: 25,
                      color: Color(0xFFF9754E),
                    ),
                    const SizedBox(
                      width: 90,
                    ),
                    const Text(
                      "Domaines",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    )
                  ])),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Stack(
                  children: [
                    
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20),
                      child: FutureBuilder<int>(
                        future: _getTechnologieCount(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading state
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            int count = snapshot.data ?? 0;
                            return Container(
                              width: 290,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 6), // changes position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Technologie",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "($count)", // Nombre dynamique
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TechnologiePage()),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    iconSize: 25,
                                    color: const Color(0xFFF9754E),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 80),
                      child: FutureBuilder<int>(
                        future: _getSanteCount(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading state
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            int count = snapshot.data ?? 0;
                            return Container(
                              width: 290,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 6), // changes position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Santé",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "($count)", // Nombre dynamique
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 153,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SantePage()),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    iconSize: 25,
                                    color: const Color(0xFFF9754E),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 140),
                      child: FutureBuilder<int>(
                        future: _getMarketingCount(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading state
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            int count = snapshot.data ?? 0;
                            return Container(
                              width: 290,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 6), // changes position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Marketing",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "($count)", // Nombre dynamique
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 117,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MarketingPage()),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    iconSize: 25,
                                    color: const Color(0xFFF9754E),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 200),
                      child: FutureBuilder<int>(
                        future: _getImmobilierCount(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading state
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            int count = snapshot.data ?? 0;
                            return Container(
                              width: 290,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 6), // changes position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Immobilier",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "($count)", // Nombre dynamique
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 110,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ImmobilierPage()),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    iconSize: 25,
                                    color: const Color(0xFFF9754E),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 260),
                      child: FutureBuilder<int>(
                        future: _getEducationCount(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading state
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            int count = snapshot.data ?? 0;
                            return Container(
                              width: 290,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 6), // changes position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Education",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "($count)", // Nombre dynamique
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 115,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EducationPage()),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    iconSize: 25,
                                    color: const Color(0xFFF9754E),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 320),
                      child: FutureBuilder<int>(
                        future: _getTourismeCount(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading state
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            int count = snapshot.data ?? 0;
                            return Container(
                              width: 290,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 6), // changes position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Tourisme",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "($count)", // Nombre dynamique
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TourismePage()),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    iconSize: 25,
                                    color: const Color(0xFFF9754E),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 380),
                      child: FutureBuilder<int>(
                        future: _getEnergieCount(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading state
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            int count = snapshot.data ?? 0;
                            return Container(
                              width: 290,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 6), // changes position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Energie",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "($count)", // Nombre dynamique
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 135,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EnergiePage()),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    iconSize: 25,
                                    color: const Color(0xFFF9754E),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 445),
                      child: FutureBuilder<int>(
                        future: _getEnvironnementCount(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading state
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            int count = snapshot.data ?? 0;
                            return Container(
                              width: 290,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 6), // changes position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Environnement",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "($count)", // Nombre dynamique
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 75,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EnvironnementPage()),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    iconSize: 25,
                                    color: const Color(0xFFF9754E),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 510),
                      child: FutureBuilder<int>(
                        future: _getAutresCount(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading state
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            int count = snapshot.data ?? 0;
                            return Container(
                              width: 290,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 6), // changes position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Autres",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "($count)", // Nombre dynamique
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 145,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AutresPage()),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    iconSize: 25,
                                    color: const Color(0xFFF9754E),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
