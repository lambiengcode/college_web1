import 'package:flutter/material.dart';
import 'package:food_web/src/animation/fade_animation.dart';
import 'package:food_web/src/pages/auth/forgot_page.dart';
import 'package:food_web/src/pages/home_page.dart';
import 'package:food_web/src/service/auth.dart';
import 'package:food_web/src/widget/loading.dart';

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

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Container(
                    height: sizeHeight,
                    width: sizeWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * 0.3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FadeAnimation(
                                  1.7,
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(0.0),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            validator: (val) => val.length == 0
                                                ? 'Enter your Email'
                                                : null,
                                            onChanged: (val) =>
                                                email = val.trim(),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(left: 12.0),
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0,
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
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            focusNode: textFieldFocus,
                                            validator: (val) => val.length == 0
                                                ? 'Enter your password'
                                                : null,
                                            onChanged: (val) =>
                                                password = val.trim(),
                                            obscureText: hidePassword,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(left: 12.0),
                                              border: InputBorder.none,
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              FadeAnimation(
                                  1.7,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ResetPassword()));
                                        },
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                196, 135, 198, 1),
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 32,
                              ),
                              FadeAnimation(
                                1.9,
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                        });
                                      } else {
                                        Navigator.of(context).pop(context);
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FadeAnimation(
                                  2,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text("Don\'t have an account ?\t",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(.8),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                          )),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.toggleView();
                                          });
                                        },
                                        child: Text("Register now",
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 16.0,
                                            )),
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
                ),
              ],
            ),
          );
  }
}
