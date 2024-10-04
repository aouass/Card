import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scan_card/User/Login.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Timer de 2 secondes pour passer à la page de connexion
    Timer(Duration(seconds: 2), () {
      // Redirection vers la page de connexion
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Image d'arrière-plan
          Positioned.fill(
            child: Image.asset(
              'image/SplashScreen.png', // Assurez-vous que l'image est dans le bon dossier
              fit: BoxFit.cover,
            ),
          ),
          // Texte superposé

          Padding(
            padding: EdgeInsets.only(top: 350),
            child: Center(
              child: Container(
                height: 375,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(children: [
                        Image.asset(
                          'image/Logo_ScanCard.png',
                          width: 350,
                          height: 250,
                        ),
                      ]),
                    ),
                    const Text(
                      "scannez vos cartes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF21396A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "de visite en toute",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF21396A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "simplicité!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF21396A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // const Positioned(
          //   bottom: 50, // Place le texte en bas de l'écran
          //   left: 0,
          //   right: 0,
          //   child: Text(
          //     "scannez vos cartes de visite en toute simplicité!", // Le nouveau texte
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
