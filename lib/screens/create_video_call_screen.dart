import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:therapy_hut/resources/auth_methods.dart';
import 'package:therapy_hut/resources/jitsi_meet_methods.dart';
import 'package:therapy_hut/utils/colors.dart';
import 'package:therapy_hut/widgets/custom_button.dart';
import 'package:therapy_hut/widgets/meeting_option.dart';

class CreateVideoCallScreen extends StatefulWidget {
  const CreateVideoCallScreen({super.key});

  @override
  State<CreateVideoCallScreen> createState() => _CreateVideoCallScreenState();
}

class _CreateVideoCallScreenState extends State<CreateVideoCallScreen> {
  late TextEditingController meetingSubjectController;
  late TextEditingController nameCotroller;

  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetingMethods = JitsiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingSubjectController = TextEditingController(text: "");
    nameCotroller = TextEditingController(
      text: _authMethods.user.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingSubjectController.dispose();
    nameCotroller.dispose();
    JitsiMeet.removeAllListeners();
  }

  _createNewMeeting() {
    var random = Random();
    _jitsiMeetingMethods.createMeeting(
        roomName: (random.nextInt(10000000) + 10000000).toString(),
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        username: nameCotroller.text,
        subject: meetingSubjectController.text);
  }

  _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Subject Cannot be empty."),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Create a Group Therapy Session",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingSubjectController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  border: InputBorder.none,
                  hintText: "Enter the Subject",
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameCotroller,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: "Enter your display name",
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Create",
            // onPressed: meetingSubjectController.text.isEmpty
            // ? _showError
            // : _createNewMeeting,
            onPressed: _createNewMeeting,
          ),
          const SizedBox(height: 50),
          MeetingOption(
            text: "Mute Audio",
            isMute: isAudioMuted,
            onChange: onAudioMuted,
          ),
          MeetingOption(
            text: "Turn off Video",
            isMute: isVideoMuted,
            onChange: onVideoMuted,
          ),
        ],
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
