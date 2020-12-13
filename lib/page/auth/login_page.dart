import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_web/animation/fade_animation.dart';
import 'package:food_web/main.dart';
import 'package:food_web/page/auth/forgot_page.dart';
import 'package:food_web/service/auth.dart';
import 'package:food_web/widget/loading.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleView;

  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  FocusNode textFieldFocus = FocusNode();
  String email = '';
  String password = '';

  bool hidePassword = true;
  bool loading = false;

  hideKeyboard() => textFieldFocus.unfocus();

  void login(String t) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
      if (result == null) {
        setState(() {
          loading = false;
        });
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;

    return loading
        ? Loading()
        : Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: sizeHeight / 3.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 60.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                            .2,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1.2,
                                  )),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      validator: (val) => val.length == 0
                                          ? 'Enter your Email'
                                          : null,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (val) => email = val.trim(),
                                      onFieldSubmitted: login,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 12.0,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      focusNode: textFieldFocus,
                                      validator: (val) => val.length == 0
                                          ? 'Enter your password'
                                          : null,
                                      onFieldSubmitted: login,
                                      onChanged: (val) => password = val.trim(),
                                      obscureText: hidePassword,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 12.0,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 16.0,
                        ),
                        FadeAnimation(
                            .225,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPage()));
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color.fromRGBO(196, 135, 198, 1),
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 28.0,
                        ),
                        FadeAnimation(
                          .25,
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                  });
                                } else {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomePage()));
                                }
                              }
                            },
                            child: Container(
                              height: 55.0,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 2.5,
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Icon(
                                    Feather.arrow_right,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        FadeAnimation(
                            .3,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Don\'t have an account ? ",
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0)),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.toggleView();
                                    });
                                  },
                                  child: Text("SignUp",
                                      style: TextStyle(
                                          color: Colors.blue[500],
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          fontSize: 16.0)),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
