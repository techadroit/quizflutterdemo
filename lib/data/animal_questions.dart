import 'package:TataEdgeDemo/data/qustions.dart';

class AnimalQuestions {
  List<Questions> getQuestions() {
    return [
      Questions(
          "Which amongst the following is the largest mammal?",
          [
            Options("Elephant"),
            Options("Whale"),
            Options("Dinosaur"),
            Options("Rhinoceros"),
          ],
          Options("Whale")),
      Questions(
          "Which of the following is the National Aquatic Animal of India?",
          [
            Options("Salt Water Crocodile"),
            Options("Sea Turtle"),
            Options("Dugong"),
            Options("Dolphin"),
          ],
          Options("Dolphin")),
    ];
  }
}
