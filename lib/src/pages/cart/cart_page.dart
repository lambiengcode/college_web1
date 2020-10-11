import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_web/src/app.dart';
import 'package:food_web/src/widget/cart_widget/cart_card.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .where('id', isEqualTo: App.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('carts')
              .where('orders', isEqualTo: snapshot.data.documents[0]['orders'])
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
            if (!snapshot1.hasData) {
              return Container();
            }

            int length = snapshot1.data.documents.length;

            return length == 0
                ? Container(
                    child: Center(
                      child: Text("Giỏ hàng của bạn hiện đang rỗng"),
                    ),
                  )
                : Container(
                    child: Column(
                      children: [],
                    ),
                  );
          },
        );
      },
    );
  }
}
