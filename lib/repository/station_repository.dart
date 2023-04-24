import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bts_cymkolor/models/station.dart';

class StationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStation(Station station) async {
    await _firestore.collection('stations').doc(station.stationCode).set(station.toJson());
  }

  Future<Station> getStation(String stationCode) async {
    final docRef = _firestore.collection("stations").doc(stationCode);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      return Station.fromJson(docSnapshot.data()!);
    } else {
      throw Exception('Reservation not found');
    }
  }

  Future<void> updateStation(Station station) async {
    await _firestore.collection('stations').doc(station.stationCode).update(station.toJson());
  }

  Future<void> deleteStation(String stationCode) async {
    await _firestore.collection('stations').doc(stationCode).delete();
  }

  Stream<List<Station>> getStations() {
    return _firestore.collection('stations').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Station.fromJson(doc.data())).toList();
    });
  }
}
