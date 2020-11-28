import 'package:TataEdgeDemo/model/qustions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizPreviewWidget extends StatelessWidget {
  List<Questions> questions;

  QuizPreviewWidget(this.questions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: PageView.builder(
            itemCount: questions.length,
            itemBuilder: (context, position) {
              return _buildQuestion(questions[position], context);
            }),
      ),
    );
  }

  Widget _buildQuestion(Questions questions, BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    return Container(
      margin: EdgeInsets.all(8.0),
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            questions.question,
            style: textTheme.headline2,
          ),
          // buildTimer(context),
          Expanded(
            child: GridView.builder(
                itemCount: questions.options.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var option = questions.options[index];
                  return AnswerPreviewWidget(option);
                }),
          ),
          SizedBox(height: 12.0),
          if (questions.selectedOptions == null)
            Text("No options selected", style: textTheme.subtitle1)
        ],
      ),
    );
  }
}

class AnswerPreviewWidget extends StatelessWidget {
  Options options;

  AnswerPreviewWidget(this.options);

  Color getBackgroundColor() {
    if (options.isSelected && options.isRightAnswer) {
      return Colors.green;
    } else if (options.isSelected) {
      return Colors.grey;
    } else if (options.isRightAnswer) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getBackgroundColor(),
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                options.answer == null ? "random" : options.answer,
                maxLines: 3,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
