import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  final String title;
  final String price;
  final String urlToImage;
  final int quantity;

  CartCard({this.title, this.price, this.urlToImage, this.quantity});

  @override
  State<StatefulWidget> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [],
      ),
    );
  }
}
