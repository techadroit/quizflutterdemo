import 'package:TataEdgeDemo/data/animal_questions.dart';
import 'package:TataEdgeDemo/data/categories.dart';
import 'package:TataEdgeDemo/data/planet_questions.dart';
import 'package:TataEdgeDemo/data/qustions.dart';

import 'topics.dart';

class DataSource {
  List<Topics> getTopics() {
    return [
      Topics("Animal", "1", categories: Categories.animal),
      Topics("Plant", "2", categories: Categories.plants),
      Topics("Planet", "3", categories: Categories.planet),
      Topics("Birds", "4", categories: Categories.birds),
    ];
  }

  List<Questions> getQuestions(Categories categories) {
    if (categories == Categories.planet)
      return PlanetQuestions().getQuestions();
    else
      return AnimalQuestions().getQuestions();
  }
}
