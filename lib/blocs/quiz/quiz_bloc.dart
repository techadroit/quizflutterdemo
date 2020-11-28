import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_event.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_state.dart';
import 'package:TataEdgeDemo/services/page_state.dart';
import 'package:TataEdgeDemo/services/quiz_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:TataEdgeDemo/model/categories.dart';

class QuizBloc extends BaseBloc<QuizEvent, QuizState> {
  QuizService quizService;

  QuizBloc(this.quizService) : super(QuizNotInitialized()) {
    quizService.pageStatePublisher.listen((value) {
      if (value is NextPage) {
        add(ShowNext());
      } else if (value is PrevPage) {
        add(ShowPrev());
      } else if (value is PageFinished) {
        add(QuizCompleteEvent(value.marks, value.total));
      }
    });
  }

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    debugPrint(" [QuizBloc] the event is $event");
    if (event is LoadQuiz) {
      yield LoadQuizInProgress();
      yield await loadQuiz(event.categories.value());
    } else if (event is ShowNext || event is ShowPrev) {
      yield ShowQuestion(quizService.currentPage,
          isFirstPage: quizService.isFirstPage(),
          isLastPage: quizService.isLastPage());
    } else if (event is QuizCompleteEvent) {
      yield QuizComplete(event.marks, event.total, quizService.questionsList);
    }
  }

  Future<QuizState> loadQuiz(String category) async {
    var response = await quizService.loadQuestion(category);
    return response.fold((l) => LoadQuizFailure(l), (r) {
      return ShowQuestion(quizService.currentPage,
          isFirstPage: quizService.isFirstPage(),
          isLastPage: quizService.isLastPage());
    });
  }

  void showNextPage() {
    quizService.goToNextPage();
  }

  void showPrevPage() {
    quizService.goToPrevPage();
  }

  void completeQuiz() {
    quizService.onCompleteQuiz();
  }

  @override
  Future<void> close() {
    quizService.close();
    return super.close();
  }
}
