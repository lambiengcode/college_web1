import 'package:flutter/material.dart';
import 'package:food_web/animation/fade_animation.dart';
import 'package:food_web/service/auth.dart';
import 'package:food_web/widget/loading.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback toggleView;

  SignupPage({this.toggleView});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  FocusNode textFieldFocus = FocusNode();
  String email = '';
  String password = '';
  String phone = '';

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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: sizeHeight / 2.8,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * 0.3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),
                              FadeAnimation(
                                  1.7,
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                        width: 1.2,
                                      ),
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
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            validator: (val) => val.length == 0
                                                ? 'Enter your Email'
                                                : null,
                                            onChanged: (val) =>
                                                email = val.trim(),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                left: 12.0,
                                              ),
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
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
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            validator: (val) => val.length < 6
                                                ? 'Password least 6 characters'
                                                : null,
                                            onChanged: (val) =>
                                                password = val.trim(),
                                            obscureText: hidePassword,
                                            focusNode: textFieldFocus,
                                            textAlign: TextAlign.justify,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                left: 12.0,
                                              ),
                                              border: InputBorder.none,
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          padding: EdgeInsets.all(8),
                                          child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            validator: (val) => val != password
                                                ? 'Those passwords didn\'t match. Try again.'
                                                : null,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                left: 12.0,
                                              ),
                                              border: InputBorder.none,
                                              hintText: "Confirm Password",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24.0,
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
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            onChanged: (val) =>
                                                phone = val.trim(),
                                            validator: (val) =>
                                                val.trim().length < 10 ||
                                                        val.trim().length > 11
                                                    ? 'Phone Number'
                                                    : null,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                left: 12.0,
                                              ),
                                              border: InputBorder.none,
                                              hintText: "Phone Number",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                            .registerWithEmailAndPassword(
                                                email, password, phone);
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
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              FadeAnimation(
                                  2,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Already have an account ? ",
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.0)),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.toggleView();
                                          });
                                        },
                                        child: Text("Login now",
                                            style: TextStyle(
                                                color: Colors.blue[500],
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 20.0)),
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
