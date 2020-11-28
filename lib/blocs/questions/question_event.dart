import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/model/qustions.dart';

class QuestionEvent extends AppEvent {}

class LoadQuestion extends QuestionEvent {
  int index = 0;

  LoadQuestion(this.index);
}

class ShowNextQuestion extends QuestionEvent {}

class ShowPrevQuestion extends QuestionEvent {}

class QuestionTimeoutEvent extends QuestionEvent {}

class OptionsSelected extends QuestionEvent {
  Options options;

  OptionsSelected(this.options);

  @override
  List<Object> get props => [options];
}
