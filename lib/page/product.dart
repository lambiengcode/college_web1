import 'package:food_web/widget/item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final int kind;

  Product({this.kind});

  @override
  State<StatefulWidget> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: StreamBuilder(
          stream: Firestore.instance
              .collection('items')
              .where('kind', isEqualTo: widget.kind)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ItemCard(
                  title: snapshot.data.documents[0]['name'],
                  image: snapshot.data.documents[0]['urlToImage'],
                  price: snapshot.data.documents[0]['price'],
                  type: snapshot.data.documents[0]['type'],
                  kind: widget.kind,
                  description: snapshot.data.documents[0]['desc'],
                );
              },
            );
          }),
    );
  }
}
