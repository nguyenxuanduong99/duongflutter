import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kTitile = 'Menu';
class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.teal,
            ),
            child: Center(
              child: Text(
                kTitile,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          getListTitle('Home', onTap: () {
            Navigator.pushNamed(context, '/');
          }),
          getLine(),
          getListTitle('About', onTap: () {
            Navigator.pushNamed(context, '/about');
          }),
          getLine(),
          getListTitle('Setting', onTap: () {
            Navigator.pushNamed(context, '/setting');
          }),
          getLine(),
        ],
      ),
    );
  }

  Widget getLine() {
    return SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget getListTitle(title, {Null Function()? onTap}) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}
