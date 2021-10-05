import 'package:flutter/material.dart';
import 'package:myapp/screens/about.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/setting.dart';
import 'package:provider/provider.dart';

import 'models/ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UI()),
      ],
      child: MaterialApp(
        onGenerateRoute: (RouteSettings settings){
          switch(settings.name){
            case '/': return MaterialPageRoute(builder: (context) => Home());
            break;
            case '/about': return MaterialPageRoute(builder: (context) => About());
            break;
            case '/setting': return MaterialPageRoute(builder: (context) => Settings());
            break;
            // default: return MaterialPageRoute(builder: (context) => Home());
          }
        },
        initialRoute: '/',
        // routes: {
        //   '/': (create) => Home(),
        //   '/about':(create) => About(),
        //   '/setting': (create) => Settings(),
        // },
      ),
    );
  }
}
