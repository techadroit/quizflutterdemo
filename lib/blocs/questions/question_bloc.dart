import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/blocs/questions/question_event.dart';
import 'package:TataEdgeDemo/blocs/questions/question_state.dart';
import 'package:TataEdgeDemo/data/qustions.dart';
import 'package:TataEdgeDemo/services/quiz_service.dart';
import 'package:flutter/cupertino.dart';

class QuestionBloc extends BaseBloc<QuestionEvent, QuestionState> {
  QuizService quizService;
  Options optionsSelected;
  Questions questions;

  QuestionBloc(this.quizService) : super(QuestionNotInitialized());

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    debugPrint(" [QuestionBloc] event is $event");
    if (event is LoadQuestion) {
      yield quizService
          .getQuestion(event.index)
          .fold((l) => QuestionLoadError(l), (r) {
        questions = r;
        return QuestionLoadSuccess(r);
      });
    } else if (event is OptionsSelected) {
      optionsSelected = event.options;
      updateQuestion();
      quizService.onAnswerGiven(questions);
    } else if (event is ShowNextQuestion) {
      quizService.onAnswerGiven(questions);
    }
  }

  void updateQuestion() {
    questions.options.forEach((element) {
      element.isSelected = false;
    });
    var fetchOptions =
        questions.options.firstWhere((element) => element == optionsSelected);
    if (fetchOptions != null) fetchOptions.isSelected = true;
    questions.selectedOptions = optionsSelected;
  }
}
