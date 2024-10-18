import 'package:flutter/material.dart';
import 'package:scan_card/Service/auth_service_User.dart';
import 'package:scan_card/User/Inscription.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  // Nouvelle variable pour gérer la visibilité du mot de passe
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Bienvenue!',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                //const SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Image.asset(
                    'image/Logo_ScanCard.png',
                    width: 500,
                    height: 300,
                  ),
                ),

                const Text(
                  "Connectons-nous",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C)),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 8.0),
                    labelText: 'Nom d’utilisateur ou Email',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                    filled: true,
                    fillColor: const Color.fromARGB(
                        243, 243, 243, 243), // Couleur de fond du champ
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText, // Utilise la variable d'état
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 8.0),
                    labelText: 'Mot de Passe',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
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
                        borderSide: BorderSide(color: Color(0xFF2C2C2C))),
                    filled: true,
                    fillColor: const Color.fromARGB(
                        243, 243, 243, 243), // Couleur de fond du champ
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Implémenter la fonctionnalité "Mot de passe oublié"
                  },
                  child: const Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      String email = _emailController.text.trim();
                      if (email.isNotEmpty) {
                        AuthService().signIn(_emailController.text,
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
                      backgroundColor:
                          const Color(0xFF183E62), // Couleur du bouton
                      maximumSize: const Size(80, 50),
                    ),
                    child: const Text(
                      'Se Connecter',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                                  Inscription()), // Remplace par la page de connexion appropriée
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
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
