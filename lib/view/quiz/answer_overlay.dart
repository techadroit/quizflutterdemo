// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnswerOverlay extends StatelessWidget{

  String tag;

  AnswerOverlay(this.tag);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    timeDilation = 2.0;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Container(
            height: 150,
            width: 150,
            child: Hero(
              tag:tag,
              child: Card(
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Wolf",
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
    );
  }
  
}