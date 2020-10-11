import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_web/src/app.dart';
import 'package:food_web/src/pages/auth/auth_page.dart';
import 'package:food_web/src/pages/menu/menu_page.dart';
import '../home_widget/menu_item.dart';
import '../home_widget/custom_button.dart';

class CustomAppBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      padding: EdgeInsets.only(left: 24.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 5.0,
            spreadRadius: .5,
            color: Colors.black.withOpacity(.25)),
      ]),
      child: Row(
        children: <Widget>[
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
                fontSize: 24.6,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          Spacer(),
          MenuItem(
            title: "Rau củ",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MenuPage(
                        type: 2,
                      )));
            },
          ),
          MenuItem(
            title: "Trái cây",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MenuPage(
                        type: 3,
                      )));
            },
          ),
          MenuItem(
            title: "Bánh ngọt",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MenuPage(
                        type: 4,
                      )));
            },
          ),
          MenuItem(
            title: "Blog",
            press: () {},
          ),
          MenuItem(
            title: "Giới thiệu",
            press: () {},
          ),
          SizedBox(
            width: 12.0,
          ),
          StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .where('id', isEqualTo: App.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              int length = snapshot.data.documents.length;

              return length == 0
                  ? DefaultButton(
                      text: "Đăng nhập",
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AuthenticatePage()));
                      },
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1528825871115-3581a5387919?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=658&q=80'),
                      radius: 20.0,
                      backgroundColor: Colors.transparent,
                    );
            },
          ),
        ],
      ),
    );
  }
}
