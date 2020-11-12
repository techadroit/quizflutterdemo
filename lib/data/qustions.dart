import 'package:equatable/equatable.dart';

class Questions extends Equatable{
  String question;
  List<Options> options;
  Options answer;

  Questions(this.question, this.options, this.answer);

  bool isCorrectAnswer(Options options) {
    return answer == options;
  }

  @override
  List<Object> get props => [question];
}

class Options extends Equatable {
  String answer;

  Options(this.answer);

  @override
  List<Object> get props => [answer];
}
