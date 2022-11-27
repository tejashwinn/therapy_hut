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

  Stream get groupsActive => _firestore
      .collection('groups')
      .orderBy("createdAt", descending: true)
      .limit(15)
      .snapshots();

  void addToMeetingHistory(String meetingName, String meetingSubject) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection("meetings")
          .add({
        "meetingName": meetingName,
        "createdAt": DateTime.now(),
        "meetingSubject": meetingSubject,
      });

      await _firestore.collection('groups').add({
        "meetingSubject": meetingSubject,
        "meetingName": meetingName,
        "createdAt": DateTime.now(),
        "createdBy": _auth.currentUser!.displayName,
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
