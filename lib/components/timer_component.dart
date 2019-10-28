import 'package:cruzadinha_project/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';

class TimerComponent extends StatelessWidget {
  TimerBloc bloc = TimerBloc();
  var context;

  TimerComponent({this.context});

  @override
  Widget build(BuildContext context) {
    bloc.startTime();

    return StreamBuilder(
        stream: bloc.output,
        builder: (context, snapshot) {
          return Text(
            '${bloc.timer}',
            style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                shadows: [Shadow(blurRadius: 5, color: Colors.white)]),
          );
        });
  }
}
