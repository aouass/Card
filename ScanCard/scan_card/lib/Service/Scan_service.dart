import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Fonction pour scanner une carte, la sauvegarder et lire le texte
  Future<Map<String, String>?> scanCard() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      try {
        // Sauvegarde dans Firebase Storage
        String filePath = 'cards/${DateTime.now().millisecondsSinceEpoch}.png';
        TaskSnapshot task = await _storage.ref(filePath).putFile(file);
        String downloadUrl = await task.ref.getDownloadURL();

        // Analyse du texte via OCR
        final inputImage = InputImage.fromFile(file);
        final textRecognizer = TextRecognizer();
        final RecognizedText recognizedText =
            await textRecognizer.processImage(inputImage);

        // Extraction du texte
        String extractedText = recognizedText.text;

        // fermer le TextRecognizer pour libérer les ressources
        textRecognizer.close();

        // Retourne à la fois l'URL de l'image et le texte extrait
        return {'url': downloadUrl, 'text': extractedText};
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
    return null;
  }
}
