import 'package:cloud_firestore/cloud_firestore.dart';

class CardService {
  final CollectionReference cardCollection = 
      FirebaseFirestore.instance.collection('cards');

  // Ajouter une nouvelle carte scannée
  Future<DocumentReference<Object?>> addScannedCard(String url, String owner) async {
    return await cardCollection.add({
      'url': url,
      'owner': owner,
      'timestamp': Timestamp.now(),
    });
  }

  // Récupérer les cartes scannées par utilisateur
  Stream<List<Map<String, dynamic>>> getScannedCards(String userId) {
    return cardCollection.where('owner', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }
}
