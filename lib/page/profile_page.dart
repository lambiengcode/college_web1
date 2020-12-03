import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  ProfilePage({this.uid});
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Row(
          children: [
            Expanded(
              flex: 1,
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
                            image: NetworkImage(snapshot.data.docs[0]['image']),
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
                          Container(
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
                        ],
                      ),
                    ],
                  );
                },
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
                    height: 100.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 60.0,
                    ),
                    child: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 36.0,
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
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }

                          return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return Container();
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
