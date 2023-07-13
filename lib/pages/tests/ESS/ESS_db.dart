class ESSQuestion {
  final String questionText;
  final List<Answer> answersList;

  ESSQuestion(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final int answerScore;

  Answer(this.answerText, this.answerScore);
}

List<ESSQuestion> getQuestions() {
  List<ESSQuestion> list = [];

  list.add(ESSQuestion(
    "Sitting and reading",
    [
      Answer("Would never doze", 0),
      Answer("Slight chance of dozing", 1),
      Answer("Moderate chance of dozing", 2),
      Answer("High chance of dozing", 3),
    ],
  ));

  list.add(ESSQuestion(
    "Watching TV",
    [
      Answer("Would never doze", 0),
      Answer("Slight chance of dozing", 1),
      Answer("Moderate chance of dozing", 2),
      Answer("High chance of dozing", 3),
    ],
  ));

  list.add(ESSQuestion(
    "Sitting, inactive in a public place (e.g. a thatre or a meeting)",
    [
      Answer("Would never doze", 0),
      Answer("Slight chance of dozing", 1),
      Answer("Moderate chance of dozing", 2),
      Answer("High chance of dozing", 3),
    ],
  ));

  list.add(ESSQuestion(
    "As a passenger in a car for an hour without a break",
    [
      Answer("Would never doze", 0),
      Answer("Slight chance of dozing", 1),
      Answer("Moderate chance of dozing", 2),
      Answer("High chance of dozing", 3),
    ],
  ));

  list.add(ESSQuestion(
    "Lying down to rest in the afternoon when circumstances permit ",
    [
      Answer("Would never doze", 0),
      Answer("Slight chance of dozing", 1),
      Answer("Moderate chance of dozing", 2),
      Answer("High chance of dozing", 3),
    ],
  ));

  list.add(ESSQuestion(
    "Sitting and talking to someone",
    [
      Answer("Would never doze", 0),
      Answer("Slight chance of dozing", 1),
      Answer("Moderate chance of dozing", 2),
      Answer("High chance of dozing", 3),
    ],
  ));

  list.add(ESSQuestion(
    "Sitting quietly after a lunch without alcohol",
    [
      Answer("Would never doze", 0),
      Answer("Slight chance of dozing", 1),
      Answer("Moderate chance of dozing", 2),
      Answer("High chance of dozing", 3),
    ],
  ));

  list.add(ESSQuestion(
    "In a car, while stopped for a few minutes in the traffic",
    [
      Answer("Would never doze", 0),
      Answer("Slight chance of dozing", 1),
      Answer("Moderate chance of dozing", 2),
      Answer("High chance of dozing", 3),
    ],
  ));

  return list;
}
