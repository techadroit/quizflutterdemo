import 'package:TataEdgeDemo/blocs/base_bloc.dart';
import 'package:TataEdgeDemo/blocs/topics/topic_event.dart';
import 'package:TataEdgeDemo/blocs/topics/topic_state.dart';
import 'package:TataEdgeDemo/data/datasource.dart';

class TopicBloc extends BaseBloc<TopicEvent, TopicState> {
  DataSource dataSource = new DataSource();

  TopicBloc() : super(TopicNonInitialized());

  @override
  Stream<TopicState> mapEventToState(TopicEvent event) async* {
    if (event is LoadTopic) {
      yield new TopicsLoading();
      yield new TopicsLoaded(dataSource.getTopics());
    }
  }
}
