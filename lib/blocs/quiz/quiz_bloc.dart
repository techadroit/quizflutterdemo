import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_event.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_state.dart';
import 'package:TataEdgeDemo/data/datasource.dart';
import 'package:TataEdgeDemo/data/qustions.dart';
import 'package:flutter/cupertino.dart';

class QuizBloc extends BaseBloc<QuizEvent, QuizState> {
  DataSource dataSource = new DataSource();
  int currentQuiz = 0;
  List<Questions> list;

  QuizBloc() : super(QuizNotInitialized());

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is LoadQuiz) {
      list = dataSource.getQuestions(event.categories);
      yield showQuiz();
    } else if (event is ShowNext) {
      yield showQuiz();
    }
  }

  QuizState showQuiz() {
    if (currentQuiz > list.length - 1)
      return QuizComplete();
    return ShowQuestion(list[currentQuiz++]);
  }
}
