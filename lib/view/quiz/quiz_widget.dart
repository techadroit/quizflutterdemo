import 'dart:math' as math;

import 'package:TataEdgeDemo/blocs/quiz/quiz_bloc.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_event.dart';
import 'package:TataEdgeDemo/blocs/quiz/quiz_state.dart';
import 'package:TataEdgeDemo/data/categories.dart';
import 'package:TataEdgeDemo/data/qustions.dart';
import 'package:TataEdgeDemo/view/quiz/answer_overlay.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizWidget extends StatelessWidget {
  var bloc = QuizBloc();

  QuizWidget(Categories categories) {
    bloc.add(LoadQuiz(categories));
  }

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
                return QuestionWidget(
                    state.questions, ValueKey(state.questions.question));
              } else if (state is QuizComplete) {
                return QuizCompleteWidget(state.marks, state.total);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  Questions questions;

  QuestionWidget(this.questions, Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QuestionState(questions);
  }
}

class QuestionState extends State<QuestionWidget>
    with SingleTickerProviderStateMixin {
  Questions questions;
  AnimationController _controller;
  bool isReversed = false;
  ValueChanged<bool> action;

  QuestionState(this.questions);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 1000),
        vsync: this);
    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.reverse) {
        isReversed = true;
      }
    });

    action = (value) {
      if (value) _controller.reverse();
    };
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.all(8.0),
          height: double.infinity,
          child: Opacity(
            opacity: _controller.value,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  questions.question,
                  style: textTheme.headline2,
                ),
                buildTimer(context),
                Expanded(
                  child: GridView.builder(
                      itemCount: questions.options.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        var option = questions.options[index];
                        return AnswerWidget(option, action);
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTimer(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 30.0,
            left: 40.0,
            child: ScaleAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                onFinished: () {
                  BlocProvider.of<QuizBloc>(context).add(ShowNext());
                },
                totalRepeatCount: 1,
                duration: Duration(milliseconds: 600),
                text: [
                  "10",
                  "09",
                  "08",
                  "07",
                  "06",
                  "05",
                  "04",
                  "03",
                  "02",
                  "01"
                ],
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 60.0,
                    fontFamily: "OpenSans"),
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.center // or Alignment.topLeft
                ),
          ),
          QuestionTimeOut(),
        ],
      ),
    );
  }
}

class AnswerWidget extends StatefulWidget {
  Options options;
  ValueChanged<bool> action;

  AnswerWidget(this.options, this.action);

  @override
  State<StatefulWidget> createState() {
    return AnswerState(options);
  }
}

class AnswerState extends State<AnswerWidget> {
  Options options;
  var offset = Offset(0.0, 0.0);

  AnswerState(this.options);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
       await Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) =>
                AnswerOverlay(options.answer, options.isRightAnswer)));
        widget.action.call(true);
        Future.delayed(Duration(milliseconds: 1000), () {
          BlocProvider.of<QuizBloc>(context).add(SubmitAnswer(options));
        });
      },
      child: Hero(
        tag: options.answer,
        child: Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    options.answer,
                    style: textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizCompleteWidget extends StatelessWidget {
  int marks;
  int total;

  QuizCompleteWidget(this.marks, this.total);

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
          )
        ],
      )),
    );
  }
}

class QuestionTimeOut extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuestionTimeOutState();
  }
}

class QuestionTimeOutState extends State<QuestionTimeOut>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 10),
      lowerBound: 0.0,
      upperBound: 2.0,
      vsync: this,
    )..forward();
    // controller.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          margin: EdgeInsets.all(16.0),
          height: 120,
          width: 120,
          child: CustomPaint(painter: ProgressPainter(controller.value)),
        );
      },
    );
  }
}

class ProgressPainter extends CustomPainter {
  double arcValue = 2;
  int _arcConstant = 2;

  // double _twoPi = math.pi * arcValue;
  // double _epsilon = 0;
  // // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  // double _sweep = _twoPi - _epsilon;
  static const double startAngle = 270 * (math.pi / 180);

  ProgressPainter(this.arcValue);

  @override
  void paint(Canvas canvas, Size size) {
    // double _sweep = math.pi * _arcConstant/arcValue;
    double value = arcValue == 0
        ? 2
        : _arcConstant - arcValue; //(_arcConstant - (2 / arcValue));
    double _sweep = -(math.pi * value);

    var paint = Paint()
      ..color = Color(0xFFc034eb)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, 60, paint);
    var paintRed = Paint()
      ..color = new Color(0xffe23535)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Offset.zero & size, startAngle, _sweep, false, paintRed);
  }

  @override
  bool shouldRepaint(ProgressPainter oldDelegate) {
    return oldDelegate.arcValue != arcValue;
  }
}
