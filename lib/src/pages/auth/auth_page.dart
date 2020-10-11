import 'package:flutter/material.dart';
import 'package:food_web/src/pages/auth/login_page.dart';
import 'package:food_web/src/pages/auth/register_page.dart';

class AuthenticatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn == true
        ? LoginPage(
            toggleView: toggleView,
          )
        : RegisterPage(
            toggleView: toggleView,
          );
  }
}
