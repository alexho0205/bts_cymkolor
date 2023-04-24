import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Plan2.dart';

class TourRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addTour(Tour tour) async {
    await _firestore.collection('plans2').doc(tour.id).set(tour.toJson());
  }

  Stream<List<Tour>> getTour(String id) {
    return _firestore.collection('plans2').snapshots().map(
          (snapshot) => snapshot.docs
          .map(
              (doc) => Tour.fromJson(doc.data() as Map<String, dynamic>)
      ).toList(),
    );
  }

  Future<void> updateTour(Tour tour) async {
    await _firestore.collection('plans2').doc(tour.id).update(tour.toJson());
  }

  Future<void> deleteTour(String id) async {
    await _firestore.collection('plans2').doc(id).delete();
  }

  Stream<List<Tour>> getTours() {
    return _firestore.collection('plans2').snapshots().map(
          (snapshot) => snapshot.docs
          .map(
              (doc) => Tour.fromJson(doc.data() as Map<String, dynamic>)
      ).toList(),
    );
  }
}