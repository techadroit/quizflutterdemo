import 'package:TataEdgeDemo/data/qustions.dart';

class PlanetQuestions {
  List<Questions> getQuestions() {
    return [
      Questions(
        "Which of the following planet has largest number natural satellite?",
        [
          Options("Jupiter", isRightAnswer: true),
          Options("Saturn"),
          Options("Uranus"),
          Options("Neptune"),
        ],
      ),
      Questions(
        "Which of the following planet caused Pluto to lose its status as a planet?",
        [
          Options("Eris"),
          Options("Neptune"),
          Options("Makemake",isRightAnswer: true),
          Options("Uranus"),
        ],
      ),
      Questions(
        " Which of the following planet have two natural satellite  Phobos and Deimos?",
        [
          Options("Neptune"),
          Options("Mars", isRightAnswer: true),
          Options("Uranus"),
          Options("Pluto"),
        ],
      ),
      Questions(
        "What is the sun mainly made of?",
        [
          Options("Molten iron"),
          Options("Rock"),
          Options("Liquid Lava"),
          Options("Gas",isRightAnswer: true),
        ],
      ),
      Questions(
        "Which of this planet is the smallest?",
        [
          Options("Earth"),
          Options("Jupiter"),
          Options("Uranus"),
          Options("Mercury",isRightAnswer: true),
        ],
      ),
      Questions(
        "Which planet do the moons Oberon and Titania belong to?",
        [
          Options("Venus"),
          Options("Uranus",isRightAnswer: true),
          Options("Earth"),
          Options("Jupiter"),
        ],
      ),
      Questions(
        "How many moons does Mars have?",
        [
          Options("13"),
          Options("50"),
          Options("1"),
          Options("2",isRightAnswer: true),
        ],
      ),
      Questions(
        "Which is the closest planet to the sun?",
        [
          Options("Neptune"),
          Options("Mercury",isRightAnswer: true),
          Options("Venus"),
          Options("Earth"),
        ],
      ),
      Questions(
        "What is the Great Red Spot on Jupiter? ",
        [
          Options("A storm",isRightAnswer: true),
          Options("A lake"),
          Options("A volcano"),
          Options("A crater"),
        ],
      ),
    ];
  }
}


// Questions(
// "",
// [
// Options(""),
// Options(""),
// Options(""),
// Options(""),
// ],
// ),