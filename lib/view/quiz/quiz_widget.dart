import 'package:TataEdgeDemo/blocs/quiz/quiz_bloc.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_event.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_state.dart';
import 'package:TataEdgeDemo/data/datasource/remote_repository.dart';
import 'package:TataEdgeDemo/data/network/network_client/network_handler.dart';
import 'package:TataEdgeDemo/model/categories.dart';
import 'package:TataEdgeDemo/services/quiz_service.dart';
import 'package:TataEdgeDemo/view/question/question_widget.dart';
import 'package:TataEdgeDemo/view/quiz/quiz_complete_widget.dart';
import 'package:TataEdgeDemo/view/quiz/quiz_error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizWidget extends StatelessWidget {
  Categories categories;

  QuizWidget(this.categories);

  static Widget getQuizWidget(Categories categories, BuildContext context) {
    var quizService =
        new QuizService(RemoteDatasource(NetworkHandler.instance.getClient()));
    var bloc = QuizBloc(quizService)..add(LoadQuiz(categories));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: RepositoryProvider(
        create: (context) => quizService,
        child: BlocProvider(
          create: (_) => bloc,
          child: QuizWidget(categories),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => BlocProvider.of<QuizBloc>(context),
        child: QuizContainerWidget(),
      ),
    );
  }
}

class QuizContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder(
          cubit: BlocProvider.of<QuizBloc>(context),
          builder: (context, state) {
            debugPrint(" [QuizBloc] the state is ${state.toString()}");
            if (state is ShowQuestion) {
              return QuestionWidget(state.index, ValueKey(state.index));
            } else if (state is LoadQuizFailure) {
              return QuizLoadErrorWidget();
            } else if (state is QuizComplete) {
              return QuizCompleteWidget(
                  state.marks, state.total, state.questionsList);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BlocBuilder(
            cubit: BlocProvider.of<QuizBloc>(context),
            buildWhen: (previous, current) =>
                current is ShowQuestion || current is QuizComplete,
            builder: (context, state) {
              // debugPrint(
              //     " the state navigation $state ${(state as ShowQuestion).isLastPage} ${(state as ShowQuestion).isFirstPage}");
              if (state is ShowQuestion) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!state.isFirstPage)
                        RaisedButton(
                          onPressed: () {
                            BlocProvider.of<QuizBloc>(context).showPrevPage();
                          },
                          color: Colors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.green,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        )
                      else
                        SizedBox(
                          width: 20.0,
                          height: 20.0,
                        ),
                      if (state.isLastPage)
                        RaisedButton(
                          onPressed: () {
                            BlocProvider.of<QuizBloc>(context).completeQuiz();
                          },
                          color: Colors.white,
                          child: Text("Close"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        )
                      else
                        RaisedButton(
                          onPressed: () {
                            BlocProvider.of<QuizBloc>(context).showNextPage();
                          },
                          color: Colors.white,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.green,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }
}
