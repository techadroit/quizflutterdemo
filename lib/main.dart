import 'package:TataEdgeDemo/blocs/topics/topic_bloc.dart';
import 'package:TataEdgeDemo/blocs/topics/topic_event.dart';
import 'package:TataEdgeDemo/blocs/topics/topic_state.dart';
import 'package:TataEdgeDemo/view/topic_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryTextTheme: TextTheme(
            headline1: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: new Color(0xFF342d25)),
            headline2: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                fontFamily: 'Montserrat',
                color: Colors.white.withOpacity(0.8)),
            bodyText1: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'OpenSans',
                color: Colors.black),),
        brightness: Brightness.light,
        primaryColor: new Color(0xFFc034eb),
        colorScheme: ColorScheme.light(
          primary: new Color(0xFFc034eb),
          secondary: new Color(0xffefbc5a),
          surface: new Color(0xfff6f6f8),
          onPrimary: new Color(0xffe23535),
          onSecondary: new Color(0xff88949d),
          onSurface: new Color(0xff88949d),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: TopicListWidget(),
      ),
    );
  }
}
