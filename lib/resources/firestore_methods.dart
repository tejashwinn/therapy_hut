import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingsHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection("meetings")
      .orderBy("createdAt", descending: true)
      .snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> get groupsActive =>
      _firestore.collection('groups').snapshots();

  void addToMeetingHistory(String meetingName, String meetingSubject) async {
    try {
      final now = DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection("meetings")
          .add({
        "meetingName": meetingName,
        "createdAt": now,
        "meetingSubject": meetingSubject,
      });
      await _firestore.collection('groups').add({
        "meetingSubject": meetingSubject,
        "meetingName": meetingName,
        "createdAt": now,
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
