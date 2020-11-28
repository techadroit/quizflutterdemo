import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/model/categories.dart';
import 'package:TataEdgeDemo/model/qustions.dart';

class QuizEvent extends AppEvent{}

class LoadQuiz extends QuizEvent{
  Categories categories;
  LoadQuiz(this.categories);

  @override
  List<Object> get props => [categories];
}

class OptionSelected extends QuizEvent{}

class ShowNext extends QuizEvent{}
class ShowPrev extends QuizEvent{}

class QuizCompleteEvent extends QuizEvent{
  int marks;
  int total;
  QuizCompleteEvent(this.marks,this.total);
}

class AnswerSubmittedEvent extends QuizEvent{
  Options answer;
  AnswerSubmittedEvent(this.answer);

  @override
  List<Object> get props => [answer];
}