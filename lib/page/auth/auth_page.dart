import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
  var _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1518843875459-f738682238a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1926&q=80',
    'https://images.unsplash.com/photo-1567174676466-f42097e4d5e6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1491&q=80',
    'https://images.unsplash.com/photo-1578985545062-69928b1d9587?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1588195538326-c5b1e9f80a1b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1558364015-0d5ba7a4ba86?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  void changePostion(int i) {
    setState(() {
      if (_current == 4 && i == 1) {
        _current = 0;
      } else if (_current == 0 && i == -1) {
        _current = 4;
      } else {
        _current += i;
      }
    });
  }

  @override
  void initState() {
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.grey.shade600,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .2,
          vertical: size.height * .1,
        ),
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: showSignIn
                      ? LoginPage(
                          toggleView: toggleView,
                        )
                      : SignupPage(
                          toggleView: toggleView,
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height,
                        aspectRatio: 1 / 1,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: imgList.map((imgUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imgList[_current]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Positioned(
                      bottom: 80.0,
                      child: Container(
                        width: size.width * .3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(imgList, (index, url) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _current = index;
                                });
                              },
                              child: Container(
                                width: _current == index ? 32.0 : 18.0,
                                height: _current == index ? 11.0 : 10.5,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                  color: _current == index
                                      ? Colors.white
                                      : Colors.white.withOpacity(.9),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: Icon(
                              Feather.arrow_left,
                              size: 25.0,
                            ),
                            onPressed: () {
                              changePostion(-1);
                            },
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: Icon(
                              Feather.arrow_right,
                              size: 25.0,
                            ),
                            onPressed: () {
                              changePostion(1);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
