import 'package:flutter/material.dart';
import 'screens/menu.dart';
import 'screens/help.dart';
import 'screens/knowncalls.dart';
import 'screens/unknowncalls.dart';

void main() => runApp(MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => Menu(),
        '/help': (context) => Help(),
        '/knowncalls': (context) => KnownCalls(),
        '/unknowncalls': (context) => UnknownCalls(),
      },
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Roboto',
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        }),
      ),
    ));
