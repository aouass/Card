import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/Admin/LoginAdmin.dart';
import 'package:scan_card/Widgets/SideBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCup9vj7KpHDBiV7kp9_LejC3ETWFPgPlo",
        authDomain: "scancard-53ff8.firebaseapp.com",
        projectId: "scancard-53ff8",
        storageBucket: "scancard-53ff8.appspot.com",
        messagingSenderId: "27801613333",
        appId: "1:27801613333:web:d8dfcdace3fa239940ca1c",
        measurementId: "G-QCP8KQP5PP"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variable pour garder l'état de connexion
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Vérification de l'état de connexion
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn ? Sidebar() : LoginAdmin(),
    );
  }
}
