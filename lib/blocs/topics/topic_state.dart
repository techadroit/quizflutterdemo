import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/model/topics.dart';

class TopicState extends AppState{}

class TopicNonInitialized extends TopicState{}

class LoadTopicsSuccess extends TopicState{
  List<Topics> list;
  LoadTopicsSuccess(this.list);
}

class TopicsLoadInProgress extends TopicState{}