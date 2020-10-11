import 'package:flutter/material.dart';
import '../../constant/constant.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Blog".toUpperCase(),
            style: TextStyle(
              fontSize: 88.0,
              color: Colors.black.withOpacity(.75),
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          Text(
            "\tHọc hỏi những kiến thức bổ ích về dinh dưỡng và cùng nhau\n\tchia sẻ, góp ý về những loại thực phẩm tốt cho sức khỏe.\n\tHãy bắt đầu ngay để đổi mới bữa ăn gia đình ngay hôm nay.",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          FittedBox(
            // Now it just take the required spaces
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFF372930),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF372930),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    "Bắt đầu".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(width: 4.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
