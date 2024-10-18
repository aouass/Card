import 'package:flutter/material.dart';
import 'package:scan_card_web/Admin/InscriptionAdmin.dart';
import 'package:scan_card_web/service/auth_service_Admin.dart';

class LoginAdmin extends StatefulWidget {
  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  // Nouvelle variable pour gérer la visibilité du mot de passe
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
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
                height: 375,
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

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 538, top: 130),
                child: Container(
                  height: 130,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Color(0xFF21396A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 120, top: 100),
                    child: Text(
                      'Connexion',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.only(left: 550, top: 260),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(children: [
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 300, // Largeur personnalisée
                      height: 40,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0),
                            labelText: 'Nom d’utilisateur ou Email',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C2C2C))),
                            filled: true,
                            fillColor: Colors.white // Couleur de fond du champ
                            ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 300, // Largeur personnalisée
                      height: 40,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscureText, // Utilise la variable d'état
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
                            fillColor: Colors.white // Couleur de fond du champ
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String email = _emailController.text.trim();
                        if (email.isNotEmpty) {
                          AuthServiceAdmin().signInAdmin(_emailController.text,
                              _passwordController.text, context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Veuillez entrer un email valide.")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Définir le rayon des coins arrondis
                        ),
                        backgroundColor:
                            const Color(0xFF183E62), // Couleur du bouton
                        maximumSize: const Size(800, 50),
                      ),
                      child: const Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
                Row(
                  children: [
                    const Text(
                      "Vous n'avez pas de compte ? ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigue vers la page de connexion
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  InscriptionAdmin()), // Remplace par la page de connexion appropriée
                        );
                      },
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(
                          color: Color(0xFF183E62),
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 650, top: 130),
            child: Image.asset(
              'Images/scancard-fond_blanc.png',
              width: 115,
              height: 95,
            ),
          ),
        ],
      ),
    );
  }
}
