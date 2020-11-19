import 'package:TataEdgeDemo/data/animal_questions.dart';
import 'package:TataEdgeDemo/data/categories.dart';
import 'package:TataEdgeDemo/data/qustions.dart';

import 'topics.dart';

class DataSource {
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

  List<Questions> getQuestions(Categories categories) {
    return AnimalQuestions().getQuestions();
  }
}
