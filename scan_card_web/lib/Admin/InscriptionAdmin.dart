import 'package:flutter/material.dart';
import 'package:scan_card_web/Admin/LoginAdmin.dart';
import 'package:scan_card_web/service/auth_service_Admin.dart';

class InscriptionAdmin extends StatefulWidget {
  @override
  State<InscriptionAdmin> createState() => _InscriptionAdminState();
}

class _InscriptionAdminState extends State<InscriptionAdmin> {
  final TextEditingController Nom = TextEditingController();
  final TextEditingController Prenom = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController Mdp = TextEditingController();
  String emailError = '';

  // Nouvelle variable pour gérer la visibilité du mot de passe
  bool _obscureText = true;

// Fonction pour afficher le popup
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
                // Icone du popup
                const CircleAvatar(
                  backgroundColor:
                      Color(0xFFF9754E), // Orange comme dans l'image
                  radius: 40,
                  child: Icon(
                    Icons.check, // Icône de validation
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Texte de félicitations
                const Text(
                  'Félicitations!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        Color(0xFF183E62), // Couleur similaire à celle utilisée
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Inscription réussie avec succès',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Bouton de redirection vers la page de connexion
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginAdmin()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF9754E), // Couleur du bouton
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(30, 30),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Image d'arrière-plan
          Positioned.fill(
            child: Image.asset(
              'Images/Connexion.png', // Assurez-vous que l'image est dans le bon dossier
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 50, left: 30),
            child: Center(
              child: Container(
                height: size.height * 0.7,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 6,
                      blurRadius: 6,
                      offset: Offset(4, 4), // changes position
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 100),
                    child: Container(
                      height: 130,
                      width: 320,
                      decoration: BoxDecoration(
                        color: Color(0xFF21396A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                        ),
                        child: Image.asset(
                          'Images/scancard-fond_blanc.png',
                          width: 300,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 300, // Largeur personnalisée
                        height: 40,
                        child: TextField(
                          controller: Nom,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0),
                            labelText: 'Nom',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2C2C2C))),
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300, // Largeur personnalisée
                        height: 40,
                        child: TextField(
                          controller: Prenom,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0),
                            labelText: 'Prenom',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2C2C2C))),
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300, // Largeur personnalisée
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: Email,
                          onChanged: (value) {
                            setState(() {
                              emailError =
                                  RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)
                                      ? ''
                                      : 'Adresse e-mail invalide';
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C2C2C))),
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            errorText: emailError.isEmpty ? null : emailError,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300, // Largeur personnalisée
                        height: 40,
                        child: TextField(
                          controller: Mdp,
                          obscureText:
                              _obscureText, // Utilise la variable d'état
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 8.0),
                              labelText: 'Mot de Passe',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  // Inverse l'état pour afficher ou masquer le mot de passe
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFF2C2C2C))),
                              filled: true,
                              fillColor:
                                  Colors.white // Couleur de fond du champ
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String email = Email.text.trim();

                          if (emailError.isEmpty && email.isNotEmpty) {
                            AuthServiceAdmin()
                                .signUpAdmin(
                              Email.text,
                              Mdp.text,
                              Nom.text,
                              Prenom.text,
                            )
                                .then((result) {
                              // Appel du popup si l'inscription est réussie
                              if (result != null) {
                                showSuccessPopup(context);
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text("Veuillez entrer un email valide.")),
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
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
