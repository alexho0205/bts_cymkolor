import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bts_cymkolor/models/reservation.dart';
import 'package:bts_cymkolor/models/passenger.dart';

class ReservationRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String collectionName = 'Reservation';

  Future<Reservation> fetchReservationByPaymentId(String paymentId) async {
    final querySnapshot = await firestore
        .collection(collectionName)
        .where('payment_id', isEqualTo: paymentId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return Reservation.fromJson(querySnapshot.docs.first.data());
    } else {
      throw Exception('Reservation not found');
    }
  }

  Future<Reservation> fetchReservation(String documentId) async {
    final docRef = firestore.collection(collectionName).doc(documentId);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      return Reservation.fromJson(docSnapshot.data()!);
    } else {
      throw Exception('Reservation not found');
    }
  }

  Future<void> updateReservation(String documentId, Reservation reservation) async {
    final docRef = firestore.collection(collectionName).doc(documentId);
    await docRef.update(reservation.toJson());
  }

  Future<String> createReservation(Reservation reservation) async {
    final docRef = await firestore.collection(collectionName).add(reservation.toJson());
    return docRef.id;
  }

  Future<void> deleteReservation(String documentId) async {
    final docRef = firestore.collection(collectionName).doc(documentId);
    await docRef.delete();
  }
}
