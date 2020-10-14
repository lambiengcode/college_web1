import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import '../../widget/cart_widget/cart_card.dart';

class ProfilePage extends StatefulWidget {
  final int type;

  ProfilePage({this.type});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .92,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFABBAD5),
                  spreadRadius: .0,
                  blurRadius: .8,
                  offset: Offset(0, 1.0), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                  stream: Firestore.instance
                      .collection('users')
                      .where('id', isEqualTo: 'QxsZPTR5T3hJM8pbZhQHLVG6jKY2')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            snapshot.data.documents[0]['image'],
                          ),
                          radius: 20.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          snapshot.data.documents[0]['username'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    );
                  },
                ),
                StreamBuilder(
                  stream: Firestore.instance
                      .collection('carts')
                      .where('orders',
                          isEqualTo: 'QxsZPTR5T3hJM8pbZhQHLVG6jKY2')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tổng: 120000 VNĐ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 40.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 14.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.5)),
                          ),
                          child: Text(
                            'Tiến Hành Thanh Toán',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('carts')
                  .where('orders', isEqualTo: 'QxsZPTR5T3hJM8pbZhQHLVG6jKY2')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return CartCard();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
