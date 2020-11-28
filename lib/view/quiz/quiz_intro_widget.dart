import 'package:TataEdgeDemo/model/categories.dart';
import 'package:TataEdgeDemo/view/quiz/quiz_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizIntroWidget extends StatelessWidget {
  Categories categories;

  QuizIntroWidget(this.categories);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: ScaleAnimatedTextKit(
            onTap: () {
              print("Tap Event");
            },
            onFinished: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      QuizWidget.getQuizWidget(categories, context)));
            },
            duration: Duration(milliseconds: 1000),
            totalRepeatCount: 1,
            text: ["1", "2", "3"],
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 100.0,
                fontFamily: "Monteserrat"),
            textAlign: TextAlign.start,
            alignment: AlignmentDirectional.topStart // or Alignment.topLeft
            ),
      ),
    );
  }
}
