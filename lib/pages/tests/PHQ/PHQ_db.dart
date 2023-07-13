class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final int answerScore;

  Answer(this.answerText, this.answerScore);
}

List<Question> getQuestions() {
  List<Question> list = [];

  list.add(Question(
    "Little interest or pleasure in doing things",
    [
      Answer("Not at all", 0),
      Answer("Several days", 1),
      Answer("More than half the days", 2),
      Answer("Nearly every day", 3),
    ],
  ));

  list.add(Question(
    "Feeling down, depressed, or hopeless",
    [
      Answer("Not at all", 0),
      Answer("Several days", 1),
      Answer("More than half the days", 2),
      Answer("Nearly every day", 3),
    ],
  ));

  list.add(Question(
    "Trouble falling or staying asleep, or sleeping too much",
    [
      Answer("Not at all", 0),
      Answer("Several days", 1),
      Answer("More than half the days", 2),
      Answer("Nearly every day", 3),
    ],
  ));

  list.add(Question(
    "Feeling tired or having little energy",
    [
      Answer("Not at all", 0),
      Answer("Several days", 1),
      Answer("More than half the days", 2),
      Answer("Nearly every day", 3),
    ],
  ));

  list.add(Question(
    "Poor appetite or overeating",
    [
      Answer("Not at all", 0),
      Answer("Several days", 1),
      Answer("More than half the days", 2),
      Answer("Nearly every day", 3),
    ],
  ));

  list.add(Question(
    "Feeling bad about yourself or that you are a failure or have let yourself or your family down",
    [
      Answer("Not at all", 0),
      Answer("Several days", 1),
      Answer("More than half the days", 2),
      Answer("Nearly every day", 3),
    ],
  ));

  list.add(Question(
    "Trouble concentrating on things, such as reading the newspaper or watching television ",
    [
      Answer("Not at all", 0),
      Answer("Several days", 1),
      Answer("More than half the days", 2),
      Answer("Nearly every day", 3),
    ],
  ));

  list.add(Question(
    "Moving or speaking so slowly that other people could have noticed. Or the opposite being so figety or restless that you have been moving around a lot more than usual",
    [
      Answer("Not at all", 0),
      Answer("Several days", 1),
      Answer("More than half the days", 2),
      Answer("Nearly every day", 3),
    ],
  ));

  list.add(Question(
    "Thoughts that you would be better off dead, or of hurting yourself ",
    [
      Answer("Not at all", 0),
      Answer("Several days", 1),
      Answer("More than half the days", 2),
      Answer("Nearly every day", 3),
    ],
  ));

  return list;
}
