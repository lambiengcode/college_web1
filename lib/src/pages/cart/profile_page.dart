import 'package:flutter/material.dart';

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
      height: size.height * .9,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Text(
              "Giỏ hàng",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            alignment: Alignment.center,
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
