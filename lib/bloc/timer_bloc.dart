import 'dart:async';

import 'package:countdown/countdown.dart';
import 'package:cruzadinha_project/bloc/game_bloc.dart';
import 'package:vibration/vibration.dart';

class TimerBloc {
  final StreamController _streamController = StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  var gameBloc = GameBloc();
  var timer = '00:00:00';

  void startTime() {
    CountDown cd = CountDown(Duration(minutes: 1));
    var sub = cd.stream.listen(null);

    sub.onData((Duration duration) {
      timer = '${duration.inMinutes % 60}:'.padLeft(3, '0') +
              '${duration.inSeconds % 60}:'.padLeft(3, '0') +
          '${duration.inMilliseconds % 60}'.padLeft(2, '0');
      input.add(timer);
    });

    sub.onDone(() {
      timer = '00:00:00';
      input.add(timer);
      Vibration.vibrate(duration: 3000);

      gameBloc.endGame();
    });

    /// the countdown will have 500ms delay

    Timer(Duration(milliseconds: 4500), () {
      sub.resume();
    });
  }
}
