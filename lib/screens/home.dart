import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/blocs/user_bloc.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/drawerMenu.dart';

class Home extends StatefulWidget {
  late final TextEditingController controlId;
  late final TextEditingController controlName;
  late final TextEditingController controlAddress;
  late final TextEditingController controlPhone;
  late final TextEditingController controlMail;

  Home(
      {int id = 0,
      String name = "",
      String address = "",
      String phone = "",
      String mail = ""}) {
    controlId = TextEditingController(text: id.toString());
    controlName = TextEditingController(text: name);
    controlAddress = TextEditingController(text: address);
    controlPhone = TextEditingController(text: phone);
    controlMail = TextEditingController(text: mail);
  }

  int get id => int.parse(controlId.value.text);

  String get name => controlName.value.text;

  String get address => controlAddress.value.text;

  String get phone => controlPhone.value.text;

  String get mail => controlMail.value.text;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<Home> {
  final _controller = ScrollController();
  final userBloc = UserBloc();
  int selectIndex = 0;

  var user = User(id: 0, name: '', mail: '', phone: '', address: '');
  String titleShow = 'Insert';
  bool isSearchShow = false;

  FocusNode nodeOne = FocusNode();

  Future<void> refreshData() async {
    userBloc.getUser(isRefresh: true);
    setState(() {
      isSearchShow = false;
    });
  }

  @override
  void initState() {
    userBloc.getUser();
    super.initState();
  }

  @override
  void dispose() {
    userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchShow(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchShow = true;
              });
              // if (user.id != 0) {
              //   _getById(user.id);
              // }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: buildBody(),
      drawer: DrawerMenu(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        fixedColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Insert",
            icon: Icon(Icons.add),
          ),
        ],
        onTap: (int indexOfItem) {
          onTapHandler(indexOfItem);
        },
      ),
    );
  }

  void onTapHandler(int index) {
    setState(() {
      selectIndex = index;
    });
    //print(selectIndex);
    if (selectIndex == 0) {
      refreshData();
    } else {
      if (selectIndex == 1) {
        titleShow = 'Insert';
        _showMaterialDialog(widget, null);
      }
    }
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

  Widget searchShow() {
    if (isSearchShow) {
      return Container(
        //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        height: 30,
        decoration: const BoxDecoration(
          // color: Colors.blue,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: TextField(
          focusNode: nodeOne,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          cursorColor: Colors.white,
          decoration: const InputDecoration.collapsed(
            hintText: "Tìm giá trị id",
            hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (value) {
            user.id = int.parse(value);
          },
        ),
      );
    }
    return const Text("DemoFlutter");
  }

  Widget listViewContext() {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        controller: _controller,
        itemBuilder: (ctx, index) {
          return buildItem(ctx, userBloc.users[index]);
        },
        itemCount: userBloc.users.length,
      ),
    );
  }

  Widget buildItem(BuildContext context, User user) {
    return Stack(
      children: [
        Container(
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
          //padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
          width: 400,
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                titleShow = 'Edit';
                // widget.controlId = user.id as TextEditingController;
              });
              // widget.controlId = user.id as TextEditingController;
              // widget.controlName = user.name as TextEditingController;
              // widget.controlAddress = user.address as TextEditingController;
              // widget.controlPhone = user.phone as TextEditingController;
              // widget.controlMail = user.mail as TextEditingController;
              _showMaterialDialog(widget, user);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'UserName: ${user.name ?? ""}',
                        style: const TextStyle(
                            color: Color(0xFF25303e),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'UserAddress: ${user.address ?? ""}',
                        style: const TextStyle(
                            color: Color(0xFF25303e),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'UserMail: ${user.mail ?? ""}',
                        style: const TextStyle(
                            color: Color(0xFF25303e),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          width: 50,
          height: 50,
          top: 10,
          right: 10,
          child: IconButton(
            onPressed: () {
              // _deleteUser(user);
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  void _showMaterialDialog(Home widget, User? user) {
    int id = (user != null ? user.id : 0);
    String name= (user != null ? user.name : "");
    String address= (user != null ? user.address : "");
    String phone= (user != null ? user.phone : "");
    String mail= (user != null ? user.mail : "");

    widget.controlId.text = id.toString();
    widget.controlName.text = name;
    widget.controlAddress.text = address;
    widget.controlPhone.text = phone;
    widget.controlMail.text = mail;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$titleShow User'),
            titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            actions: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Id",
                  hintText: "Id",
                ),
                controller: widget.controlId,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Name",
                  hintText: "Name",
                ),
                controller: widget.controlName,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Address",
                  hintText: "Address",
                ),
                controller: widget.controlAddress,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Phone",
                  hintText: "Phone",
                ),
                keyboardType: TextInputType.phone,
                //maxLength: 11,
                controller: widget.controlPhone,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Mail ",
                  hintText: "Mail",
                ),
                keyboardType: TextInputType.emailAddress,
                controller: widget.controlMail,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        child: const Text("Close"),
                        onPressed: () {
                          _dismissDialog();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          alignment: Alignment.center,
                        )),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        //minimumSize: MaterialStateProperty.all(Size(50, 30)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.greenAccent),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        alignment: Alignment.center,
                      ),
                      onPressed: () {
                        if (titleShow == 'Insert') {
                          // _insertUser(user);
                        } else if (titleShow == 'Edit') {
                          // _updateUser(user);
                        }
                        user = new User(id: 0, name: '', mail: '', address: '', phone: '');
                        _dismissDialog();
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  void _getById(int id) {
    userBloc.getUserById(id);
  }

  void _insertUser(User user) {
    userBloc.insert(user);
  }

  void _updateUser(User user) {
    userBloc.update(user);
  }

  void _deleteUser(User user) {
    userBloc.delete(user);
  }
}
