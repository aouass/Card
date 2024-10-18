import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TechnologiePage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _getTechnologieContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Technologie')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Technologie')
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
  Future<List<Map<String, dynamic>>> _getSantePageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Santé')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Santé')
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
  Future<List<Map<String, dynamic>>> _getMarketingPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Marketing')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Marketing')
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
  Future<List<Map<String, dynamic>>>
      _getImmobilierPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Immobilier')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Immobilier')
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
  Future<List<Map<String, dynamic>>> _getEducationPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Education')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Education')
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
  Future<List<Map<String, dynamic>>> _getTourismePageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Tourisme')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Tourisme')
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
  Future<List<Map<String, dynamic>>> _getEnergiePageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Energie')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Energie')
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
  Future<List<Map<String, dynamic>>>
      _getEnvironnementPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Environnement')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Environnement')
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
  Future<List<Map<String, dynamic>>> _getAutresPageContactsAndCards() async {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot contactsSnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('domaine', isEqualTo: 'Autres')
        .get();
    QuerySnapshot cardsSnapshot = await FirebaseFirestore.instance
        .collection('CarteScannee')
        .where('domaine', isEqualTo: 'Autres')
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
