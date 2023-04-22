import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bts_cymkolor/models/ticket.dart';

class TicketsRepository {
  final CollectionReference _ticketsCollection =
  FirebaseFirestore.instance.collection('tickets');

  Future<void> addTicket(Ticket ticket) async {
    await _ticketsCollection.add(ticket.toMap());
  }

  Future<void> updateTicket(Ticket ticket) async {
    await _ticketsCollection.doc(ticket.id).update(ticket.toMap());
  }

  Future<void> deleteTicket(String id) async {
    await _ticketsCollection.doc(id).delete();
  }

  Stream<List<Ticket>> getTicketsStream() {
    return _ticketsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Ticket.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<Ticket> getTicketById(String id) async {
    final snapshot = await _ticketsCollection.doc(id).get();
    return Ticket.fromMap(snapshot.data() as Map<String, dynamic>);
  }
}
