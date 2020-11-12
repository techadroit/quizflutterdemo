import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/data/qustions.dart';

class QuizState extends AppState {}

class QuizNotInitialized extends QuizState {}

class QuizLoaded extends QuizState {
  List<Questions> list;

  QuizLoaded(this.list);
}

class ShowQuestion extends QuizState {
  Questions questions;

  ShowQuestion(this.questions);
}

class QuizComplete extends QuizState {}

class CorrectAnswer extends QuizState {}

class WrongAnswer extends QuizState {}