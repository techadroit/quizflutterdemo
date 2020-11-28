import 'package:TataEdgeDemo/data/datasource/exceptoins.dart';
import 'package:TataEdgeDemo/data/datasource/remote_repository.dart';
import 'package:TataEdgeDemo/data/network/request/api_question_list_response.dart';
import 'package:TataEdgeDemo/model/qustions.dart';
import 'package:TataEdgeDemo/services/page_state.dart';
import 'package:TataEdgeDemo/services/quiz_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteRepository extends Mock implements RemoteDatasource {}

main() {
  QuizService quizService;
  MockRemoteRepository mockRemoteRepository;

  setUp(() {
    mockRemoteRepository = MockRemoteRepository();
    quizService = QuizService(mockRemoteRepository);
  });

  test("test load questions", () async {
    when(mockRemoteRepository.getQuestions(any))
        .thenAnswer((realInvocation) async => [QuestionsListResponse.mock()]);

    var value = await quizService.loadQuestion("linux");
    expect(
        value,
        isA<Right>().having((source) => source.value,
            "check list of question response", isA<List<Questions>>()));
  });

  test("test load questions on exception", () async {
    when(mockRemoteRepository.getQuestions(any))
        .thenAnswer((realInvocation) async => throw NoQuestionFound());

    var value = await quizService.loadQuestion("linux");
    expect(
        value,
        isA<Left>().having((source) => source.value,
            "check list of question response", isA<NoQuestionFound>()));
  });

  test("test service emits next page change event", () async {
    expectLater(quizService.pageStatePublisher, emitsInOrder([NextPage(1)]));
    quizService.goToNextPage();
  });

  test("test service emits prev page change event", () async {
    quizService.currentPage = 1;
    expectLater(quizService.pageStatePublisher, emitsInOrder([PrevPage(0)]));
    quizService.goToPrevPage();
  });

  test("test service emits complete page change event", () async {
    quizService.currentPage = 0;
    quizService.questionsList = [
      Questions.fromResponse(QuestionsListResponse.mock())
    ];
    expectLater(
        quizService.pageStatePublisher, emitsInOrder([PageFinished(0, 1)]));
    quizService.goToNextPage();
  });

  test(" check marks calculation", () {
    var list = [
      Questions.mockWithCorrectSelection(),
      Questions.mockWithWrongSelection()
    ];
    int marks = quizService.getMarks(list);
    expect(marks, 1);
  });
}
