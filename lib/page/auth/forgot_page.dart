import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_web/animation/fade_animation.dart';
import 'package:food_web/service/auth.dart';
import 'package:food_web/widget/loading.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String email;
  bool loading = false;

  void _sendRequest() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await _auth.sendPasswordResetEmail(email);
      if (result == null) {
        setState(() {
          loading = false;
        });
      } else {}
      Navigator.of(context).pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: sizeHeight,
              width: sizeWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeWidth * .36,
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
                                      color: Colors.lightBlueAccent,
                                      width: .5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromRGBO(196, 135, 198, .3),
                                        blurRadius: 2.5,
                                        spreadRadius: 2.5,
                                        offset: Offset(0, 2.5),
                                      )
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        validator: (val) => val.length == 0
                                            ? 'Enter email'
                                            : null,
                                        onFieldSubmitted: (val) =>
                                            _sendRequest(),
                                        onChanged: (val) => email = val.trim(),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          FadeAnimation(
                            .25,
                            GestureDetector(
                              onTap: () async {
                                _sendRequest();
                              },
                              child: Container(
                                height: 52.0,
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
                                        "Request",
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
                                      Feather.send,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
