import 'package:flutter/material.dart';
import '../widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, "/video-call");
  }

  createNewMeeting(BuildContext context) {
    Navigator.pushNamed(context, "/video-new-call");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
                onPressed: () => createNewMeeting(context),
                text: "Create\nGroup",
                icon: Icons.videocam),
            HomeMeetingButton(
                onPressed: () => joinMeeting(context),
                text: "Join\nGroup",
                icon: Icons.add_box_rounded),
            HomeMeetingButton(
                onPressed: () {},
                text: "Schedule\nTherapy",
                icon: Icons.calendar_today),
            HomeMeetingButton(
                onPressed: () {},
                text: "Share\nScreen",
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
