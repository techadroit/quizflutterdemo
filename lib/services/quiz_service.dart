import 'package:TataEdgeDemo/data/exceptoins.dart';
import 'package:TataEdgeDemo/data/qustions.dart';
import 'package:TataEdgeDemo/data/remote_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class QuizService {
  RemoteRepository remoteRepository;
  int currentPage = 0;
  var publishSubject = new PublishSubject<PageState>();
  var questionsList = <Questions>[];

  QuizService(this.remoteRepository);

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

  Either<AppException, Questions> getQuestion(int index) {
    if (index >= questionsList.length) {
      return Left(NoQuestionFound());
    }
    return Right(questionsList[index]);
  }

  void onAnswerGiven(Questions questions) {
    questionsList =
        questionsList.map((e) => (e == questions) ? questions : e).toList();
    goToNextPage();
  }

  void _changePage(bool isNext) {
    debugPrint("current page is $currentPage");
    if(!isNext){
      currentPage--;
      publishSubject.add(PrevPage(currentPage));
    }else if (isFinished()) {
      onCompleteQuiz();
    } else if (isNext) {
      currentPage++;
      publishSubject.add(NextPage(currentPage));
    }
  }

  void onCompleteQuiz() {
    var marks = getMarks(questionsList);
    var total = questionsList.length;
    publishSubject.add(PageFinished(marks, total));
  }

  int getMarks(List<Questions> list) {
    return list.fold(
        0,
            (previousValue, element) =>
        previousValue + _getOptionValue(element)
    );
  }

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
    publishSubject.close();
  }
}

class PageState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NextPage extends PageState {
  int index;

  NextPage(this.index);

  @override
  List<Object> get props => [index];
}

class PrevPage extends PageState {
  int index;

  PrevPage(this.index);

  @override
  List<Object> get props => [index];
}

class PageFinished extends PageState {
  int marks;
  int total;

  PageFinished(this.marks, this.total);
}
