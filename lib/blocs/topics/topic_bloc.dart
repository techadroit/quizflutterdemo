import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/blocs/topics/topic_event.dart';
import 'package:TataEdgeDemo/blocs/topics/topic_state.dart';
import 'package:TataEdgeDemo/data/datasource/local_datasource.dart';

class TopicBloc extends BaseBloc<TopicEvent, TopicState> {
  LocalDatasource dataSource = new LocalDatasource();

  TopicBloc() : super(TopicNonInitialized());

  @override
  Stream<TopicState> mapEventToState(TopicEvent event) async* {
    if (event is LoadTopicEvent) {
      yield new TopicsLoadInProgress();
      yield new LoadTopicsSuccess(dataSource.getTopics());
    }
  }
}
