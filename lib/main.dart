import 'package:TataEdgeDemo/data/network/network_client/network_handler.dart';
import 'file:///C:/workspace/flutter_workspace/TataEdgeDemo/lib/view/topics/topic_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocLogger();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NetworkHandler(isDebugMode: true);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        buttonColor: new Color(0xff88949d),
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
          subtitle1: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'OpenSans',
              color: Colors.white.withOpacity(0.8)),
          bodyText1: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'OpenSans',
              color: Colors.black),
        ),
        brightness: Brightness.light,
        primaryColor: new Color(0xFFc034eb),
        colorScheme: ColorScheme.light(
          primary: new Color(0xFF6A50DB),
          secondary: new Color(0xffe23535),
          surface: new Color(0xfff6f6f8),
          onPrimary: new Color(0xffc034eb),
          onSecondary: new Color(0xffefbc5a),
          onSurface: new Color(0xff88949d),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            }),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: TopicListWidget()),
    );
  }
}

class BlocLogger extends BlocObserver{

  @override
  void onChange(Cubit cubit, Change change) {
    print('${cubit.runtimeType} $change');
    super.onChange(cubit, change);
  }

}
