import 'dart:math';

import 'package:flutter/material.dart';
import 'package:therapy_hut/resources/jitsi_meet_methods.dart';

import '../widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});

  final JitsiMeetingMethods _jitsiMeetingMethods = JitsiMeetingMethods();
  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetingMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, "/video-call");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
                onPressed: createNewMeeting,
                text: "Create Group",
                icon: Icons.videocam),
            HomeMeetingButton(
                onPressed: () => joinMeeting(context),
                text: "Join Group",
                icon: Icons.add_box_rounded),
            HomeMeetingButton(
                onPressed: () {},
                text: "Schedule Therapy",
                icon: Icons.calendar_today),
            HomeMeetingButton(
                onPressed: () {},
                text: "Share Screen",
                icon: Icons.arrow_upward_rounded)
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              "Create or Join a Group Therapy Session.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
