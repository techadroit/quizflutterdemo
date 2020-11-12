import 'package:equatable/equatable.dart';

class Questions extends Equatable {
  String question;
  List<Options> options;

  Questions(this.question, this.options);

  @override
  List<Object> get props => [question,options];
}

class Options extends Equatable {
  String answer;
  bool isRightAnswer = false;

  Options(this.answer, {this.isRightAnswer = false});

  @override
  List<Object> get props => [answer];
}
