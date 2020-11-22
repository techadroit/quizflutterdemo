// To parse this JSON data, do
//
//     final questionsListResponse = questionsListResponseFromJson(jsonString);

import 'dart:convert';

class QuestionsListResponse {
  QuestionsListResponse({
    this.id,
    this.question,
    this.description,
    this.answers,
    this.multipleCorrectAnswers,
    this.correctAnswers,
    this.correctAnswer,
    this.explanation,
    this.tip,
    this.tags,
    this.category,
    this.difficulty,
  });

  // for testing
  QuestionsListResponse.mock() {
    this.id = 1;
    this.question = "what is your os";
    this.correctAnswers = CorrectAnswers.mock();
    this.answers = Answers.mock();
  }

  int id;
  String question;
  dynamic description;
  Answers answers;
  String multipleCorrectAnswers;
  CorrectAnswers correctAnswers;
  String correctAnswer;
  String explanation;
  dynamic tip;
  List<Tag> tags;
  Category category;
  Difficulty difficulty;

  factory QuestionsListResponse.fromRawJson(String str) =>
      QuestionsListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionsListResponse.fromJson(Map<String, dynamic> json) =>
      QuestionsListResponse(
        id: json["id"],
        question: json["question"],
        description: json["description"],
        answers: Answers.fromJson(json["answers"]),
        multipleCorrectAnswers: json["multiple_correct_answers"],
        correctAnswers: CorrectAnswers.fromJson(json["correct_answers"]),
        correctAnswer:
            json["correct_answer"] == null ? null : json["correct_answer"],
        explanation: json["explanation"] == null ? null : json["explanation"],
        tip: json["tip"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        category: categoryValues.map[json["category"]],
        difficulty: difficultyValues.map[json["difficulty"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "description": description,
        "answers": answers.toJson(),
        "multiple_correct_answers": multipleCorrectAnswers,
        "correct_answers": correctAnswers.toJson(),
        "correct_answer": correctAnswer == null ? null : correctAnswer,
        "explanation": explanation == null ? null : explanation,
        "tip": tip,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "category": categoryValues.reverse[category],
        "difficulty": difficultyValues.reverse[difficulty],
      };
}

class Answers {
  Answers({
    this.answerA,
    this.answerB,
    this.answerC,
    this.answerD,
    this.answerE,
    this.answerF,
  });

  // for testing
  Answers.mock() {
    this.answerA = "answera";
    this.answerB = "answerb";
    this.answerC = "answerc";
    this.answerD = "answerd";
    this.answerE = "answere";
    this.answerF = "answerf";
  }

  String answerA;
  String answerB;
  String answerC;
  String answerD;
  String answerE;
  String answerF;

  factory Answers.fromRawJson(String str) => Answers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
        answerA: json["answer_a"],
        answerB: json["answer_b"],
        answerC: json["answer_c"],
        answerD: json["answer_d"],
        answerE: json["answer_e"] == null ? null : json["answer_e"],
        answerF: json["answer_f"] == null ? null : json["answer_f"],
      );

  Map<String, dynamic> toJson() => {
        "answer_a": answerA,
        "answer_b": answerB,
        "answer_c": answerC,
        "answer_d": answerD,
        "answer_e": answerE == null ? null : answerE,
        "answer_f": answerF == null ? null : answerF,
      };
}

enum Category { LINUX }

final categoryValues = EnumValues({"Linux": Category.LINUX});

class CorrectAnswers {
  CorrectAnswers({
    this.answerACorrect,
    this.answerBCorrect,
    this.answerCCorrect,
    this.answerDCorrect,
    this.answerECorrect,
    this.answerFCorrect,
  });

  CorrectAnswers.mock() {
    this.answerACorrect = "true";
    this.answerBCorrect = "false";
    this.answerCCorrect = "false";
    this.answerDCorrect = "false";
    this.answerECorrect = "false";
    this.answerFCorrect = "false";
  }

  String answerACorrect;
  String answerBCorrect;
  String answerCCorrect;
  String answerDCorrect;
  String answerECorrect;
  String answerFCorrect;

  factory CorrectAnswers.fromRawJson(String str) =>
      CorrectAnswers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CorrectAnswers.fromJson(Map<String, dynamic> json) => CorrectAnswers(
        answerACorrect: json["answer_a_correct"],
        answerBCorrect: json["answer_b_correct"],
        answerCCorrect: json["answer_c_correct"],
        answerDCorrect: json["answer_d_correct"],
        answerECorrect: json["answer_e_correct"],
        answerFCorrect: json["answer_f_correct"],
      );

  Map<String, dynamic> toJson() => {
        "answer_a_correct": answerACorrect,
        "answer_b_correct": answerBCorrect,
        "answer_c_correct": answerCCorrect,
        "answer_d_correct": answerDCorrect,
        "answer_e_correct": answerECorrect,
        "answer_f_correct": answerFCorrect,
      };
}

enum Difficulty { MEDIUM, EASY, HARD }

final difficultyValues = EnumValues({
  "Easy": Difficulty.EASY,
  "Hard": Difficulty.HARD,
  "Medium": Difficulty.MEDIUM
});

class Tag {
  Tag({
    this.name,
  });

  String name;

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
