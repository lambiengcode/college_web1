import 'package:flutter/material.dart';
import 'package:food_web/src/pages/cart/cart_page.dart';

class ProfilePage extends StatefulWidget {
  final int type;

  ProfilePage({this.type});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = <Widget>[
    Container(),
    Container(),
    CartPage(),
    Container(),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .88,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.blueAccent,
            indicatorColor: Colors.blueAccent,
            unselectedLabelColor: Color(0xFF59566A),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                text: 'Thông tin cá nhân',
              ),
              Tab(
                text: 'Đơn hàng hiện tại',
              ),
              Tab(
                text: 'Giỏ hàng',
              ),
              Tab(
                text: 'Lịch sử đơn hàng',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: myTabs.map((Widget tab) {
                return tab;
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
