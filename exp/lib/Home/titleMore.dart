import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';

class TitleMoreWidget extends StatelessWidget {
  const TitleMoreWidget({Key key, this.press, this.title}) : super(key: key);

  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Title(
            text: title,
          ),
          Spacer(),
          FlatButton(
              onPressed: press,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: themeColor.withOpacity(0.1),
              child: Text(
                "View All",
                style: TextStyle(color: themeColor),
              ))
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key key, this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: themeColor),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 10,
              color: themeColor.withOpacity(0.1),
            ),
          )
        ],
      ),
    );
  }
}
