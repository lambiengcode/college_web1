import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_web/animation/fade_animation.dart';
import 'package:food_web/page/profile_page/profile_page.dart';
import 'package:food_web/widget/cart_widget/bottom_bar.dart';
import 'package:food_web/widget/cart_widget/item_cart.dart';

class DrawerLayout extends StatefulWidget {
  final String uid;
  DrawerLayout({this.uid});
  @override
  State<StatefulWidget> createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        FadeAnimation(
          0.2,
          StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .where('id', isEqualTo: widget.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return UserAccountsDrawerHeader(
                accountName: Text(
                  snapshot.data.docs[0]['username'],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                accountEmail: Text(
                  snapshot.data.docs[0]['email'],
                  style: TextStyle(color: Colors.white),
                ),
                otherAccountsPictures: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            uid: widget.uid,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(.2),
                      ),
                      child: Icon(
                        Feather.user,
                        size: 16.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                currentAccountPicture: GestureDetector(
                  child: Container(
                    height: size.width / 7,
                    width: size.width / 7,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: snapshot.data.docs[0]['image'] == ''
                              ? AssetImage('images/myimage.jpg')
                              : NetworkImage(snapshot.data.docs[0]['image']),
                          fit: BoxFit.cover,
                        ),
                        border:
                            Border.all(color: Color(0xFF2d3447), width: 0.6)),
                  ),
                ),
                decoration: new BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1519327232521-1ea2c736d34d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                        fit: BoxFit.cover)),
              );
            },
          ),
        ),
        Expanded(
          child: FadeAnimation(
            0.45,
            StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .where('id', isEqualTo: widget.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                return StreamBuilder(
                  stream: Firestore.instance
                      .collection('carts')
                      .where('orders',
                          isEqualTo: snapshot.data.docs[0]['orders'])
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapCarts) {
                    if (!snapCarts.hasData) {
                      return Container();
                    }

                    return snapCarts.data.docs.length == 0
                        ? Container(
                            child: Center(
                              child: Text('Empty Carts'),
                            ),
                          )
                        : ListView.builder(
                            itemCount: snapCarts.data.docs.length,
                            itemBuilder: (context, index) {
                              return ItemCart(
                                info: snapCarts.data.docs[index],
                              );
                            },
                          );
                  },
                );
              },
            ),
          ),
        ),
        StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .where('id', isEqualTo: widget.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            return StreamBuilder(
              stream: Firestore.instance
                  .collection('carts')
                  .where('orders', isEqualTo: snapshot.data.docs[0]['orders'])
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapCarts) {
                if (!snapCarts.hasData) {
                  return Container(
                    height: 72.0,
                    color: Colors.blueAccent,
                  );
                }

                int sumOfAll = 0;

                for (int i = 0; i < snapCarts.data.docs.length; i++) {
                  int temp = int.parse(snapCarts.data.docs[i]['price']) *
                      snapCarts.data.docs[i]['quantity'];
                  sumOfAll += temp;
                }

                return BottomBarCart(
                  money: sumOfAll,
                  index: snapshot.data.docs[0].reference,
                  orders: snapshot.data.docs[0]['orders'],
                  uid: widget.uid,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
