import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_web/page/auth/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../style.dart';

class ItemCard extends StatefulWidget {
  final String title;
  final String ingredient;
  final String image;
  final String price;
  final String sale;
  final String description;
  final int type;
  final int kind;

  const ItemCard({
    Key key,
    this.title,
    this.ingredient,
    this.image,
    this.sale,
    this.price,
    this.description,
    this.type,
    this.kind,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> uid;

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
      CollectionReference reference = Firestore.instance.collection("carts");
      await reference.add({
        'name': widget.title,
        'urlToImage': widget.image,
        'kind': widget.kind,
        'type': widget.type,
        'price': widget.price,
        'orders': orders,
        'quantity': 1,
        'note': '',
      });
    });
  }

  @override
  void initState() {
    super.initState();
    uid = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('uid') != null ? prefs.getString('uid') : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: uid,
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.waiting:
            return Container();
          default:
            if (snap.hasError) {
              return Container();
            }

            return GestureDetector(
              child: Container(
                height: 345,
                width: 380,
                child: Stack(
                  children: <Widget>[
                    // Big light background
                    Positioned(
                      left: 36.0,
                      top: 16.0,
                      child: Container(
                        height: 325,
                        width: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: kPrimaryColor.withOpacity(.065),
                        ),
                      ),
                    ),
                    // Rounded background
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        height: 182,
                        width: 182,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor.withOpacity(.16),
                        ),
                      ),
                    ),
                    // Food Image
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Price
                    Positioned(
                      left: 210.0,
                      top: 100.0,
                      child: Text(
                        moneyToString(widget.price.toString()) + "đ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                        left: 265,
                        top: 4,
                        child: snap.data == '' || snap.data == null
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AuthenticatePage(
                                        start: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 48.0,
                                  width: 48.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kPrimaryColor,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  alignment: Alignment.center,
                                ),
                              )
                            : StreamBuilder(
                                stream: Firestore.instance
                                    .collection('users')
                                    .where('id', isEqualTo: snap.data)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }

                                  return StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('carts')
                                        .where('orders',
                                            isEqualTo: snapshot.data.docs[0]
                                                ['orders'])
                                        .where('name', isEqualTo: widget.title)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            snapshot1) {
                                      if (!snapshot1.hasData) {
                                        return Container();
                                      }

                                      int length1 = snapshot1.data.docs.length;

                                      return GestureDetector(
                                        onTap: () async {
                                          if (length1 == 0) {
                                            if (snapshot.data.docs[0]
                                                    ['orders'] ==
                                                '') {
                                              String orders = snap.data +
                                                  DateTime.now()
                                                      .microsecondsSinceEpoch
                                                      .toString();
                                              await _updateRoom(
                                                orders,
                                                snapshot.data.documents[0]
                                                    .reference,
                                              );
                                              await _addToCart(orders);
                                            } else {
                                              await _addToCart(
                                                snapshot.data.docs[0]['orders'],
                                              );
                                            }
                                          } else {
                                            print('already');
                                          }
                                        },
                                        child: Container(
                                          height: 48.0,
                                          width: 48.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kPrimaryColor,
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 24.0,
                                          ),
                                          alignment: Alignment.center,
                                        ),
                                      );
                                    },
                                  );
                                },
                              )),

                    Positioned(
                      top: 210.0,
                      left: 55.0,
                      child: Container(
                        width: 220.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              widget.description,
                              maxLines: 3,
                              style: TextStyle(
                                color: kTextColor.withOpacity(.65),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
