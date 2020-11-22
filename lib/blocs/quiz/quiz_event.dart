import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/data/categories.dart';
import 'package:TataEdgeDemo/data/qustions.dart';

class QuizEvent extends AppEvent{}

class LoadQuiz extends QuizEvent{
  Categories categories;
  LoadQuiz(this.categories);
}

class OptionSelected extends QuizEvent{}

class ShowNext extends QuizEvent{}
class ShowPrev extends QuizEvent{}

class QuizCompleteEvent extends QuizEvent{
  int marks;
  int total;
  QuizCompleteEvent(this.marks,this.total);
}

class SubmitAnswer extends QuizEvent{
  Options answer;
  SubmitAnswer(this.answer);

  @override
  List<Object> get props => [answer];
}