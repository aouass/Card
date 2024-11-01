import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/Service/Scan_service.dart';
import 'package:scan_card/User/navigation_bar.dart'; // Assure-toi que ton service ScanService est importé

class CarteScannee extends StatefulWidget {
  @override
  _CarteScanneeState createState() => _CarteScanneeState();
}

class _CarteScanneeState extends State<CarteScannee> {
  File? _imageFile;
  String _scannedText = '';
  bool _isProcessing = false;

  // Contrôleurs pour les champs de saisie
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _personnelController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _entrepriseController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _domaineController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final ScanService _scanService = ScanService();
  String? _userId; // ID de l'utilisateur connecté

  String? _selectedCategorie;
  final List<String> _categories = [
    'Ong',
    'Entreprise',
    'Freelance',
    'Professionnel',
    'Famille',
    'Autres'
  ];

  String? _selectedDomaine;
  final List<String> _domaines = [
    'Technologie',
    'Santé',
    'Marketing',
    'Immobilier',
    'Education',
    'Tourisme',
    'Energie',
    'Environnement',
    'Autres'
  ];

  // Liste des champs dynamiques
  List<Widget> _additionalFields = [];

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  void _fetchUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid; // Récupère l'ID de l'utilisateur connecté
    }
  }

  void _addField() {
    setState(() {
      _additionalFields.add(_buildDynamicField());
    });
  }

  void _removeField(int index) {
    setState(() {
      _additionalFields.removeAt(index);
    });
  }

   void _saveScan() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Impossible d'enregistrer. Utilisateur non connecté."),
      ));
      return;
    }

    String scanId =
        FirebaseFirestore.instance.collection('CarteScannee').doc().id;

    final scanData = {
      'userId': _userId, // Ajoute l'ID de l'utilisateur connecté
      'nom': _nomController.text,
      'prenom': _prenomController.text,
      'personnel': _personnelController.text,
      'profession': _professionController.text,
      'email': _emailController.text,
      'entreprise': _entrepriseController.text,
      'adresse': _adresseController.text,
      'categorie': _selectedCategorie ?? '',
      'domaine': _domaineController.text,
      'note': _noteController.text,
    };

    try {
      await _scanService.addOrUpdateScan(scanId, scanData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('CarteScannee enregistrée avec succès'),
      ));
      _resetFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de l\'enregistrement de la carte'),
      ));
    }
  }

  void _resetFields() {
    _nomController.clear();
    _prenomController.clear();
    _personnelController.clear();
    _professionController.clear();
    _emailController.clear();
    _entrepriseController.clear();
    _adresseController.clear();
    _domaineController.clear();
    _noteController.clear();
    setState(() {
      _selectedCategorie = null; // Réinitialiser la catégorie sélectionnée
      _additionalFields.clear(); // Réinitialiser les champs supplémentaires
      _selectedDomaine = null;
      _additionalFields.clear();
    });
  }

  void _startScan() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      // Capture l'image scannée
      final File? scannedImage = await _scanService.captureImage();
      if (scannedImage != null) {
        _imageFile = scannedImage;

        // Extraire les données via OCR
        final extractedText =
            await _scanService.extractTextFromImage(scannedImage);

        // Appelle une fonction qui extrait les données précises depuis le texte
        Map<String, String> extractedData = _parseExtractedText(extractedText);

        // Alimente les champs avec les données extraites
        setState(() {
          _nomController.text = extractedData['nom'] ?? '';
          _prenomController.text = extractedData['prenom'] ?? '';
          _personnelController.text = extractedData['personnel'] ?? '';
          _professionController.text = extractedData['profession'] ?? '';
          _emailController.text = extractedData['email'] ?? '';
          _entrepriseController.text = extractedData['entreprise'] ?? '';
          _adresseController.text = extractedData['adresse'] ?? '';
          _domaineController.text = extractedData['domaine'] ?? '';
          _noteController.text = extractedData['note'] ?? '';
        });
      }
    } catch (e) {
      print("Erreur lors du scan : $e");
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

// RegExp(r'(?<=Nom:)\s*(\w+)',r'(?<=Prénom:)\s*(\w+)
  Map<String, String> _parseExtractedText(String extractedText) {
    Map<String, String> extractedData = {};

    // Utilisation d'expressions régulières pour identifier les différents éléments
    //  capturer une adresse e-mail valide en utilisant un modèle spécifique qui correspond à une suite de caractères avant et après le symbole @, suivie d'un domaine avec une extension de 2 à 7 lettres (comme .com, .org, etc.).
    RegExp emailRegex = RegExp(r'\b[\w.%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b');

    RegExp nomRegex =
        RegExp(r'(?<=Nom:)\s*(?:\w+|\b[A-Z]+\b)', caseSensitive: false);
    RegExp prenomRegex =
        RegExp(r'(?<=Prénom:)\s*([A-Z][a-z]+|\w+)', caseSensitive: false);
    RegExp entrepriseRegex =
        RegExp(r'(?<=Entreprise:)\s*(\w+)', caseSensitive: false);
    RegExp professionRegex =
        RegExp(r'\b([A-Z][a-z]+ [A-Z][a-z]+)\b', caseSensitive: false);
// Les mots qui commencent par une majuscule et Les espaces, les tirets, les virgules, et d'autres caractères acceptables pour une adresse.
    RegExp adresseRegex = RegExp(
        r'([A-Z][a-zA-Z0-9\s,.-]*)(?:\s+[A-Z][a-zA-Z0-9\s,.-]*)*',
        caseSensitive: false);

// cette expression régulière correspondra uniquement aux numéros de téléphone commençant par "223" ou "+223", suivis de 8 chiffres.
    RegExp personnelRegex = RegExp(
        r'(?:(?:\+223\s?|223\s?\(|\(223\)\s?)\d{2}\s?\d{2}\s?\d{2}\s?\d{2})');

    // Chercher et assigner les valeurs aux champs
    extractedData['email'] =
        emailRegex.firstMatch(extractedText)?.group(0) ?? '';
    extractedData['nom'] = nomRegex.firstMatch(extractedText)?.group(0) ?? '';
    extractedData['prenom'] =
        prenomRegex.firstMatch(extractedText)?.group(0) ?? '';
    extractedData['entreprise'] =
        entrepriseRegex.firstMatch(extractedText)?.group(0) ?? '';
    extractedData['profession'] =
        professionRegex.firstMatch(extractedText)?.group(0) ?? '';
    extractedData['adresse'] =
        adresseRegex.firstMatch(extractedText)?.group(0) ?? '';
    extractedData['personnel'] =
        personnelRegex.firstMatch(extractedText)?.group(0) ??
            ''; // Extraction du téléphone

    // Retourne les données extraites
    return extractedData;
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
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyNavigationBar()),
                      );
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    iconSize: 30,
                    color: Color(0xFFF9754E),
                  ),
                  const SizedBox(width: 215),
                  Image.asset(
                    'image/Logo_ScanCard.png',
                    width: 85,
                    height: 85,
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              // Afficher l'image scannée ou un placeholder
              _imageFile != null
                  ? Image.file(_imageFile!)
                  : Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1EAEA),
                        borderRadius: BorderRadius.circular(
                            10), // Ajustez le rayon selon vos besoins
                      ),
                      child: Center(
                        child: Text("Aucune image scannée"),
                      ),
                    ),
              const SizedBox(height: 20),

              // Bouton pour lancer le scan
              ElevatedButton(
                onPressed: _startScan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9754E), // Couleur du bouton
                  maximumSize: const Size(80, 50),
                ),
                child: _isProcessing
                    ? CircularProgressIndicator()
                    : Text(
                        "Scan",
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
              ),

              // Champs de saisie remplis avec les données scannées
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField(_nomController, 'Nom...', Icons.person),
                    const SizedBox(height: 14),
                    _buildTextField(
                        _prenomController, 'Prenom...', Icons.person),
                    const SizedBox(height: 14),
                    _buildTextField(_personnelController, 'Personnel...',
                        Icons.phone_android_rounded),
                    const SizedBox(height: 14),
                    _buildTextField(
                        _professionController, 'Profession...', Icons.work),
                    const SizedBox(height: 14),
                    _buildTextField(
                        _emailController, 'Email...', Icons.alternate_email),
                    const SizedBox(height: 14),
                    _buildTextField(_entrepriseController, 'Entreprise...',
                        Icons.business_rounded),
                    const SizedBox(height: 14),
                    _buildTextField(_adresseController, 'Adresse...',
                        Icons.location_on_outlined),
                    const SizedBox(height: 14),
                    _buildDomaineDropdown(),
                    const SizedBox(height: 14),
                    _buildTextField(_noteController, 'Note...', Icons.note),
                    const SizedBox(height: 10),
                    _buildCategorieDropdown(),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 185,
                      child: ElevatedButton(
                        onPressed: _addField,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFF9754E), // Couleur du bouton
                          minimumSize: const Size(50, 50),
                        ),
                        child: const Text(
                          'Ajouter plus de champ',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 40,
                      width: 130,
                      child: ElevatedButton(
                        onPressed: _saveScan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF9754E),
                          minimumSize: const Size(50, 50),
                        ),
                        child: const Text(
                          'Enregister',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour le champ catégorie (dropdown)
  Widget _buildCategorieDropdown() {
    return SizedBox(
      width: 300,
      height: 40,
      child: DropdownButtonFormField<String>(
        value: _selectedCategorie,
        hint: Text('Catégorie...'),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
          prefixIcon:
              Icon(Icons.category_outlined, color: Color(0xFF21396A), size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Color(0xFF2C2C2C)),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: _categories.map((String categorie) {
          return DropdownMenuItem<String>(
            value: categorie,
            child: Text(categorie),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedCategorie = newValue;
          });
        },
      ),
    );
  }

  // Fonction pour créer un TextField réutilisable
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return SizedBox(
      width: 300,
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF21396A), size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Color(0xFF2C2C2C)),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // Widget pour créer des champs dynamiques avec bouton de suppression
  Widget _buildDynamicField() {
    final TextEditingController dynamicController = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
              dynamicController, 'Champ supplémentaire...', Icons.add),
        ),
        IconButton(
          icon: Icon(Icons.remove_circle, color: Colors.red),
          onPressed: () {
            setState(() {
              _additionalFields.removeLast();
            });
          },
        ),
      ],
    );
  }

  // Widget pour le champ Domaine (dropdown)
  Widget _buildDomaineDropdown() {
    return SizedBox(
      width: 300,
      height: 40,
      child: DropdownButtonFormField<String>(
        value: _selectedDomaine,
        hint: Text('Domaine...'),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
            prefixIcon: Icon(Icons.domain_verification,
                color: Color(0xFF21396A), size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Color(0xFF2C2C2C)),
            ),
            filled: true,
            fillColor: Colors.white),
        items: _domaines.map((String domaine) {
          return DropdownMenuItem<String>(
            value: domaine,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  domaine,
                  style: TextStyle(fontSize: 18), // ajuster la taille du texte
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedDomaine = newValue;
          });
        },
      ),
    );
  }
}
