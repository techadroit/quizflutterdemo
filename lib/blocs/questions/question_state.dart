import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/data/exceptoins.dart';
import 'package:TataEdgeDemo/data/qustions.dart';

class QuestionState extends AppState {

  @override
  bool get stringify => true;
}

class QuestionNotInitialized extends QuestionState{}


class UpdateQuestion extends QuestionState {
  Questions question;

  UpdateQuestion(this.question);

  @override
  List<Object> get props => [question];
}


class QuestionLoadSuccess extends QuestionState{
  Questions questions;
  QuestionLoadSuccess(this.questions);
  @override
  List<Object> get props => [questions];
}

class QuestionLoadError extends QuestionState{
  AppException exception;
  QuestionLoadError(this.exception);
}

class CorrectAnswerSelected extends QuestionState{
}

class WrongAnswerSelected extends QuestionState{}

