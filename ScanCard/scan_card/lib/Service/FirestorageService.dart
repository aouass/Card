import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

// Methode pour uploader une image
  Future<String?> uploadImage(io.File imageFile, String userId) async {
    try {
      final Reference storageRef =
          _firebaseStorage.ref().child('profil_image/$userId.png');
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
    }
  }
}
