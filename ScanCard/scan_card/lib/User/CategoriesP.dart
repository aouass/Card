import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrganisationPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _getOrganisationContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('categorie', isEqualTo: 'Organisation')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('categorie', isEqualTo: 'Organisation')
        .get();

    items.addAll(contactsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());
    items.addAll(cardsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organisation'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getOrganisationContactsAndCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun contact ou carte scannée'));
          } else {
            List<Map<String, dynamic>> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return ListTile(
                  title: Text(item['nom'] ?? 'Nom indisponible'),
                  subtitle: Text(item['email'] ?? 'Email indisponible'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EntreprisePage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _getEntreprisePageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('categorie', isEqualTo: 'Entreprise')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('categorie', isEqualTo: 'Entreprise')
        .get();

    items.addAll(contactsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());
    items.addAll(cardsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entreprise'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getEntreprisePageContactsAndCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun contact ou carte scannée'));
          } else {
            List<Map<String, dynamic>> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return ListTile(
                  title: Text(item['nom'] ?? 'Nom indisponible'),
                  subtitle: Text(item['email'] ?? 'Email indisponible'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class FreelancePage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _getFreelancePageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('categorie', isEqualTo: 'Freelance')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('categorie', isEqualTo: 'Freelance')
        .get();

    items.addAll(contactsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());
    items.addAll(cardsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Freelance'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getFreelancePageContactsAndCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun contact ou carte scannée'));
          } else {
            List<Map<String, dynamic>> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return ListTile(
                  title: Text(item['nom'] ?? 'Nom indisponible'),
                  subtitle: Text(item['email'] ?? 'Email indisponible'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProfessionnelPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>>
      _getProfessionnelPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('categorie', isEqualTo: 'Professionnel')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('categorie', isEqualTo: 'Professionnel')
        .get();

    items.addAll(contactsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());
    items.addAll(cardsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professionnel'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getProfessionnelPageContactsAndCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun contact ou carte scannée'));
          } else {
            List<Map<String, dynamic>> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return ListTile(
                  title: Text(item['nom'] ?? 'Nom indisponible'),
                  subtitle: Text(item['email'] ?? 'Email indisponible'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class colleguePage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _getColleguePageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('categorie', isEqualTo: 'Collegue')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('categorie', isEqualTo: 'Collegue')
        .get();

    items.addAll(contactsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());
    items.addAll(cardsSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collegue'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getColleguePageContactsAndCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun contact ou carte scannée'));
          } else {
            List<Map<String, dynamic>> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return ListTile(
                  title: Text(item['nom'] ?? 'Nom indisponible'),
                  subtitle: Text(item['email'] ?? 'Email indisponible'),
                );
              },
            );
          }
        },
      ),
    );
  }
}


