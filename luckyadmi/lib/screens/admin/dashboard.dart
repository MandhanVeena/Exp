import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key key,
    @required this.active,
  }) : super(key: key);

  final MaterialColor active;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            contentPadding: EdgeInsets.only(top: 10),
            subtitle: Text(
              '\u{20B9}12000',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.green),
            ),
            title: Text(
              'Revenue',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.grey),
            )),
        Expanded(
            child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            DashTile(
              active: active,
              icon: Icons.people_outline,
              label: "Users",
              text: '7',
            ),
            DashTile(
              active: active,
              icon: Icons.category,
              label: "Category",
              text: '23',
            ),
            DashTile(
              active: active,
              icon: Icons.track_changes,
              label: "Products",
              text: '120',
            ),
            DashTile(
              active: active,
              icon: Icons.tag_faces,
              label: "Sold",
              text: '13',
            ),
            DashTile(
              active: active,
              icon: Icons.shopping_cart,
              label: "Orders",
              text: '5',
            ),
            DashTile(
              active: active,
              icon: Icons.close,
              label: "Returns",
              text: '0',
            ),
          ],
        ))
      ],
    );
  }
}

class DashTile extends StatelessWidget {
  const DashTile({
    Key key,
    @required this.active,
    this.icon,
    this.label,
    this.text,
  }) : super(key: key);

  final MaterialColor active;
  final IconData icon;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Card(
          child: ListTile(
        title: FlatButton.icon(
          icon: Icon(icon),
          onPressed: null,
          label: Text(label),
        ),
        subtitle: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: active,
            fontSize: 60,
          ),
        ),
      )),
    );
  }
}
