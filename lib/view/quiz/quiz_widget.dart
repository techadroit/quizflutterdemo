import 'dart:math' as math;

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
                return QuestionWidget(state.questions,ValueKey(state.questions.question));
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

  QuestionWidget(this.questions,Key key):super(key:key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    return Container(
      margin: EdgeInsets.all(8.0),
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
            QuestionTimeOut(),
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

final Animatable<int> _kStepTween = StepTween(begin: 10, end: 1);

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
        debugPrint(
            " i was called and the value is ${controller.value}");
        return Container(
          margin: EdgeInsets.all(16.0),
          height: 120,
          width: 120,
          child: CustomPaint(
              painter: ProgressPainter(controller.value)),
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
    double value = arcValue == 0 ? 2 : _arcConstant - arcValue;//(_arcConstant - (2 / arcValue));
    debugPrint(" the arc value is $value");
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
