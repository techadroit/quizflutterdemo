import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_event.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_state.dart';
import 'package:TataEdgeDemo/data/categories.dart';
import 'package:TataEdgeDemo/data/network/network_client/network_handler.dart';
import 'package:TataEdgeDemo/data/qustions.dart';
import 'package:TataEdgeDemo/data/remote_repository.dart';
import 'package:TataEdgeDemo/services/quiz_service.dart';

class QuizBloc extends BaseBloc<QuizEvent, QuizState> {
  QuizService quizService =
      new QuizService(RemoteRepository(NetworkHandler.instance.getClient()));
  int currentQuiz = 0;
  List<Questions> list;
  int correctAnswercount = 0;
  Questions currentQuestions;

  QuizBloc() : super(QuizNotInitialized());

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is LoadQuiz) {
      yield LoadQuizInProgress();
      yield await loadQuiz(event.categories.value());
    } else if (event is ShowNext) {
      yield showQuiz();
    } else if (event is SubmitAnswer) {
      if (event.answer == currentQuestions.getAnswer()) correctAnswercount++;
      yield showQuiz();
    }
  }

  Future<QuizState> loadQuiz(String category) async{
    var response = await quizService.getQuestions(category);
    return response.fold((l) => LoadQuizError(l), (r) {
      list = r;
      return showQuiz();
    });
  }

  QuizState showQuiz() {
    if (currentQuiz > list.length - 1)
      return QuizComplete(correctAnswercount, list.length);
    var question = list[currentQuiz++];
    currentQuestions = question;
    return ShowQuestion(question);
  }
}
