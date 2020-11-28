import 'package:TataEdgeDemo/blocs/questions/question_bloc.dart';
import 'package:TataEdgeDemo/blocs/questions/question_event.dart';
import 'package:TataEdgeDemo/blocs/questions/question_state.dart';
import 'package:TataEdgeDemo/model/qustions.dart';
import 'package:TataEdgeDemo/services/page_state.dart';
import 'package:TataEdgeDemo/services/quiz_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';


class MockQuizService extends Mock implements QuizService {}

main() {
  QuestionBloc bloc;
  MockQuizService quizService = new MockQuizService();

  setUp(() {
    var publishSubject = PublishSubject<PageState>();
    quizService.pageStatePublisher = publishSubject;
    bloc = QuestionBloc(quizService);
  });

  test("load question success", () {
    var question = Questions.mockWithWrongSelection();
    when(quizService.getQuestion(any))
        .thenAnswer((realInvocation) => Right(question));
    expectLater(bloc, emitsInOrder([QuestionLoadSuccess(question)]));
    bloc.add(LoadQuestion(1));
  });

  test("on options selected", () async {
    var question = Questions.mockWithWrongSelection();
    bloc.questions = question;
    when(quizService.onAnswerGiven(any)).thenAnswer((realInvocation) {});
    bloc.add(OptionsSelected(question.options.first));
    await untilCalled(quizService.onAnswerGiven(any));
    verify(quizService.onAnswerGiven(any)).called(1);
  });
}
