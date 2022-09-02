import 'package:flash_chat/constants.dart';
import './chat_screen.dart';
import 'package:flutter/material.dart';
import '../componenets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String name = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: "logo",
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(height: 48.0),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              onChanged: (value) => name = value,
              decoration: kTextFieldInputDecoration.copyWith(
                  hintText: "Enter Your Nickname"),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 48.0),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
              decoration: kTextFieldInputDecoration.copyWith(
                  hintText: "Enter Your Email"),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) => password = value,
              decoration: kTextFieldInputDecoration.copyWith(
                hintText: "Enter Your Password",
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 24.0),
            RoundedButton(
              title: "Register",
              color: Colors.blueAccent,
              onPressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  if (newUser.user != null) {
                    await newUser.user?.updateDisplayName(name);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      ChatScreen.id,
                      (route) => false,
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
