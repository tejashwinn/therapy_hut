import 'package:flutter/material.dart';
import 'package:therapy_hut/resources/auth_methods.dart';
import 'package:therapy_hut/utils/measurements.dart';
import 'package:therapy_hut/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Create or start a therapy session",
          style:
              TextStyle(fontSize: cTextSize * 1.5, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: cPadding),
          child: Image.asset("assests/images/login_bg_group_therapy-v2.png"),
        ),
        CustomButton(
          text: "Sign Up",
          onPressed: () async {
            bool res = await _authMethods.signInWithGOogle(context);
            if (res) {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, "/home");
            }
          },
        ),
        CustomButton(
          text: "Sign In",
          onPressed: () async {
            bool res = await _authMethods.signInWithGOogle(context);
            if (res) {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, "/home");
            }
          },
        )
      ],
    ));
  }
}
