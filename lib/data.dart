import 'package:flutter/material.dart';
import 'package:food_web/style.dart';
import 'package:google_fonts/google_fonts.dart';

class Pets {
  final String imageUrl;
  final String name;

  Pets({this.imageUrl, this.name});
}

List<Pets> PetData = [
  Pets(imageUrl: "assets/images/pet1.jpg", name: "Onyx"),
  Pets(imageUrl: "assets/images/pet2.jpg", name: "Tessie"),
  Pets(imageUrl: "assets/images/pet3.jpg", name: "Chanel"),
  Pets(imageUrl: "assets/images/pet4.jpg", name: "Tabbies"),
  Pets(imageUrl: "assets/images/pet5.jpg", name: "Cronx"),
  Pets(imageUrl: "assets/images/pet6.jpg", name: "Hermu"),
];

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

class PetFood extends StatelessWidget {
  final String image, name;
  PetFood({this.image, this.name});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Image.asset(image),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: GoogleFonts.hind(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: purpleColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
