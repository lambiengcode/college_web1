import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomBarCart extends StatefulWidget {
  final int money;
  final String uid;
  final String orders;
  final index;
  BottomBarCart({
    this.money,
    this.index,
    this.orders,
    this.uid,
  });
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

  Future<void> _updateRoom(orders, index) async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(index);
      await transaction.update(index, {
        'orders': orders,
      });
    });
  }

  Future<void> _addToCart(orders) async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection("orders");
      await reference.add({
        'id': widget.uid,
        'publishAt': DateTime.now(),
        'orders': orders,
      });
    });
  }

  Future<void> _showMyDialog(money) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Comfirm checkout your cart?',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Your shopping cart is a total ' + moneyToString(money) + 'đ',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Back',
                style: TextStyle(
                  color: Colors.blueGrey.shade600,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 4.0,
            ),
            TextButton(
              child: Text(
                'I\'m Sure!',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                await _addToCart(widget.orders);
                await _updateRoom(
                    widget.uid +
                        DateTime.now().microsecondsSinceEpoch.toString(),
                    widget.index);
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.money > 0) {
          if (widget.money < 30000) {
            await _showMyDialog((widget.money + 5000).toString());
          } else {
            await _showMyDialog(widget.money.toString());
          }
        }
      },
      child: Container(
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
            widget.money == 0
                ? Container()
                : widget.money < 30000
                    ? Text(
                        '+ 5.000đ fee',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Icon(
                        Feather.arrow_right,
                        color: Colors.white,
                        size: 20.0,
                      ),
          ],
        ),
      ),
    );
  }
}
