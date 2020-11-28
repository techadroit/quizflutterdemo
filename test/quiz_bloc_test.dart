import 'package:TataEdgeDemo/blocs/quiz/quiz_bloc.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_event.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_state.dart';
import 'package:TataEdgeDemo/data/datasource/exceptoins.dart';
import 'package:TataEdgeDemo/data/network/request/api_question_list_response.dart';
import 'package:TataEdgeDemo/model/categories.dart';
import 'package:TataEdgeDemo/model/qustions.dart';
import 'package:TataEdgeDemo/services/page_state.dart';
import 'package:TataEdgeDemo/services/quiz_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockQuizService extends Mock implements QuizService {}

main() {
  MockQuizService quizService = new MockQuizService();
  QuizBloc bloc;

  setUp(() {
    var publishSubject = PublishSubject<PageState>();
    when(quizService.pageStatePublisher).thenAnswer((_) => publishSubject);
    bloc = QuizBloc(quizService);

    bloc.listen((state) {
      debugPrint(" the state is $state");
    });
  });

  test("load quiz", () {
    var questionMock = Questions.fromResponse(QuestionsListResponse.mock());
    var list = [questionMock];
    when(quizService.currentPage).thenReturn(0);
    when(quizService.loadQuestion(any))
        .thenAnswer((realInvocation) async => Right(list));

    expectLater(bloc, emitsInOrder([LoadQuizInProgress(), ShowQuestion(0)]));
    bloc.add(LoadQuiz(Categories.cloud));
  });

  test("test no question found for the category", () {
    var exception = NoQuestionFound();
    when(quizService.loadQuestion(any))
        .thenAnswer((realInvocation) async => Left(exception));

    expectLater(
        bloc, emitsInOrder([LoadQuizInProgress(), LoadQuizFailure(exception)]));

    bloc.add(LoadQuiz(Categories.cloud));
  });

  test("show next quiz", () {
    when(quizService.currentPage).thenReturn(1);
    when(quizService.isFirstPage()).thenReturn(false);
    when(quizService.isLastPage()).thenReturn(true);

    var expected = [ShowQuestion(1, isFirstPage: false, isLastPage: true)];

    expectLater(bloc, emitsInOrder(expected));
    bloc.add(ShowNext());
  });

  test("show previous quiz", () {
    when(quizService.currentPage).thenReturn(0);
    when(quizService.isFirstPage()).thenReturn(true);
    when(quizService.isLastPage()).thenReturn(false);

    var expected = [ShowQuestion(0, isFirstPage: true, isLastPage: false)];

    expectLater(bloc, emitsInOrder(expected));
    bloc.add(ShowPrev());
  });
}
