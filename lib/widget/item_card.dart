import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../style.dart';

class ItemCard extends StatelessWidget {
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

  Future<void> _updateRoom(orders, index) async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(index);
      await transaction.update(index, {
        'orders': orders,
      });
    });
  }

  Future<void> _addToCart(uid, orders) async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection("carts");
      await reference.add({
        'id': uid,
        'name': title,
        'urlToImage': image,
        'kind': kind,
        'type': type,
        'price': price,
        'orders': orders,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    image: NetworkImage(image),
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
                "$price đ",
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
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('users')
                      .where('id', isEqualTo: HomePage.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    int length = snapshot.data.documents.length;

                    return length == 0
                        ? GestureDetector(
                            onTap: () {
                              if (HomePage.uid == '') {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => AuthenticatePage()));
                              } else {
                                print("lc");
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
                          )
                        : StreamBuilder(
                            stream: Firestore.instance
                                .collection('carts')
                                .where('id', isEqualTo: HomePage.uid)
                                .where('orders',
                                    isEqualTo: snapshot.data.documents[0]
                                        ['orders'])
                                .where('name', isEqualTo: title)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot1) {
                              if (!snapshot1.hasData) {
                                return Container();
                              }

                              int length1 = snapshot1.data.documents.length;

                              return GestureDetector(
                                onTap: () async {
                                  if (length1 == 0) {
                                    if (snapshot.data.documents[0]['orders'] ==
                                        '') {
                                      String orders = HomePage.uid +
                                          DateTime.now()
                                              .microsecondsSinceEpoch
                                              .toString();
                                      await _updateRoom(
                                        orders,
                                        snapshot.data.documents[0].reference,
                                      );
                                      await _addToCart(HomePage.uid, orders);
                                    } else {
                                      await _addToCart(
                                        HomePage.uid,
                                        snapshot.data.documents[0]['orders'],
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
                      title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      description,
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
}
