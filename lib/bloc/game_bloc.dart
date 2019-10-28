import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:cruzadinha_project/components/letter_component.dart';
import 'package:cruzadinha_project/components/tablerow_component.dart';
import 'package:cruzadinha_project/enum/direction_enum.dart';
import 'package:cruzadinha_project/utils/dicionary.dart';
import 'package:cruzadinha_project/utils/word.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class GameBloc {
  final StreamController _streamController = StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  var color = Colors.black45;
  final tableSize = 10;
  var letras = "aãâbcdeéêfghiíjklmnoôõpqrstuúvwyxzç";
  String get randomLetter => letras[Random().nextInt(letras.length)];
  List<TableRowComponent> rows;

  bool timeout = false;

  AudioCache player = AudioCache();

  drawTable() {
    this.rows = List<TableRowComponent>();

    for (var i = 0; i < tableSize; i++) {
      List<LetterComponent> cells = List<LetterComponent>();
      for (var j = 0; j < tableSize; j++) {
        cells.add(LetterComponent(letter: randomLetter, positon: j));
      }
      rows.add(TableRowComponent(letters: cells, children: cells));
    }

    for (var i = 0; i < 5; i++) {
      Word word = getRandomWord();
      writeWord(word);
    }

    player.loop('audios/theme_music.ogg');

    return rows;
  }

  bool validateWordIntersection(Word word, lineNumber, startCell, direction) {
    var invalidIntersection = false;
    int lineNumberTemp = int.parse(lineNumber.toString());
    int startCellTemp = int.parse(startCell.toString());

    word.characteres.forEach((letter) {
      LetterComponent letterComponent = rows[lineNumberTemp]
          .letters
          .singleWhere((item) => item.positon == startCellTemp);

      if (letterComponent.used && letterComponent.letter != letter) {
        invalidIntersection = true;
      }

      if (DirectionEnum.VERTICAL == direction) {
        lineNumberTemp++;
        return;
      }

      if (DirectionEnum.HORIZONTAL == direction) {
        startCellTemp++;
        return;
      }

      lineNumberTemp++;
      startCellTemp++;
    });

    return invalidIntersection;
  }

  void writeWord(Word word) {
    final directions = DirectionEnum.values.length;
    var direction = DirectionEnum.values[Random().nextInt(directions)];

    var randomLine = getRandomLine(direction, word);
    var randomStartCell = getRandomStartCell(direction, word);

    printWord(word, randomLine, randomStartCell, direction);
  }

  void printWord(Word word, lineNumber, startCell, direction) {
    bool invalidIntesection =
        validateWordIntersection(word, lineNumber, startCell, direction);

    if (invalidIntesection) {
      writeWord(word);
      return;
    }

    Color backgroundColor = getRandomColor();
    word.characteres.forEach((letter) {
      LetterComponent letterComponent = rows[lineNumber]
          .letters
          .singleWhere((item) => item.positon == startCell);
      letterComponent.letter = letter;
      letterComponent.used = true;
      letterComponent.color = backgroundColor;
      letterComponent.word = word;

      if (DirectionEnum.VERTICAL == direction) {
        lineNumber++;
        return;
      }

      if (DirectionEnum.HORIZONTAL == direction) {
        startCell++;
        return;
      }

      lineNumber++;
      startCell++;
    });
  }

  Word getRandomWord() {
    return Word(Dicionary().getRandomFruit);
  }

  getRandomColumn() {
    return Random().nextInt(tableSize);
  }

  Color getRandomColor() {
    var colors = [
      Colors.purple[500],
      Colors.amber[500],
      Colors.green[500],
      Colors.blue[500],
      Colors.brown[500],
      Colors.pink[500]
    ];
    return colors[Random().nextInt(colors.length)];
  }

  getRandomLine(DirectionEnum direction, Word word) {
    if (DirectionEnum.HORIZONTAL == direction) {
      return getRandomColumn();
    }

    var randomLine;

    do {
      randomLine = Random().nextInt(tableSize);
    } while ((tableSize - randomLine) < word.length);

    return randomLine;
  }

  getRandomStartCell(DirectionEnum direcao, Word word) {
    var randomStartCell;

    if (DirectionEnum.DIAGONAL != direcao) {
      do {
        randomStartCell = Random().nextInt(tableSize);
      } while ((tableSize - randomStartCell) < word.length);
    } else {
      randomStartCell = tableSize - word.length;
    }

    return randomStartCell;
  }

  void changeColor(LetterComponent letter, used, color) {
    this.color = Colors.grey;
    input.add(color);

    if (!used) {
      Vibration.vibrate(duration: 100);
      player.play('audios/fail.ogg');

      Timer(Duration(milliseconds: 300), () {
        this.color = Colors.black45;
        input.add(color);
      });

      return;
    }

    letter.word.characteres.remove(letter.letter);
    if (letter.word.characteres.isEmpty && letter.word.complete != true) {
      Vibration.vibrate(duration: 300);
      player.play('audios/word_complete.mp3');

      letter.word.complete = true;
    }

    this.color = color;
    input.add(color);
  }

  void endGame() {
    this.timeout = true;
    input.add(timeout);
  }
}
