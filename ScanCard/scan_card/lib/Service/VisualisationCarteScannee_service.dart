import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';


class CardService {
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addScannedCard(
      String ScanneeId, Map<String, dynamic> ScanneeData) async {
    try {
      // Ajoute ou met à jour un document avec l'ID donné
      await _firestore.collection('CarteScannee').doc(ScanneeId).set(ScanneeData);
    } catch (e) {
      throw Exception(
          "Erreur lors de l'ajout ou de la mise à jour du contact : $e");
    }
  }


  Future<File?> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  Future<String> applyOCR(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    textRecognizer.close();
    return recognizedText.text;
  }
}



















// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:scan_card/Service/Scan_service.dart';
// import 'package:scan_card/User/AcceuilUser.dart';

// class CameraPage extends StatefulWidget {
//   @override
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   File? _imageFile;
//   String _scannedText = '';
//   bool _isProcessing = false;

//   final ScanService _scanService = ScanService();

//   // Fonction pour capturer l'image et lancer l'OCR
//   Future<void> _captureAndScanImage() async {
//     setState(() {
//       _isProcessing = true;
//     });

//     await _scanService.pickImage().then((pickedImage) {
//       if (pickedImage != null) {
//         setState(() {
//           _imageFile = pickedImage;
//         });
//         _scanService.applyOCR(pickedImage).then((scannedText) {
//           setState(() {
//             _scannedText = scannedText;
//             _isProcessing = false;
//           });
//         });
//       } else {
//         setState(() {
//           _isProcessing = false;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: Stack(
//           children: [
//             Center(
//               child: Container(
//                 width: 250,
//                 height: 350,
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   border: Border.all(color: Colors.white, width: 2),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: _imageFile != null
//                     ? Image.file(_imageFile!)
//                     : Center(child: Text('Aucune image', style: TextStyle(color: Colors.white))),
//               ),
//             ),
//             Positioned(
//               top: 40,
//               left: 20,
//               child: IconButton(
//                 icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => AcceuilUser()),
//                   );
//                 },
//               ),
//             ),
//             Positioned(
//               top: 40,
//               right: 20,
//               child: IconButton(
//                 icon: Icon(Icons.cameraswitch_outlined, color: Colors.white, size: 30),
//                 onPressed: () {
//                   // Logique de changement de caméra (non implémentée)
//                 },
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border(top: BorderSide(color: Colors.grey.shade800)),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     const Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.image, color: Colors.grey, size: 30),
//                         Text('Images', style: TextStyle(color: Colors.grey, fontSize: 14)),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         await _captureAndScanImage();
//                       },
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.grey, width: 5),
//                         ),
//                       ),
//                     ),
//                     const Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.person, color: Colors.grey, size: 30),
//                         Text('Manuelle', style: TextStyle(color: Colors.grey, fontSize: 14)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (_isProcessing)
//               Center(child: CircularProgressIndicator()),
//             if (_scannedText.isNotEmpty)
//               Positioned(
//                 bottom: 100,
//                 left: 20,
//                 right: 20,
//                 child: Text(
//                   _scannedText,
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
