import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/User/ContactCarte.dart';

class ContactUser extends StatefulWidget {
  @override
  _ContactUserState createState() => _ContactUserState();
}

class _ContactUserState extends State<ContactUser> {
  String searchQuery = "";
  Stream<QuerySnapshot>? contactStream;

  @override
  void initState() {
    super.initState();
    // Initialiser le stream des contacts
    contactStream =
        FirebaseFirestore.instance.collection('contacts').snapshots();
  }

  // Fonction pour rechercher les contacts
  void searchContacts(String query) {
    setState(() {
      searchQuery = query;
      if (query.isNotEmpty) {
        contactStream = FirebaseFirestore.instance
            .collection('contacts')
            .where('categorie', isGreaterThanOrEqualTo: query)
            .where('categorie', isLessThanOrEqualTo: query + '\uf8ff')
            .snapshots();
      } else {
        contactStream =
            FirebaseFirestore.instance.collection('contacts').snapshots();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 1),
          width: double.infinity,
          decoration: const BoxDecoration(color: Color(0xFF21396A)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(left: 90, right: 90),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('image/Ellipse.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Salut , Aoua SOW",
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Bloc du milieu
              Expanded(
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) => searchContacts(value),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 1, right: 1),
                                  prefixIcon: const Icon(Icons.search),
                                  hintText: "Recherche Contact",
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF000000)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF2C2C2C)),
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(243, 243, 243, 243),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                const Text("Soumettre un ticket",
                                    style: TextStyle(fontSize: 14)),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ContactCarte()),
                                    );
                                  },
                                  icon: const Icon(Icons.add_circle_rounded,
                                      color: Color(0xFFF9754E), size: 40),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 34),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: contactStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                    child: Text("Aucun contact trouvé"));
                              }

                              final contacts = snapshot.data!.docs;

                              return ListView.builder(
                                itemCount: contacts.length,
                                itemBuilder: (context, index) {
                                  var contact = contacts[index];
                                  return Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xFF21396A).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.white, width: 2),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          // Texte au milieu
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  contact['profession'] ??
                                                      'Profession',
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
                                          // Bouton circulaire à droite
                                          const CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Color(0xFFF9754E),
                                            child: Icon(
                                              Icons.more_horiz,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
