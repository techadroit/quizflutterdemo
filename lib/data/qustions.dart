import 'package:TataEdgeDemo/data/network/request/api_question_list_response.dart';
import 'package:equatable/equatable.dart';
import 'package:TataEdgeDemo/core/string_extensions.dart';

class Questions extends Equatable {
  String question;
  List<Options> options;

  Questions(this.question, this.options);

  Options getAnswer() {
    return options.where((element) => element.isRightAnswer).first;
  }

  @override
  List<Object> get props => [question, options];

  Questions.fromResponse(QuestionsListResponse response) {
    options = [
      Options(response.answers.answerA,isRightAnswer: response.correctAnswers.answerACorrect.parseBool()),
      Options(response.answers.answerB,isRightAnswer: response.correctAnswers.answerBCorrect.parseBool()),
      Options(response.answers.answerC,isRightAnswer: response.correctAnswers.answerCCorrect.parseBool()),
      Options(response.answers.answerD,isRightAnswer: response.correctAnswers.answerDCorrect.parseBool())
    ];
    question = response.question;
  }
}

class Options extends Equatable {
  String answer;
  bool isRightAnswer = false;

  Options(this.answer, {this.isRightAnswer = false});

  @override
  List<Object> get props => [answer];
}
