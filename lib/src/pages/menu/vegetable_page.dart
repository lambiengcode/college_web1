import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_web/src/widget/food_widget/vegetable_card.dart';

class VegetablePage extends StatefulWidget {
  final int kind;

  VegetablePage({this.kind});

  @override
  State<StatefulWidget> createState() => _VegetablePageState();
}

class _VegetablePageState extends State<VegetablePage> {
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

            return GridView.builder(
              padding: EdgeInsets.all(40.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (size.width / 360.0).round(),
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 36.0,
              ),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return FoodCard(
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
    );
  }
}
