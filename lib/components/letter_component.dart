import 'package:cruzadinha_project/bloc/game_bloc.dart';
import 'package:cruzadinha_project/utils/word.dart';
import 'package:flutter/material.dart';

class LetterComponent extends StatelessWidget {
  String letter;
  int positon;
  bool used = false;
  Word word;
  Color color;

  get getPosition => positon;

  GameBloc bloc = GameBloc();

  LetterComponent({this.letter, this.positon, this.color});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.output,
      builder: (context, snapshot) {
        return FittedBox(
          key: key,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => bloc.changeColor(this, used, color),
            child: Container(
              margin: EdgeInsets.all(0),
              color: bloc.color,
              width: 40.0,
              height: 50.0,
              child: Center(
                child: Text(
                  this.letter,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 38.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
