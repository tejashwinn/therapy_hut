import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:therapy_hut/resources/auth_methods.dart';
import 'package:therapy_hut/resources/firestore_methods.dart';
import 'package:therapy_hut/resources/jitsi_meet_methods.dart';

class HistoryMeetingScreen extends StatefulWidget {
  const HistoryMeetingScreen({Key? key}) : super(key: key);

  @override
  State<HistoryMeetingScreen> createState() => _HistoryMeetingScreenState();
}

class _HistoryMeetingScreenState extends State<HistoryMeetingScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetingMethods = JitsiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  joinMeeting(BuildContext context, String roomNo, String subject) {
    _jitsiMeetingMethods.createMeeting(
        roomName: roomNo,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        username: _authMethods.user.displayName!,
        subject: subject);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireStoreMethods().meetingsHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () => joinMeeting(
              context,
              (snapshot.data! as dynamic).docs[index]['meetingName'].toString(),
              (snapshot.data! as dynamic)
                  .docs[index]['meetingSubject']
                  .toString(),
            ),
            title: Text(
              '${(snapshot.data! as dynamic).docs[index]['meetingSubject']}',
            ),
            subtitle: Text(
              'Session Id: ${(snapshot.data! as dynamic).docs[index]['meetingName']}\nJoined on: ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())} ${DateFormat.jm().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}',
            ),
            contentPadding: const EdgeInsets.all(8),
          ),
        );
      },
    );
  }
}
