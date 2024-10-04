import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  final CollectionReference userCollection = 
      FirebaseFirestore.instance.collection('users');

  // Récupérer tous les utilisateurs
  Stream<List<Map<String, dynamic>>> getAllUsers() {
    return userCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());
  }

  // Supprimer un utilisateur
  Future<void> deleteUser(String userId) async {
    return await userCollection.doc(userId).delete();
  }

  // Supprimer une carte
  Future<void> deleteCard(String cardId) async {
    return await FirebaseFirestore.instance
        .collection('cards')
        .doc(cardId)
        .delete();
  }
}
