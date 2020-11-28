import 'package:TataEdgeDemo/model/categories.dart';

import '../../model/topics.dart';

class LocalDatasource {
  List<Topics> getTopics() {
    return [
      Topics("Linux", "1", categories: Categories.linux),
      Topics("Cloud", "1", categories: Categories.cloud),
      Topics("DevOps", "1", categories: Categories.devops),
      Topics("Docker", "1", categories: Categories.docker),
      Topics("Kubernates", "1", categories: Categories.kubernates),
      Topics("Networking", "1", categories: Categories.networking),
    ];
  }
}
