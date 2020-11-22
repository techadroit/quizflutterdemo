import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/data/qustions.dart';

class QuizState extends AppState {

  @override
  bool get stringify => true;
}

class QuizNotInitialized extends QuizState {}

class LoadQuizInProgress extends QuizState {}

class LoadQuizError extends QuizState {
  Exception exception;

  LoadQuizError(this.exception);

  @override
  List<Object> get props => [exception];
}

class QuizLoaded extends QuizState {
  List<Questions> list;

  QuizLoaded(this.list);
}

class ShowQuestion extends QuizState {
  int index;
  bool isFirstPage;
  bool isLastPage;

  ShowQuestion(this.index, {this.isFirstPage = false, this.isLastPage = false});

  @override
  List<Object> get props => [index];

}

class QuizComplete extends QuizState {
  int marks;
  int total;
  List<Questions> questionsList;

  QuizComplete(this.marks, this.total,this.questionsList);

  @override
  List<Object> get props => [marks,total,questionsList];
}

class CorrectAnswer extends QuizState {}

class WrongAnswer extends QuizState {}
