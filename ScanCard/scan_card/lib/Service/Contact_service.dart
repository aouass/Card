import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrUpdateContact(
      String contactId, Map<String, dynamic> contactData) async {
    try {
      // Ajoute ou met à jour un document avec l'ID donné
      await _firestore.collection('contacts').doc(contactId).set(contactData);
    } catch (e) {
      throw Exception(
          "Erreur lors de l'ajout ou de la mise à jour du contact : $e");
    }
  }
}
