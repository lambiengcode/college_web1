import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_web/src/app.dart';
import 'package:food_web/src/pages/cart/profile_page.dart';
import 'package:food_web/src/pages/menu/vegetable_page.dart';

class MenuPage extends StatefulWidget {
  final int type;

  MenuPage({this.type});

  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = <Widget>[
    VegetablePage(),
    Container(),
    VegetablePage(
      kind: 1,
    ),
    VegetablePage(
      kind: 2,
    ),
    VegetablePage(
      kind: 3,
    ),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        vsync: this, length: myTabs.length, initialIndex: widget.type);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void showCartBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(6.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ProfilePage(
            type: 2,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: .8,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: TabBar(
          controller: _tabController,
          labelColor: Colors.blueAccent,
          indicatorColor: Colors.blueAccent,
          unselectedLabelColor: Color(0xFF59566A),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 34.0),
          indicatorWeight: 2.24,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.8,
          ),
          tabs: [
            Tab(
              text: 'Mới',
            ),
            Tab(
              text: 'Giảm giá',
            ),
            Tab(
              text: 'Rau củ',
            ),
            Tab(
              text: 'Trái cây',
            ),
            Tab(
              text: 'Bánh ngọt',
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueAccent,
            size: 22.0,
          ),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Feather.shopping_cart,
              color: Colors.blueAccent,
              size: 22.0,
            ),
            onPressed: () {
              if (App.uid == '') {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => AuthenticatePage()));
                showCartBottomSheet();
              } else {
                showCartBottomSheet();
              }
            },
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Widget tab) {
          return tab;
        }).toList(),
      ),
    );
  }
}
