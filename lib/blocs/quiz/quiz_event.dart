import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/data/categories.dart';

class QuizEvent extends AppEvent{}

class LoadQuiz extends QuizEvent{
  Categories categories;
  LoadQuiz(this.categories);
}

class OptionSelected extends QuizEvent{}

class ShowNext extends QuizEvent{}