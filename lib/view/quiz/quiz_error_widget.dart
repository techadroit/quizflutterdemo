import 'package:flutter/material.dart';

class QuizLoadErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "No Questions found for this categories.",
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
        ),
      ),
    );
  }
}