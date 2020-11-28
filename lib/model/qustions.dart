import 'package:TataEdgeDemo/core/string_extensions.dart';
import 'package:TataEdgeDemo/data/network/request/api_question_list_response.dart';
import 'package:equatable/equatable.dart';

class Questions extends Equatable {
  String question;
  List<Options> options;
  Options selectedOptions;

  Questions(this.question, this.options);

  Options getAnswer() {
    return options
        .where((element) => element.isRightAnswer)
        .first;
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [question, options];


  Questions.fromResponse(QuestionsListResponse response) {
    options = [
      Options(response.answers.answerA,
          isRightAnswer: response.correctAnswers.answerACorrect.parseBool()),
      Options(response.answers.answerB,
          isRightAnswer: response.correctAnswers.answerBCorrect.parseBool()),
      Options(response.answers.answerC,
          isRightAnswer: response.correctAnswers.answerCCorrect.parseBool()),
      Options(response.answers.answerD,
          isRightAnswer: response.correctAnswers.answerDCorrect.parseBool())
    ];
    question = response.question;
  }

  Questions.mockWithCorrectSelection() {
    this.question = "dummy question";
    this.options = [
      Options.mockForCorrectOptions(),
      Options.mockForWrongOptions(),
      Options.mockForWrongOptions(),
      Options.mockForWrongOptions()
    ];
    this.selectedOptions = Options.mockForCorrectOptions();
  }

  Questions.mockWithWrongSelection() {
    this.question = "";
    this.options = [
      Options.mockForWrongOptions(),
      Options.mockForWrongOptions(),
      Options.mockForWrongOptions(),
      Options.mockForWrongOptions()
    ];
    this.selectedOptions = Options.mockForWrongOptions();
  }
}

class Options extends Equatable {
  String answer;
  bool isRightAnswer = false;
  bool isSelected;

  Options(this.answer, {this.isRightAnswer = false, this.isSelected = false});

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [answer];

  Options.mockForCorrectOptions() {
    this.answer = "";
    this.isRightAnswer = true;
    this.isSelected = true;
  }

  Options.mockForWrongOptions() {
    this.answer = "";
    this.isRightAnswer = false;
    this.isSelected = false;
  }
}
