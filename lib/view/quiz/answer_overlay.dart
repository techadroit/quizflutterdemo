// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

class AnswerOverlay extends StatefulWidget {
  String tag;
  bool isCorrect = false;

  AnswerOverlay(this.tag, this.isCorrect);

  @override
  State<StatefulWidget> createState() {
    return AnswerOverlayState(tag);
  }
}

class AnswerOverlayState extends State<AnswerOverlay>
    with SingleTickerProviderStateMixin {
  String tag;

  AnswerOverlayState(this.tag);

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 1000),
    );

    Future.delayed(Duration(milliseconds: 1000), () {
      animationController.forward();
    });

    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 2000), () {
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    timeDilation = 2.0;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: FlipView(
            animationController: animationController,
            back: Container(
              height: 180,
              width: 180,
              child: Card(
                child: widget.isCorrect
                    ? Image.asset("assets/wrong.png")
                    : Image.asset("assets/check.png"),
              ),
            ),
            front: Container(
              height: 180,
              width: 180,
              child: Hero(
                tag: tag,
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            tag,
                            style: textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
