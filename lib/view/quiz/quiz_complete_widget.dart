import 'package:TataEdgeDemo/model/qustions.dart';
import 'package:TataEdgeDemo/view/quiz_preview/quiz_preview_view.dart';
import 'package:flutter/material.dart';

class QuizCompleteWidget extends StatelessWidget {
  int marks;
  int total;
  List<Questions> questionList;

  QuizCompleteWidget(this.marks, this.total, this.questionList);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You have given $marks correct answer.",
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
          SizedBox(height: 30.0),
          OutlineButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 2.0),
            child: Text(
              "Close",
              style: Theme.of(context).primaryTextTheme.subtitle1,
            ),
          ),
          SizedBox(height: 30.0),
          OutlineButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => QuizPreviewWidget(questionList)));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 2.0),
            child: Text(
              "Preview",
              style: Theme.of(context).primaryTextTheme.subtitle1,
            ),
          )
        ],
      )),
    );
  }
}
