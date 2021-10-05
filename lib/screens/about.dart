import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:myapp/models/ui.dart';
import 'package:myapp/screens/drawerMenu.dart';
import 'package:provider/provider.dart';

class About extends StatelessWidget {
  String text = lorem(paragraphs: 3, words: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerMenu(),
      body: Container(
        margin: const EdgeInsets.all(10),
        child:Consumer<UI>(
          builder: (context, ui, child){
            return RichText(
              text: TextSpan(
                text: text,
                style: TextStyle(fontSize: ui.fontSize, color: Colors.lightBlue),
              )
            );
          },
        ),
      ),
    );
  }

}