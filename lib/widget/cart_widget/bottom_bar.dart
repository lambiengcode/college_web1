import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomBarCart extends StatefulWidget {
  final int money;
  BottomBarCart({this.money});
  @override
  State<StatefulWidget> createState() => _BottomBarCartState();
}

class _BottomBarCartState extends State<BottomBarCart> {
  moneyToString(String money) {
    String result = '';
    int count = 0;
    for (int i = money.length - 1; i >= 0; i--) {
      if (count == 3) {
        count = 1;
        result += '.';
      } else {
        count++;
      }
      result += money[i];
    }
    String need = '';
    for (int i = result.length - 1; i >= 0; i--) {
      need += result[i];
    }
    return need;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      color: Colors.blueAccent,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                moneyToString(widget.money.toString()) + 'đ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          widget.money < 30000
              ? Text(
                  'Least orders 30.000đ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : IconButton(
                  icon: Icon(
                    Feather.arrow_right,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  onPressed: () {},
                ),
        ],
      ),
    );
  }
}
