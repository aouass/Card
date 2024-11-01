import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_card/Service/FirestorageService.dart';
import 'package:scan_card/Service/auth_service_User.dart';
import 'package:scan_card/User/Login.dart';

class Inscription extends StatefulWidget {
  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final TextEditingController Nom = TextEditingController();
  final TextEditingController Prenom = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController Mdp = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();
  final StorageService _storageService = StorageService(); // Instance de StorageService

  Future<void> pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    } else {
      print('Image non sélectionnée');
    }
  }

  String emailError = '';
  bool _obscureText = true;

  void showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFF9754E),
                  radius: 40,
                  child: Icon(
                    Icons.check,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Félicitations!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183E62),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Inscription réussie avec succès',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF9754E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(30, 30),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Text(
                      'Aller à la page de connexion',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Bienvenue!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Image.asset(
                  'image/Logo_ScanCard.png',
                  width: 500,
                  height: 300,
                ),
              ),
              const Text(
                'Inscrivons-nous',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              
              // CircularAvatar pour prévisualiser l'image
              Center(
                child: GestureDetector(
                  onTap: pickImageFromGallery,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: Nom,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  labelText: 'Nom',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF2C2C2C))),
                  filled: true,
                  fillColor: Color(0xFFFFFFFF),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: Prenom,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  labelText: 'Prénom',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF2C2C2C))),
                  filled: true,
                  fillColor: Color(0xFFFFFFFF),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: Email,
                onChanged: (value) {
                  setState(() {
                    emailError = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)
                        ? ''
                        : 'Adresse e-mail invalide';
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                  filled: true,
                  fillColor: Color(0xFFFFFFFF),
                  errorText: emailError.isEmpty ? null : emailError,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: Mdp,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  labelText: 'Mot de Passe',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF2C2C2C))),
                  filled: true,
                  fillColor: Color(0xFFFFFFFF),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: ElevatedButton(
                  onPressed: () {
                    String email = Email.text.trim();

                    if (emailError.isEmpty && email.isNotEmpty && _image != null) {
  // Upload the image and get the URL
  _storageService.uploadImage(_image!, Nom.text).then((imageUrl) {
    if (imageUrl != null) {
      AuthService()
          .signUp(
        Email.text,
        Mdp.text,
        Nom.text,
        Prenom.text,
        imageUrl, // Pass the imageUrl to signUp
      )
      .then((result) {
        // Call the popup if the registration is successful
        if (result != null) {
          showSuccessPopup(context);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec de l'upload de l'image.")),
      );
    }
  });
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Veuillez entrer un email valide et sélectionner une image.")),
  );
}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF183E62),
                  ),
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous avez déjà un compte ?",
                    style: TextStyle(fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    
                    child: const Text(
                      "Se Connecter",
                      style: TextStyle(
                        color: Color(0xFF183E62),
                        decoration: TextDecoration.underline,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
