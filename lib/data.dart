import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Titl extends StatelessWidget {
  final String text;
  Titl({this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.nanumGothic(
          color: Colors.grey,
          fontSize: 20,
          height: 1.8,
        ));
  }
}

class Heading extends StatelessWidget {
  final String text;
  Heading({this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          fontSize: 25,
          color: Colors.white,
        ));
  }
}

class Star extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      color: Colors.amber,
      size: MediaQuery.of(context).size.width * 0.02,
    );
  }
}
