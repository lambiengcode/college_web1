import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemHistory extends StatefulWidget {
  final DocumentSnapshot info;
  ItemHistory({this.info});
  @override
  State<StatefulWidget> createState() => _ItemHistoryState();
}

class _ItemHistoryState extends State<ItemHistory> {
  bool pressed = false;

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

  switchStatus() {
    setState(() {
      pressed = !pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      padding: EdgeInsets.fromLTRB(16.0, 12.0, 10.0, 12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 1.25,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(widget.info['urlToImage']),
            radius: 35.0,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.info['name'],
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Text(
                      moneyToString((int.parse(widget.info['price']) *
                                  widget.info['quantity'])
                              .toString()) +
                          'đ' +
                          ' x ${widget.info['quantity']}',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                widget.info['kind'] == 3
                    ? Text(
                        'Note: ' + widget.info['note'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
