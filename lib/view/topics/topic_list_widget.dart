import 'package:TataEdgeDemo/blocs/topics/topic_bloc.dart';
import 'package:TataEdgeDemo/blocs/topics/topic_event.dart';
import 'package:TataEdgeDemo/blocs/topics/topic_state.dart';
import 'package:TataEdgeDemo/view/quiz/quiz_intro_widget.dart';
import 'package:TataEdgeDemo/view/quiz/quiz_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .primaryTextTheme;
    return SafeArea(
        child: BlocBuilder(
          cubit: TopicBloc()
            ..add(LoadTopicEvent()),
          builder: (context, state) {
            if (state is LoadTopicsSuccess) {
              var list = state.list;
              return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (context, index) =>
                      Divider(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSurface,
                      ),
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          var categories = list[index].categories;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => QuizIntroWidget(categories)));
                        },
                        title: Text(
                          list[index].name,
                          style: textTheme.headline1,
                        ));
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
