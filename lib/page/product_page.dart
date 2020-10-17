import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_web/style.dart';
import 'package:food_web/widget/item_card.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  final int kind;

  ProductPage({this.kind});

  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int kind = 1;

  @override
  void initState() {
    super.initState();
    kind = widget.kind;
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: _width,
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(context);
                    },
                    child: Container(
                      height: 52.0,
                      width: 52.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: purpleColor,
                      ),
                      child: Icon(
                        Feather.arrow_left,
                        color: Colors.white,
                        size: 28.0,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 88.0,
                  ),
                  Container(
                    height: _height * 0.11,
                    width: _width * 0.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(0xFFABBAD5),
                            blurRadius: 12.0,
                            offset: Offset(0, 6.0),
                            spreadRadius: 4.0,
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
                              height: _height * 0.11,
                              width: _width * 0.2,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              height: _height * 0.11,
                              width: _width * 0.2,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              height: _height * 0.11,
                              width: _width * 0.2,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                  Spacer(),
                  Container(
                    height: 48.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                      color: purpleColor,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Icon(
                              Feather.search,
                              color: Colors.white,
                              size: 22.0,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                          thickness: 2.0,
                          width: 2.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Icon(
                              Feather.shopping_cart,
                              color: Colors.white,
                              size: 22.0,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('items')
                      .where('kind', isEqualTo: kind)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    return GridView.builder(
                      padding: EdgeInsets.fromLTRB(60.0, 40.0, 24.0, 24.0),
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (_width / 360).round(),
                      ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          title: snapshot.data.documents[index]['name'],
                          image: snapshot.data.documents[index]['urlToImage'],
                          price: snapshot.data.documents[index]['price'],
                          type: snapshot.data.documents[index]['type'],
                          kind: widget.kind,
                          description: snapshot.data.documents[index]['desc'],
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
