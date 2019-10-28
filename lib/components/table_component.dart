import 'package:cruzadinha_project/bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TableComponent extends StatelessWidget {
  var _bloc = GameBloc();

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.white54),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: _bloc.drawTable(),
    );
  }
}
