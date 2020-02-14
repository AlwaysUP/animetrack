import 'package:flutter/material.dart';
import '../services/calllog.dart';

class UnknownCalls extends StatefulWidget {
  UnknownCalls({Key key, this.title}) : super(key: key);
  final String title;
  static const String routeName = "/unknowncalls";

  @override
  _UnknownCalls createState() => _UnknownCalls();
}

class _UnknownCalls extends State<UnknownCalls> {
  CallLogService callLogService = new CallLogService();
  var _callLogEntries = [];
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

  Future<void> _refreshCallLogs() async {
    var result = await callLogService.getCallsLastCheck();
    setState(() {
      _callLogEntries = result.toList();
      _callLogEntries.removeWhere((item) => item.name != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Text('NUMBER   : ${entry.formattedNumber}'),
    // Text('NAME     : ${entry.name}'),
    // Text('TYPE     : ${entry.callType}'),
    // Text('DATE     : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp)}'),
    // Text('DURATION :  ${entry.duration}'),
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
            child: RefreshIndicator(
              child: ListView.separated(
                padding: const EdgeInsets.all(32),
                itemCount: _callLogEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: RawMaterialButton(
                      onPressed: () {},
                      child: new Text(
                        _callLogEntries[index].number.toString().substring(0, 3),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                        ),
                      ),
                      shape: new CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.lightGreen,
                      padding: const EdgeInsets.all(15.0),
                    ),
                    title: Container(
                        child: Text(_callLogEntries[index].number.toString() )),
                    subtitle: Container(
                      child: Text(
                          "${(_callLogEntries[index].duration ~/ 60).toString().padLeft(2, "0")}:${(_callLogEntries[index].duration).toString().padLeft(2, "0")}"),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
              onRefresh: _refreshCallLogs,
            ),
          ),
        ],
      ),
    );
  }
}
