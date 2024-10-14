import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/Service/Contact_service.dart';
import 'package:scan_card/User/AcceuilUser.dart';

class ContactCarte extends StatefulWidget {
  @override
  _ContactCarteState createState() => _ContactCarteState();
}

class _ContactCarteState extends State<ContactCarte> {
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

  final ContactService _contactService = ContactService();

  // Nouvelle variable pour gérer la sélection de la catégorie
  String? _selectedCategorie;

  // Liste des catégories
  final List<String> _categories = [
    'Ong',
    'Entreprise',
    'Freelance',
    'Professionnel',
    'Famille',
    'Autres'
  ];

  // Liste des champs dynamiques
  List<Widget> _additionalFields = [];

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

  void _saveContact() async {

    // Génère un nouvel ID unique pour le contact
    String contactId = FirebaseFirestore.instance.collection('contacts').doc().id;
    
    final contactData = {
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

    // Appel au service pour sauvegarder ou mettre à jour les données
    try {
      await _contactService.addOrUpdateContact(contactId, contactData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Contact enregistré avec succès'),
      ));
      // Réinitialiser les champs après l'enregistrement
      _resetFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de l\'enregistrement du contact'),
      ));
    }
  }

  // Méthode pour réinitialiser les champs de saisie
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
    });
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
                height: 60,
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
                        MaterialPageRoute(builder: (context) => AcceuilUser()),
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
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
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
                    _buildTextField(_professionController, 'Profession...',
                        Icons.work_outline_rounded),
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

                    _buildCategorieDropdown(), // Dropdown pour le champ catégorie

                    const SizedBox(height: 14),
                    _buildTextField(_domaineController, 'Domaine...',
                        Icons.domain_verification),
                    const SizedBox(height: 14),
                    _buildTextField(
                        _noteController, 'Note...', Icons.note_alt_outlined),

                    // Affichage des champs supplémentaires
                    ..._additionalFields,
                  ],
                ),
              ),


              
              const SizedBox(height: 40),
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
                        onPressed: _saveContact,
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

  // Widget Dropdown pour le choix de la catégorie
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
}
