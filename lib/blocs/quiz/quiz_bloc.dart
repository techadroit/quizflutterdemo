import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_event.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_state.dart';
import 'package:TataEdgeDemo/data/datasource.dart';
import 'package:TataEdgeDemo/data/qustions.dart';

class QuizBloc extends BaseBloc<QuizEvent, QuizState> {
  DataSource dataSource = new DataSource();
  int currentQuiz = 0;
  List<Questions> list;
  int correctAnswercount = 0;
  Questions currentQuestions;

  QuizBloc() : super(QuizNotInitialized());

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is LoadQuiz) {
      list = dataSource.getQuestions(event.categories);
      yield showQuiz();
    } else if (event is ShowNext) {
      yield showQuiz();
    } else if (event is SubmitAnswer) {
      if (event.answer == currentQuestions.getAnswer()) correctAnswercount++;
      yield showQuiz();
    }
  }

  QuizState showQuiz() {
    if (currentQuiz > list.length - 1)
      return QuizComplete(correctAnswercount, list.length);
    var question = list[currentQuiz++];
    currentQuestions = question;
    return ShowQuestion(question);
  }
}
