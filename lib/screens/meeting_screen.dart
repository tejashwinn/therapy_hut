import 'package:flutter/material.dart';
import 'package:therapy_hut/utils/get_quote.dart';
import 'package:therapy_hut/utils/quote.dart';
import '../widgets/home_meeting_button.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, "/video-call");
  }

  createNewMeeting(BuildContext context) {
    Navigator.pushNamed(context, "/video-new-call");
  }

  late Future<Quote> randomQuote;

  @override
  void initState() {
    super.initState();
    randomQuote = fetchQuote();
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
                text: "Create Group",
                icon: Icons.videocam),
            HomeMeetingButton(
                onPressed: () => joinMeeting(context),
                text: " Join Group",
                icon: Icons.add_box_rounded),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Quote>(
                future: randomQuote,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "${snapshot.data!.quote} - ${snapshot.data!.author}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Create or Join a Group Therapy Session.}",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              // const Center(
              //   child: Text(
              //     "Create or Join a Group Therapy Session.}",
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              Center(
                child:
                    Image.asset("assests/images/login_bg_group_therapy-v2.png"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
