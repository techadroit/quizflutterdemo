import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_event.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_state.dart';
import 'package:TataEdgeDemo/data/datasource.dart';

class QuizBloc extends BaseBloc<QuizEvent,QuizState>{

  DataSource dataSource = new DataSource();

  QuizBloc() : super(QuizNotInitialized());


  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async*{
    if(event is LoadQuiz){
      var list = dataSource.getQuestions(event.categories);
      yield ShowQuestion(list[0]);
    }
  }

}