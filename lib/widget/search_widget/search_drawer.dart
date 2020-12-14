import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_web/widget/search_widget/item_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchDrawerState();
}

class _SearchDrawerState extends State<SearchDrawer> {
  String _search = '';

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> uid;

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

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    18.0,
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade800,
                    ),
                    autofocus: true,
                    onChanged: (val) {
                      setState(() {
                        _search = val.trim();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('items')
                        .orderBy('name', descending: false)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      List<DocumentSnapshot> docs = new List();
                      docs.addAll(snapshot.data.docs);

                      if (_search != '') {
                        docs
                            .where((doc) =>
                                TiengViet.parse(doc['name'].toString())
                                    .toLowerCase()
                                    .replaceAll(' ', '')
                                    .startsWith(
                                        TiengViet.parse(_search)
                                            .toLowerCase()
                                            .replaceAll(' ', ''),
                                        0) ==
                                false) // filter keys
                            .toList() // create a copy to avoid concurrent modifications
                            .forEach(docs.remove);
                      } else {
                        docs.clear();
                        docs.addAll(snapshot.data.docs);
                      }

                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          return ItemSearch(
                            info: docs[index],
                            uid: snap.data,
                          ); //renderItem
                        },
                      );
                    },
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
