import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bts_cymkolor/models/Plan.dart';

class PlanRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createPlan(Plan plan) async {
    try {
      await _firebaseFirestore.collection('plans').add(plan.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Plan>> getPlans() {
    return _firebaseFirestore.collection('plans').snapshots().map(
          (snapshot) => snapshot.docs
          .map(
              (doc) => Plan.fromMap(doc.data() as Map<String, dynamic>)
      ).toList(),
    );
  }

  Future<void> updatePlan(Plan plan) async {
    try {
      await _firebaseFirestore
          .collection('plans')
          .doc(plan.id)
          .update(plan.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deletePlan(String id) async {
    try {
      await _firebaseFirestore.collection('plans').doc(id).delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
