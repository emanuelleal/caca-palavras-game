import 'package:cruzadinha_project/bloc/game_bloc.dart';
import 'package:cruzadinha_project/components/table_component.dart';
import 'package:cruzadinha_project/components/timer_component.dart';
import 'package:cruzadinha_project/pages/timeout_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var bloc = GameBloc();

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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                      stream: bloc.output,
                      builder: (context, snapshot) {
                        return Column(children: [
                          Container(
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.all(8),
                              child: TimerComponent(context: context)),
                          Visibility(
                            visible: !bloc.timeout,
                            child: TableComponent(),
                          ),
                          Visibility(
                            visible: bloc.timeout,
                            child: TimeoutPage(),
                          )
                        ]);
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Icon(Icons.close),
                          color: Colors.redAccent,
                          onPressed: () {
                            Navigator.of(context).pop('dialog');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Icon(Icons.update),
                          color: Colors.yellow,
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/game');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: BorderSide(color: Colors.yellow),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
