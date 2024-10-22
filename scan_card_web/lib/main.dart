import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scan_card_web/Admin/InscriptionAdmin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyATyZeUknN5E_bL13c5M1xZLGRwIgj40Vg",
        authDomain: "projet-fin-formation-52321.firebaseapp.com",
        projectId: "projet-fin-formation-52321",
        storageBucket: "projet-fin-formation-52321.appspot.com",
        messagingSenderId: "473954963388",
        appId: "1:473954963388:web:3fcb663255430564fae5b9",
        measurementId: "G-42YKMNPE06",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InscriptionAdmin(),
    );
  }
}
