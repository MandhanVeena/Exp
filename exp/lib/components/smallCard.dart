import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  const SmallCard({
    Key key,
    this.press,
    this.name,
    this.image,
  }) : super(key: key);

  final String name;
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              (8),
            ),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 2,
                  color: Colors.grey.withOpacity(0.23))
            ]),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(name,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        letterSpacing: -0.2,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
