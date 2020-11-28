import 'dart:math' as math;

import 'package:TataEdgeDemo/blocs/questions/question_bloc.dart';
import 'package:TataEdgeDemo/blocs/questions/question_event.dart';
import 'package:TataEdgeDemo/blocs/questions/question_state.dart';
import 'package:TataEdgeDemo/model/qustions.dart';
import 'package:TataEdgeDemo/services/quiz_service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionWidget extends StatefulWidget {
  int index;

  QuestionWidget(this.index, Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QuestionState();
  }
}

class QuestionState extends State<QuestionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool isReversed = false;
  ValueChanged<bool> action;
  QuestionBloc bloc;

  QuestionState();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = QuestionBloc(RepositoryProvider.of<QuizService>(context))
      ..add(LoadQuestion(widget.index));
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 1000),
        vsync: this);

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
    return BlocBuilder(
      cubit: bloc,
      builder: (context, state) {
        debugPrint(" the state in question widget is $state");
        if (state is QuestionLoadSuccess) {
          return AnimatedBuilder(
            animation: _controller..forward(),
            builder: (context, child) {
              return _buildQuestion(state.questions);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildQuestion(Questions questions) {
    var textTheme = Theme.of(context).primaryTextTheme;
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
            // buildTimer(context),
            Expanded(
              child: GridView.builder(
                  itemCount: questions.options.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    var option = questions.options[index];
                    return BlocProvider.value(
                      value: bloc,
                      child: AnswerWidget(option, action),
                    );
                  }),
            ),
          ],
        ),
      ),
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
                  bloc.add(QuestionTimeoutEvent());
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    return GestureDetector(
      onTap: () async {
        widget.action.call(true);
        options.isSelected = true;
        BlocProvider.of<QuestionBloc>(context).add(OptionsSelected(options));
      },
      child: Card(
        color: options.isSelected ? Colors.grey : Colors.white,
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
                  style: textTheme.bodyText1,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
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
    controller.dispose();
    super.dispose();
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
