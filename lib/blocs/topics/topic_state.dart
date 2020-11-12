import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/data/topics.dart';

class TopicState extends AppState{}

class TopicNonInitialized extends TopicState{}

class TopicsLoaded extends TopicState{
  List<Topics> list;
  TopicsLoaded(this.list);
}

class TopicsLoading extends TopicState{}