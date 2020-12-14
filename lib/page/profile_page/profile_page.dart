import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_web/widget/history_widget/item_history.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  ProfilePage({this.uid});
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  String ordersID = '';
  String _username = '';
  String _phone = '';
  String _address = '';

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  String showMyPublishAt(Timestamp publishAt) {
    DateTime result = publishAt.toDate();
    String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(result);
    return formattedDate;
  }

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

  Future<void> _updateProfile(index, username, address, phone) async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(index);
      String un = snapshot['username'];
      String ph = snapshot['phone'];
      String ad = snapshot['address'];
      await transaction.update(index, {
        'username': username == '' ? un : username,
        'address': address == '' ? ad : address,
        'phone': phone == '' ? ph : phone,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: size.width * .22,
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('carts')
                      .where('orders', isEqualTo: ordersID)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return ItemHistory(
                          info: snapshot.data.docs[index],
                        );
                      },
                    );
                  },
                ),
              ),
              StreamBuilder(
                stream: Firestore.instance
                    .collection('carts')
                    .where('orders', isEqualTo: ordersID)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapCarts) {
                  if (!snapCarts.hasData) {
                    return Container(
                      height: 72.0,
                      color: Colors.blueAccent,
                    );
                  }

                  int sumOfAll = 0;

                  for (int i = 0; i < snapCarts.data.docs.length; i++) {
                    int temp = int.parse(snapCarts.data.docs[i]['price']) *
                        snapCarts.data.docs[i]['quantity'];
                    sumOfAll += temp;
                  }

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
                              moneyToString(sumOfAll.toString()) + 'đ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.5,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        sumOfAll == 0
                            ? Container()
                            : sumOfAll < 30000
                                ? Text(
                                    '+ 5.000đ fee',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Container(),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      // Disable opening the end drawer with a swipe gesture.
      endDrawerEnableOpenDragGesture: false,
      body: Container(
        height: size.height,
        width: size.width,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Form(
                key: _formKey,
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('users')
                      .where('id', isEqualTo: widget.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    return Column(
                      children: [
                        SizedBox(
                          height: 60.0,
                        ),
                        Container(
                          height: 160.0,
                          width: 160.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                            image: DecorationImage(
                              image:
                                  NetworkImage(snapshot.data.docs[0]['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 60.0,
                          ),
                          child: TextFormField(
                            maxLines: 1,
                            maxLength: 24,
                            initialValue: snapshot.data.docs[0]['username'],
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                            onChanged: (val) => _username = val.trim(),
                            validator: (val) =>
                                val.length == 0 ? 'Enter your username' : null,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 60.0,
                          ),
                          child: TextFormField(
                            enabled: false,
                            maxLines: 1,
                            maxLength: 24,
                            initialValue: snapshot.data.docs[0]['email'],
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.2,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 60.0,
                          ),
                          child: TextFormField(
                            maxLines: 1,
                            maxLength: 11,
                            initialValue: snapshot.data.docs[0]['phone'],
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                            onChanged: (val) => _phone = val.trim(),
                            validator: (val) => val.length != 10 &&
                                    val.length != 11
                                ? 'Phone number must be have 10 or 11 number'
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 60.0,
                          ),
                          child: TextFormField(
                            maxLines: 3,
                            initialValue: snapshot.data.docs[0]['address'],
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                            onChanged: (val) => _address = val.trim(),
                            validator: (val) =>
                                val.length == 0 ? 'Enter your address' : null,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              labelStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade600,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 32.0,
                                ),
                                child: Icon(
                                  Feather.arrow_left,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  await _updateProfile(
                                      snapshot.data.docs[0].reference,
                                      _username,
                                      _address,
                                      _phone);
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 140.0,
                                ),
                                child: const Text('Update',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.grey.shade400,
              thickness: 1.5,
              width: 1.5,
              indent: 100.0,
              endIndent: 60.0,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 60.0,
                    ),
                    child: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 60.0,
                      ),
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('orders')
                            .where('id', isEqualTo: widget.uid)
                            .orderBy('publishAt', descending: true)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }

                          return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ordersID =
                                        snapshot.data.docs[index]['orders'];
                                  });
                                  _openEndDrawer();
                                },
                                child: Container(
                                  width: 200.0,
                                  height: 54.0,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(
                                    left: 24.0,
                                    right: 24.0,
                                  ),
                                  margin: EdgeInsets.only(
                                    top: 12.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'id: ' +
                                                  snapshot.data.docs[index]
                                                      ['orders'],
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              'publishAt: ' +
                                                  showMyPublishAt(
                                                      snapshot.data.docs[index]
                                                          ['publishAt']),
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Feather.arrow_right,
                                        color: Colors.blueAccent,
                                        size: 18.0,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
