import 'package:flutter/material.dart';
// import '../services/permission.dart';

class Help extends StatefulWidget {
  Help({Key key, this.title}) : super(key: key);
  final String title;
  static const String routeName = "/help";

  @override
  _Help createState() => _Help();
}

class _Help extends State<Help> {
  final pages = ['Home', 'Known Calls', 'Unknown Calls', 'Help'];
  final routes = ['/', '/knowncalls', '/unknowncalls', '/help'];
  final icons = [
    Icon(Icons.home),
    Icon(Icons.face),
    Icon(Icons.person_outline),
    Icon(Icons.help_outline)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tab_children = <Widget>[];
    for (int i = 0; i < routes.length; i++) {
      tab_children.add(
        IconButton(
            icon: icons[i],
            onPressed: () {
              Navigator.pushNamed(context, routes[i]);
            }),
      );
    }

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: tab_children,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("./assets/images/bg1.jpg"),
                    fit: BoxFit.cover)),
          ),
          Center(
            child: Text("data"),
          ),
        ],
      ),
    );
  }
}
