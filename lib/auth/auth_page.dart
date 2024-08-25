import 'package:flutter/material.dart';
import 'package:to_do_app_firebase/screens/login_page.dart';
import 'package:to_do_app_firebase/screens/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool a = true;

  void to() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return LoginPage(
        show: to,
      );
    } else {
      return SignupPage(
        show: to,
      );
    }
  }
}
