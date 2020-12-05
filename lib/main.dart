import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';
import 'package:food_web/data.dart';
import 'package:food_web/page/auth/auth_page.dart';
import 'package:food_web/page/product.dart';
import 'package:food_web/page/product_page.dart';
import 'package:food_web/service/auth.dart';
import 'package:food_web/style.dart';
import 'package:food_web/widget/drawer.dart';
import 'package:food_web/widget/home_widget/carousel_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage | MyLife',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  static String uid = '';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int kind = 1;
  ScrollController _controller;
  final aboutKey = new GlobalKey();
  final productKey = new GlobalKey();
  final blogKey = new GlobalKey();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> uid;

  @override
  void initState() {
    //Initialize the  scrollController
    _controller = ScrollController();
    super.initState();
    uid = _prefs.then((SharedPreferences prefs) {
      _openEndDrawer();
      return prefs.getString('uid') != null ? prefs.getString('uid') : '';
    });
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controller.position.moveTo(dragUpdate.globalPosition.dy * .8);
    });
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: _width * .22,
        child: Drawer(
          child: FutureBuilder(
            future: uid,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container();
                default:
                  if (snapshot.hasError) {
                    return Container();
                  }

                  return DrawerLayout(
                    uid: snapshot.data,
                  );
              }
            },
          ),
        ),
      ),
      // Disable opening the end drawer with a swipe gesture.
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Color(0xc0c0c0),
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          width: _width,
          padding: EdgeInsets.symmetric(
            horizontal: 100,
            vertical: 20,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1528825871115-3581a5387919?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=658&q=80'),
                      radius: 18.0,
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      "MyLife",
                      style: TextStyle(
                        color: Colors.black.withOpacity(.85),
                        fontSize: 23.5,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
              ),
              Container(
                width: _width * 0.25,
                padding: EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()));
                      },
                      child: Text(
                        "Home",
                        style: kAppBarStyle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Scrollable.ensureVisible(productKey.currentContext);
                      },
                      child: Text(
                        "Own Product",
                        style: kAppBarStyle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Scrollable.ensureVisible(blogKey.currentContext);
                      },
                      child: Text(
                        "Blog",
                        style: kAppBarStyle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Scrollable.ensureVisible(aboutKey.currentContext);
                      },
                      child: Text(
                        "About us",
                        style: kAppBarStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: _width * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<String>(
                      future: uid,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return snapshot.data != ''
                                  ? StreamBuilder(
                                      stream: Firestore.instance
                                          .collection('users')
                                          .where('id', isEqualTo: snapshot.data)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snap) {
                                        if (!snap.hasData) {
                                          return Container();
                                        }

                                        return Container(
                                          child: IntrinsicHeight(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _openEndDrawer();
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 18.0,
                                                    backgroundColor:
                                                        Colors.blueAccent,
                                                    child: CircleAvatar(
                                                      radius: 16.0,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        snap.data.documents[0]
                                                            ['image'],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                VerticalDivider(
                                                  width: 24.0,
                                                  thickness: 2.0,
                                                  color:
                                                      Colors.blueGrey.shade400,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    AuthService _auth =
                                                        AuthService();
                                                    await _auth.signOut();
                                                    final SharedPreferences
                                                        prefs = await _prefs;
                                                    Future<String> _logout =
                                                        prefs
                                                            .setString(
                                                                'uid', '')
                                                            .then(
                                                                (bool success) {
                                                      return 'Log out success';
                                                    });
                                                    print('Log out');
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    HomePage()));
                                                  },
                                                  child: Text(
                                                    'Logout',
                                                    style: GoogleFonts.overpass(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .solid,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                  : Container(
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AuthenticatePage(
                                                      start: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "Login",
                                                style: kAppBarStyle,
                                              ),
                                            ),
                                            VerticalDivider(
                                              width: 24.0,
                                              thickness: 2.0,
                                              color: Colors.blueGrey.shade400,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AuthenticatePage(
                                                      start: false,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "SignUp",
                                                style: kAppBarStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            }
                        }
                      },
                    ),
                    Container(
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Feather.search,
                                color: kPrimaryColor,
                                size: 24.0,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            IconButton(
                              icon: Icon(
                                Feather.shopping_cart,
                                color: kPrimaryColor,
                                size: 24.0,
                              ),
                              onPressed: () {
                                _openEndDrawer();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _controller,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Column(
                        children: [
                          Container(
                            height: _height * 0.78,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60.0),
                                topRight: Radius.circular(400.0),
                              ),
                              color: Colors.blueAccent,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: _width * 0.08,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Find the Good\nFood For You",
                                            style: GoogleFonts.biryani(
                                              height: 1.3,
                                              fontSize: _width * 0.05,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "You can find vegetables, fruits and cakes here.\nAdd to cart the products you need to buy.",
                                            style: GoogleFonts.assistant(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: _width * .38,
                                  color: Colors.white,
                                  child: Container(
                                    child: CarouselImage(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: _width,
                            padding: EdgeInsets.only(
                              left: _width * 0.1,
                              top: _width * 0.055,
                              bottom: _width * 0.015,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffF0F1FA),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Find the product",
                                  style: GoogleFonts.hind(
                                    fontSize: 22.0,
                                    color: purpleColor,
                                  ),
                                ),
                                Container(
                                  height: 5.0,
                                  width: 50.0,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: purpleColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "20+ Products Available in\nOur Store",
                                      style: GoogleFonts.hind(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.w700,
                                        color: purpleColor,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductPage(
                                                      kind: kind,
                                                    )));
                                      },
                                      child: Text(
                                        "See All  ",
                                        style: GoogleFonts.hind(
                                          fontSize: 22,
                                          color: purpleColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: purpleColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: _width * 0.1,
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: _height * 0.02,
                                  ),
                                  height: _height * 0.46,
                                  child: Product(
                                    kind: kind,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: _width,
                            margin: EdgeInsets.symmetric(
                              horizontal: _width * 0.1,
                              vertical: _height * 0.05,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Card(
                                          key: blogKey,
                                          elevation: .0,
                                          child: Container(
                                            height: _height * .6,
                                            padding: EdgeInsets.all(20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.network(
                                                "https://images.unsplash.com/photo-1512223792601-592a9809eed4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.network(
                                                  "https://images.unsplash.com/photo-1572715376701-98568319fd0b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(height: 40),
                                              Container(
                                                width: _width * 0.12,
                                                height: _height * 0.35,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Image.network(
                                                    "https://images.unsplash.com/photo-1551218370-44f5d7748b18?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: _width * 0.05,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 5,
                                          width: 50,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: purpleColor,
                                          ),
                                        ),
                                        Text(
                                          "Blog & Forum",
                                          style: GoogleFonts.hind(
                                            height: 1.3,
                                            fontSize: 50,
                                            fontWeight: FontWeight.w700,
                                            color: purpleColor,
                                          ),
                                        ),
                                        Text(
                                          "Learn and share useful knowledge about healthy foods. Join us now so you don't miss a thing.",
                                          style: GoogleFonts.hind(
                                            fontSize: 22,
                                            color: purpleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Comming Soon  ",
                                              style: GoogleFonts.hind(
                                                fontSize: 20.0,
                                                color: purpleColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(
                                              Icons.star_border_purple500_sharp,
                                              color: purpleColor,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: _width,
                            padding: EdgeInsets.fromLTRB(
                              _width * .05,
                              _height * .08,
                              _width * .05,
                              _height * .04,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffEFE8DE),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sale Off",
                                  style: GoogleFonts.hind(
                                    fontSize: 22,
                                    color: purpleColor,
                                  ),
                                ),
                                Container(
                                  height: 5,
                                  width: 50,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: purpleColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Discounts up to 30%\nJust Today",
                                      style: GoogleFonts.hind(
                                        height: 1.3,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w700,
                                        color: purpleColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "See All  ",
                                      style: GoogleFonts.hind(
                                        fontSize: 22,
                                        color: purpleColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: purpleColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: _width * 0.1,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: _height * 0.04,
                                  ),
                                  height: _height * 0.46,
                                  child: Product(
                                    kind: kind,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: _height * 0.8,
                            padding: EdgeInsets.symmetric(
                              vertical: _height * 0.05,
                              horizontal: _width * 0.15,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Star(),
                                          Star(),
                                          Star(),
                                          Star(),
                                          Star(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _width * 0.03,
                                      ),
                                      Text(
                                          'Fast delivery, very fresh and delicious food. I will buy food from the store again.',
                                          style: GoogleFonts.hind(
                                            fontSize: 25,
                                            color: purpleColor,
                                            fontWeight: FontWeight.w700,
                                          )),
                                      SizedBox(
                                        height: _width * 0.03,
                                      ),
                                      Text(
                                        "Anonymous",
                                        style: GoogleFonts.hind(
                                          fontSize: 28,
                                          color: purpleColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Publish at July 25, 2020',
                                        style: GoogleFonts.hind(
                                          fontSize: 20.0,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    key: aboutKey,
                                    elevation: .0,
                                    child: Container(
                                      padding: EdgeInsets.all(60.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: Image.network(
                                          "https://firebasestorage.googleapis.com/v0/b/mychatbot-3277b.appspot.com/o/yYORHOso4ObCXLjWl4Dde6mNnRN2?alt=media&token=2adfb9b2-b6fc-436f-bf40-2283929936f1",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: _height * 0.76,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100.0),
                                topLeft: Radius.circular(100.0),
                              ),
                              color: Colors.black,
                            ),
                            padding: EdgeInsets.only(
                              left: _width * 0.1,
                              right: _width * 0.1,
                              top: _height * 0.1,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Heading(
                                            text: "POLICY",
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Titl(text: "Delivery Policy"),
                                          Titl(text: "Return Policy"),
                                          Titl(text: "FAQs"),
                                          Titl(text: "Contact us"),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Heading(
                                            text: "SOCIAL",
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Titl(text: "Facebook"),
                                          Titl(text: "Twitter"),
                                          Titl(text: "Youtube"),
                                          Titl(text: "Instagram"),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Heading(
                                            text: "HOTLINE",
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Titl(text: "Hà Nội:  +84989917877"),
                                          Titl(text: "Đà Nẵng: +84989917877"),
                                          Titl(
                                              text:
                                                  "Hồ Chí Minh:  +84989917877"),
                                          SizedBox(
                                            height: 40,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    bottom: 40.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.storeAlt,
                                        color: Colors.white,
                                        size: 40.0,
                                      ),
                                      Titl(
                                          text:
                                              "2020, All rights reserved by BigCityBoi")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: _height * 0.708,
                  left: _width * 0.1 + 100,
                  child: Card(
                    key: productKey,
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Container(
                      height: _height * 0.13,
                      width: _width * 0.69,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 30.0,
                              offset: Offset(0, 20),
                              spreadRadius: 6.0,
                            )
                          ]),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  kind = 1;
                                });
                              },
                              child: Container(
                                height: _height * 0.13,
                                width: _width * 0.23,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: kind == 1
                                      ? Color(0xfff0f1fa)
                                      : Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.carrot,
                                          color: purpleColor,
                                          size: kind == 1 ? 26.0 : 24.0,
                                        ),
                                        SizedBox(
                                          height: 14.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12.0),
                                    Text(
                                      "Vegetable",
                                      style: GoogleFonts.hind(
                                        fontSize: kind == 1 ? 24.0 : 22.5,
                                        fontWeight: FontWeight.w700,
                                        color: purpleColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  kind = 2;
                                });
                              },
                              child: Container(
                                height: _height * 0.13,
                                width: _width * 0.23,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: kind == 2
                                      ? Color(0xfff0f1fa)
                                      : Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.appleAlt,
                                          color: purpleColor,
                                          size: kind == 2 ? 26.0 : 24.0,
                                        ),
                                        SizedBox(
                                          height: 14.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12.0),
                                    Text(
                                      "Fruit",
                                      style: GoogleFonts.hind(
                                        fontSize: kind == 2 ? 24.0 : 22.5,
                                        fontWeight: FontWeight.w700,
                                        color: purpleColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  kind = 3;
                                });
                              },
                              child: Container(
                                height: _height * 0.13,
                                width: _width * 0.23,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: kind == 3
                                      ? Color(0xfff0f1fa)
                                      : Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.birthdayCake,
                                          color: purpleColor,
                                          size: kind == 3 ? 26.0 : 24.0,
                                        ),
                                        SizedBox(
                                          height: 14.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12.0),
                                    Text(
                                      "Cake",
                                      style: GoogleFonts.hind(
                                        fontSize: kind == 3 ? 24.0 : 22.5,
                                        fontWeight: FontWeight.w700,
                                        color: purpleColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          FlutterWebScroller(
            //Pass a reference to the ScrollCallBack function into the scrollbar
            scrollCallBack,

            //Add optional values
            scrollBarBackgroundColor: Colors.grey.shade100.withOpacity(.5),
            scrollBarWidth: 24.0,
            dragHandleColor: Colors.black.withOpacity(.1),
            dragHandleBorderRadius: 0.0,
            dragHandleHeight: 48.0,
            dragHandleWidth: 24.0,
          ),
        ],
      ),
    );
  }
}
