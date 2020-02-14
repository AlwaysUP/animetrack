import 'package:flutter/material.dart';
import '../services/permission.dart';

class Menu extends StatefulWidget {
  Menu({Key key, this.title}) : super(key: key);
  final String title;
  static const String routeName = "/";

  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  bool _permissionGranted = false;
  PermissionService permissionService = new PermissionService();
  final pages = ['Home', 'Known Calls', 'Unknown Calls', 'Help'];
  final routes = ['/', '/knowncalls', '/unknowncalls', '/help'];
  final icons = [
    Icon(Icons.home),
    Icon(Icons.face),
    Icon(Icons.person_outline),
    Icon(Icons.help_outline)
  ];

  void _setPermissionStatus() async {
    if ((await permissionService.getPhonePermission()) &&
        (await permissionService.getContactPermission())) {
      setState(() {
        _permissionGranted = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _setPermissionStatus();
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
            child: ListView.separated(
              padding: const EdgeInsets.all(32),
              itemCount: pages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(child: Text(pages[index])),
                  // subtitle: Center(child: Text(pages[index])),
                  onTap: () {
                    Navigator.pushNamed(context, routes[index]);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
