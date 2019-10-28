import 'package:cruzadinha_project/components/letter_component.dart';
import 'package:flutter/widgets.dart';

class TableRowComponent extends TableRow {
  final List<LetterComponent> letters;
  final List<Widget> children;

  TableRowComponent({this.letters, this.children});
}