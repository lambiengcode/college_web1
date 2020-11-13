import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_web/page/auth/login_page.dart';
import 'package:food_web/page/auth/signup_page.dart';

class AuthenticatePage extends StatefulWidget {
  final bool start;
  AuthenticatePage({this.start});
  @override
  State<StatefulWidget> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  bool showSignIn = true;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();

    showSignIn = widget.start;
  }

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
        : SignupPage(
            toggleView: toggleView,
          );
  }
}
