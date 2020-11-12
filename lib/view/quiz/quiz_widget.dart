import 'package:TataEdgeDemo/blocs/quiz/quiz_bloc.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_event.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_state.dart';
import 'package:TataEdgeDemo/data/categories.dart';
import 'package:TataEdgeDemo/data/qustions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizWidget extends StatelessWidget {
  var bloc = QuizBloc()..add(LoadQuiz(Categories.animal));

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        child: BlocProvider.value(
          value: bloc,
          child: BlocBuilder(
            cubit: bloc,
            builder: (context, state) {
              debugPrint(" the state is $state");
              if (state is ShowQuestion) {
                return QuestionWidget(state.questions);
              } else if (state is QuizComplete) {
                return QuizComplete();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  Questions questions;

  QuestionWidget(this.questions);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    return Container(
      height: double.infinity,
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              questions.question,
              style: textTheme.headline2,
            ),
            CircularProgressIndicator(),
            Flexible(
              child: GridView.builder(
                  itemCount: questions.options.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    var option = questions.options[index];
                    return AnswerWidget(option);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class AnswerWidget extends StatelessWidget {
  Options options;

  AnswerWidget(this.options);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    return GestureDetector(
      onTap: () {
        BlocProvider.of<QuizBloc>(context).add(ShowNext());
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              options.answer,
              style: textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}

class QuizComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Quiz Complete");
  }
}
