import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ImagePicker _picker = ImagePicker();

  // Méthode pour capturer une image via la caméra
  Future<File?> captureImage() async {
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        return File(pickedImage.path);
      }
    } catch (e) {
      print("Erreur lors de la capture de l'image : $e");
    }
    return null;
  }

  // Méthode pour extraire le texte à partir de l'image capturée
  Future<String> extractTextFromImage(File image) async {
    try {
      final inputImage = InputImage.fromFile(image);
      final textRecognizer = TextRecognizer();
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      // Fermer le textRecognizer après usage
      textRecognizer.close();

      // Récupération du texte reconnu
      String extractedText = recognizedText.text;
      return extractedText;
    } catch (e) {
      print("Erreur lors de l'extraction du texte : $e");
      return '';
    }
  }

  Future<void> addOrUpdateContact(
      String scanId, Map<String, dynamic> scanData) async {
    try {
      // Ajoute ou met à jour un document avec l'ID donné
      await _firestore.collection('CarteScannee').doc(scanId).set(scanData);
    } catch (e) {
      throw Exception(
          "Erreur lors de l'ajout ou de la mise à jour du contact : $e");
    }
  }
}
