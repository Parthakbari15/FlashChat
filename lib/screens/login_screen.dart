import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import '../componenets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
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
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldInputDecoration.copyWith(
                  hintText: "Enter Your Email"),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'Enter Your Password'),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 24.0),
            RoundedButton(
              title: "Log In",
              color: Colors.lightBlueAccent,
              onPressed: () async {
                try {
                  var validUser = await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  if (validUser.user != null) {
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
