import 'package:flutter/material.dart';
import 'package:food_web/src/constant/constant.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Function press;
  const MenuItem({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
              color: kTextColor.withOpacity(.65),
              fontWeight: FontWeight.bold,
              fontSize: 14.6),
        ),
      ),
    );
  }
}
