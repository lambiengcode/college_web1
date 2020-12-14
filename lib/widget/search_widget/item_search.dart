import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_web/page/auth/auth_page.dart';
import 'package:food_web/style.dart';

class ItemSearch extends StatefulWidget {
  final DocumentSnapshot info;
  final String uid;
  ItemSearch({
    this.info,
    this.uid,
  });
  @override
  State<StatefulWidget> createState() => _ItemSearchState();
}

class _ItemSearchState extends State<ItemSearch> {
  Future<void> _addToCart(orders) async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection("carts");
      await reference.add({
        'name': widget.info['name'],
        'urlToImage': widget.info['urlToImage'],
        'kind': widget.info['kind'],
        'price': widget.info['price'],
        'orders': orders,
        'quantity': 1,
        'note': '',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .22,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
              12.0,
              14.0,
              24.0,
              6.0,
            ),
            padding: EdgeInsets.fromLTRB(
              12.0,
              24.0,
              8.0,
              24.0,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(.08),
              borderRadius: BorderRadius.circular(
                16.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.info['urlToImage']),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.info['name'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        widget.info['desc'],
                        maxLines: 2,
                        style: TextStyle(
                          color: kTextColor.withOpacity(.65),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 8.0,
            top: 0.0,
            child: widget.uid == ''
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
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                      ),
                      child: Icon(
                        Feather.plus,
                        color: Colors.white,
                        size: 16.0,
                      ),
                      alignment: Alignment.center,
                    ),
                  )
                : StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .where('id', isEqualTo: widget.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueAccent,
                          ),
                          child: Icon(
                            Feather.plus,
                            color: Colors.white,
                            size: 16.0,
                          ),
                          alignment: Alignment.center,
                        );
                      }

                      return StreamBuilder(
                        stream: Firestore.instance
                            .collection('orders')
                            .where('orders',
                                isEqualTo: snapshot.data.docs[0]['orders'])
                            .where('name', isEqualTo: widget.info['name'])
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snaps) {
                          if (!snaps.hasData) {
                            return Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blueAccent,
                              ),
                              child: Icon(
                                Feather.plus,
                                color: Colors.white,
                                size: 16.0,
                              ),
                              alignment: Alignment.center,
                            );
                          }

                          return GestureDetector(
                            onTap: () async {
                              print(snapshot.data.docs[0]['orders']);
                              if (snaps.data.docs.length == 0) {
                                await _addToCart(
                                    snapshot.data.docs[0]['orders']);
                              }
                            },
                            child: Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blueAccent,
                              ),
                              child: Icon(
                                Feather.plus,
                                color: Colors.white,
                                size: 16.0,
                              ),
                              alignment: Alignment.center,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
