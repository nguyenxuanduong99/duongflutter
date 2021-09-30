import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/blocs/user_bloc.dart';
import 'package:myapp/models/user.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key?key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _controller = ScrollController();
  final userBloc = UserBloc();
  var user = User(id: 0);

  Future<void> refreshData() async {
    userBloc.getUser(isRefresh: true);
  }

  @override
  void initState(){
    userBloc.getUser();
    super.initState();
  }
  @override
  void dispose(){
    userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('duongdeptrai'),
      ),
      body: buildBody(),

      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: Text(
                'hello',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('dddddddddddd'),
            ),
            ListTile(
              title: Text('gggggggggg'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _showMaterialDialog();
          });
        },
        backgroundColor: Colors.redAccent,
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex : 0,
          fixedColor  : Colors.green,
          items : const [
            BottomNavigationBarItem(
              label  : "Home",
              icon  : Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label : "Search",
              icon  : Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label  : "Profile",
              icon  : Icon(Icons.account_circle),
            ),
          ],
          onTap  : (int indexOfItem) {

          },
      ),
    );
  }

  Widget buildBody() {
    return StreamBuilder<List<User>>(
      stream: userBloc.userStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Stack(
              children: [
                listViewContext(),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
          return Center(
            child: Lottie.asset("assets/progress.json", width: 100, height: 100),
          );
      },
    );
  }
  Widget listViewContext() {
    return RefreshIndicator(
      onRefresh:refreshData,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        controller: _controller,
        itemBuilder: (ctx, index) {
          //keo dai list
          // if (index == userBloc.user.length - 1) {
          //   userBloc.getUser();
          // }
          return buildItem(ctx, userBloc.user[index]);
        },
        itemCount: userBloc.user.length,
      ),
    );
  }
  Widget buildItem(BuildContext context, User user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.name ?? "",
            style: const TextStyle(color: Color(0xFF25303e), fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            user.mail ?? "",
            style: const TextStyle(color: Color(0xFF25303e)),
          ),
        ],
      ),
    );
  }
  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Them User'),
            // content: Text('Hey! I am Coflutter!'),
            actions: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Id",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value)
                {
                  setState(() {
                    user.id = int.parse(value);
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Name",
                ),
                onChanged: (value)
                {
                  setState(() {
                    user.name = value;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Address",
                ),
                onChanged: (value)
                {
                  setState(() {
                    user.address = value;
                  });
                },
              ),

              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Phone",
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value)
                {
                  setState(() {
                    user.phone = value;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Mail",
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value)
                {
                  setState(() {
                    user.mail = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton (
                      child: const Text("Dong"),
                      onPressed: () {
                        _dismissDialog();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        alignment: Alignment.center,
                      )
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      _insertUser(user);
                      _dismissDialog();
                    },
                    child: const Text('Them'),
                  )
                ],
              ),
            ],
          );
        });
  }
  _dismissDialog() {
    Navigator.pop(context);
  }
  void _insertUser(User user){
    userBloc.insert(user);
  }
}


