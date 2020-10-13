import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_web/src/widget/home_widget/bar_widget.dart';
import 'package:food_web/src/widget/home_widget/body.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                aspectRatio: 1 / 1,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 1500),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                'https://images.unsplash.com/photo-1474440692490-2e83ae13ba29?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
                'https://images.unsplash.com/photo-1574085733277-851d9d856a3a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1055&q=80',
                'https://images.unsplash.com/photo-1542826438-bd32f43d626f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1156&q=80',
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(i),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .456,
                ),
                // It will cover 1/9 of free spaces
                Body(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
