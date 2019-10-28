import 'package:cruzadinha_project/pages/game_page.dart';
import 'package:cruzadinha_project/pages/timeout_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/game': (BuildContext context) => GamePage(),
        '/timeout': (BuildContext context) => TimeoutPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Builder(
        builder: (context) => MyHome(),
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
          alignment: Alignment.topCenter,
          child: Text(
            'Caça Palavras',
            style: TextStyle(
                fontFamily: 'Cream Peach',
                color: Colors.yellowAccent,
                fontSize: 55,
                shadows: [
                  Shadow(
                      color: Colors.red,
                      blurRadius: 3,
                      offset: Offset.fromDirection(10.0, 1)),
                ]),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: RaisedButton(
            child: Icon(
              Icons.play_arrow,
              size: 130,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/game');
            },
            color: Colors.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(color: Colors.yellowAccent),
            ),
          ),
        )
      ]),
    );
  }
}
