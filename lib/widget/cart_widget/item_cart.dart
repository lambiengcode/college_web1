import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ItemCart extends StatefulWidget {
  final DocumentSnapshot info;
  ItemCart({this.info});
  @override
  State<StatefulWidget> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
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

  Future<void> _update(int value) async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.info.reference);
      int quantity = snapshot['quantity'];
      await transaction.update(widget.info.reference, {
        'quantity': quantity + value,
      });
    });
  }

  Future<void> _updateNote(String value) async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await transaction.update(widget.info.reference, {
        'note': value,
      });
    });
  }

  Future<void> _delete() async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await transaction.delete(widget.info.reference);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        24.0,
        8.0,
        8.0,
        8.0,
      ),
      padding: EdgeInsets.fromLTRB(
        16.0,
        16.0,
        10.0,
        16.0,
      ),
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
                    Container(
                      height: 28.0,
                      width: 96.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.2,
                        ),
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () async {
                                if (pressed == false) {
                                  if (widget.info['quantity'] == 1) {
                                    print('me');
                                  } else {
                                    switchStatus();
                                    await _update(-1)
                                        .whenComplete(() => switchStatus());
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(
                                      8.0,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Feather.minus,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                widget.info['quantity'].toString(),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () async {
                                if (pressed == false) {
                                  if (widget.info['quantity'] == 10) {
                                    print('me');
                                  } else {
                                    switchStatus();
                                    await _update(1)
                                        .whenComplete(() => switchStatus());
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(
                                      8.0,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Feather.plus,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      moneyToString((int.parse(widget.info['price']) *
                                  widget.info['quantity'])
                              .toString()) +
                          'đ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                widget.info['kind'] == 3
                    ? Container(
                        height: 48.0,
                        child: TextFormField(
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                          onFieldSubmitted: (val) => _updateNote(val),
                          initialValue: widget.info['note'],
                          decoration: InputDecoration(
                              hintText: 'Note',
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.2,
                                ),
                              )),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.grey.shade800,
              size: 18.0,
            ),
            onPressed: () async {
              await _delete();
            },
          ),
        ],
      ),
    );
  }
}
