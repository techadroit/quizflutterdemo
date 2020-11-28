import 'package:TataEdgeDemo/data/datasource/exceptoins.dart';
import 'package:TataEdgeDemo/data/datasource/remote_repository.dart';
import 'package:TataEdgeDemo/data/datasource/remote_repository.dart';
import 'package:TataEdgeDemo/model/qustions.dart';
import 'package:TataEdgeDemo/services/page_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class QuizService {
  RemoteDatasource remoteRepository;
  int currentPage = 0;
  var pageStatePublisher = new PublishSubject<PageState>();
  var questionsList = <Questions>[];

  QuizService(this.remoteRepository);

  /// Load List of questions from the remote source and store it in a list
  /// @param category : String
  /// @return
  /// Either.Right -> List<Questions> for success
  /// Either.Left -> Exception for error
  Future<Either<Exception, List<Questions>>> loadQuestion(
      String category) async {
    try {
      var response = await remoteRepository.getQuestions(category);
      var list = response.map((e) => Questions.fromResponse(e)).toList();
      questionsList.addAll(list);
      return Right(list);
    } catch (e) {
      return Left(e);
    }
  }

  /// Fetch question from the list using given index
  /// @param index : int
  /// @return
  /// Either.Right -> Questions for success
  /// Either.Left -> Exception for error
  Either<AppException, Questions> getQuestion(int index) {
    if (index >= questionsList.length) {
      return Left(NoQuestionFound());
    }
    return Right(questionsList[index]);
  }

  /// update the question list with the give question
  /// and move to next page
  void onAnswerGiven(Questions questions) {
    questionsList =
        questionsList.map((e) => (e == questions) ? questions : e).toList();
    goToNextPage();
  }

  /// change the page to next index
  /// @param
  /// isNext = true move to next page
  /// isNext = false move to prev page
  ///
  /// Also moving the page to next index we check if the quiz is completed
  void _changePage(bool isNext) {
    debugPrint("current page is $currentPage");
    if (!isNext) {
      currentPage--;
      pageStatePublisher.add(PrevPage(currentPage));
    } else if (isFinished()) {
      onCompleteQuiz();
    } else if (isNext) {
      currentPage++;
      pageStatePublisher.add(NextPage(currentPage));
    }
  }

  /// Fire complete quiz event
  /// with total questions and the correct answer given
  void onCompleteQuiz() {
    var marks = getMarks(questionsList);
    var total = questionsList.length;
    pageStatePublisher.add(PageFinished(marks, total));
  }

  /// get marks for the quiz by iterating the question list
  /// and check if the options selected is right or wrong answer
  /// optons selected can be null
  int getMarks(List<Questions> list) {
    return list.fold(0,
        (previousValue, element) => previousValue + _getOptionValue(element));
  }

  /// helper method to check the options selected for the question
  /// is right or wrong
  /// 1 marks for right
  /// 0 marks for wrong
  /// @note selection options can be null
  int _getOptionValue(Questions element) {
    var value = ((element.selectedOptions != null &&
            element.selectedOptions.isRightAnswer)
        ? 1
        : 0);
    debugPrint(" the value is value");
    return value;
  }

  void goToNextPage() {
    _changePage(true);
  }

  void onTimeOut() {
    goToNextPage();
  }

  void goToPrevPage() {
    _changePage(false);
  }

  bool isFinished() => currentPage == (questionsList.length - 1);

  int getCurrentPage() => currentPage;

  bool isFirstPage() => currentPage == 0;

  bool isLastPage() => currentPage == (questionsList.length - 1);

  void close() {
    pageStatePublisher.close();
  }
}
