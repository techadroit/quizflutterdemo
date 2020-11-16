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
        "Which of the following has no Skeleton at all?",
        [
          Options("Star fish"),
          Options("Sponge"),
          Options("Jelly fish",isRightAnswer: true),
          Options("Silver fish"),
        ],
      ),
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
        "Which animal can create the loudest sound among any living creature?",
        [
          Options(" Whale shark "),
          Options("Gibbon"),
          Options("Humpback Whales", isRightAnswer: true),
          Options("Howler monkey"),
        ],
      ),
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
        "Which one of the following is not a true fish?",
        [
          Options("Silver fish"),
          Options("Saw fish "),
          Options("Hammer fish", isRightAnswer: true),
          Options("Sucker fish"),
        ],
      ),
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
