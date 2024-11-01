import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TechnologiePage extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<List<Map<String, dynamic>>> _getTechnologieContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Technologie')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Technologie')
        .where('userId', isEqualTo: userId) // Filtrer par userId
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
        title: Text('Technologie'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getTechnologieContactsAndCards(),
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

class SantePage extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<List<Map<String, dynamic>>> _getSantePageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Santé')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Santé')
        .where('userId', isEqualTo: userId) // Filtrer par userId
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
        title: Text('Santé'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getSantePageContactsAndCards(),
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

class MarketingPage extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<List<Map<String, dynamic>>> _getMarketingPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Marketing')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Marketing')
        .where('userId', isEqualTo: userId) // Filtrer par userId
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
        title: Text('Marketing'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getMarketingPageContactsAndCards(),
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

class ImmobilierPage extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<List<Map<String, dynamic>>>
      _getImmobilierPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Immobilier')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Immobilier')
        .where('userId', isEqualTo: userId) // Filtrer par userId
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
        title: Text('Immobilier'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getImmobilierPageContactsAndCards(),
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

class EducationPage extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<List<Map<String, dynamic>>> _getEducationPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Education')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Education')
        .where('userId', isEqualTo: userId) // Filtrer par userId
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
        title: Text('Education'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getEducationPageContactsAndCards(),
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

class TourismePage extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<List<Map<String, dynamic>>> _getTourismePageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Tourisme')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Tourisme')
        .where('userId', isEqualTo: userId) // Filtrer par userId
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
        title: Text('Tourisme'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getTourismePageContactsAndCards(),
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

class EnergiePage extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<List<Map<String, dynamic>>> _getEnergiePageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Energie')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Energie')
        .where('userId', isEqualTo: userId) // Filtrer par userId
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
        title: Text('Energie'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getEnergiePageContactsAndCards(),
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

class EnvironnementPage extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<List<Map<String, dynamic>>>
      _getEnvironnementPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Environnement')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Environnement')
        .where('userId', isEqualTo: userId) // Filtrer par userId
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
        title: Text('Environnement'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getEnvironnementPageContactsAndCards(),
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

class AutresPage extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<List<Map<String, dynamic>>> _getAutresPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Autres')
        .where('userId', isEqualTo: userId) // Filtrer par userId
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Autres')
        .where('userId', isEqualTo: userId) // Filtrer par userId
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
        title: Text('Autres'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getAutresPageContactsAndCards(),
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
