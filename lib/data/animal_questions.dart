import 'package:TataEdgeDemo/data/qustions.dart';

class AnimalQuestions {
  List<Questions> getQuestions() {
    return [
      Questions(
        "Which amongst the following is the largest mammal?",
        [
          Options("Elephant"),
          Options("Whale", isRightAnswer: true),
          Options("Dinosaur"),
          Options("Rhinoceros"),
        ],
      ),
      Questions(
        "Which of the following is the National Aquatic Animal of India?",
        [
          Options("Salt Water Crocodile"),
          Options("Sea Turtle"),
          Options("Dugong"),
          Options("Dolphin", isRightAnswer: true),
        ],
      )
    ];
  }
}
