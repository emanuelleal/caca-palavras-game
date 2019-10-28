class Word {
  String word;
  var characteres;
  String dica;
  int value;
  int length;
  bool complete;

  Word(Map map) {
    this.word = map['nome'];
    this.dica = map['dica'];

    this.characteres = List<String>.from(word.split(''));
    this.value = this.characteres.length * 5;
    this.length = this.characteres.length;
  }
}