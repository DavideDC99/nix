class PSQIQuestion {
  final String questionText;
  final List<Answer> answersList;

  PSQIQuestion(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final int answerScore; 

  Answer(this.answerText, this.answerScore);
}

List<PSQIQuestion> getQuestions() {
  List<PSQIQuestion> list = [];

  list.add(PSQIQuestion(
    "During the past month, how long (in minutes) has it usually taken you to fall asleep each night?",
    [
      Answer("<15 minutes", 0),
      Answer("16-30 minutes", 1),
      Answer("31-60 minutes", 2),
      Answer(">60 minutes", 3),
    ],
  ));

list.add(PSQIQuestion(
    "During the past month, how many hours of actual sleep did you get at night?",
    [
      Answer(">7 hours", 0),
      Answer("6-7 hours", 1),
      Answer("5-6 hours", 2),
      Answer("<5 hours", 3),
    ],
  ));

list.add(PSQIQuestion(
    "During the past month, what was your Habitual Sleep Efficiency?",
    [
      Answer("> 85 %", 0),
      Answer("75 - 84 %", 1),
      Answer("65 - 74 %", 2),
      Answer("< 65 %", 3),
    ],
  ));

list.add(PSQIQuestion(
    "During the past month, how would you rate your sleep quality overall?",
    [
      Answer("Very good", 0),
      Answer("Fairly good", 1),
      Answer("Fairly bad", 2),
      Answer("Very", 3),
    ],
  ));

list.add(PSQIQuestion(
    'During the past month, how  often have you taken medicine (prescribed or "over the counter") to help you sleep?',
    [
      Answer("Not during the last month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ],
  ));

  list.add(PSQIQuestion(
    'During the past month, how  often have you had trouble staying awake while driving, eating meals, or engaging in social activity?',
    [
      Answer("Not during the last month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ],
  ));

  list.add(PSQIQuestion(
    'During the past month, how  much of a problem has it been for you to keep up enthusiasm to get things done?',
    [
      Answer("No problem at all", 0),
      Answer("Only a very slight problem", 1),
      Answer("Somewhat of a problem", 2),
      Answer("A very big problem", 3),
    ],
  ));

  return list;
}


class PSQI_SubQuestion {
  final String questionText;
  final List<Answer> answersList;
  final String mainQuestion;

  PSQI_SubQuestion(this.mainQuestion,this.questionText, this.answersList);
}


List<PSQI_SubQuestion> get_SubQuestions() {
  List<PSQI_SubQuestion> list = [];
  
  list.add(PSQI_SubQuestion(
    "During the past month, how often have you had trouble sleeping because you...",
    "Cannot get to sleep within 30 minutes",
    [
      Answer("Not during the past month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ]
  ));

  list.add(PSQI_SubQuestion(
    "During the past month, how often have you had trouble sleeping because you...",
    "Wake up in the middle of the night or early morning",
    [
      Answer("Not during the past month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ]
  ));

  list.add(PSQI_SubQuestion(
    "During the past month, how often have you had trouble sleeping because you...",
    "Have to get up to use the bathroom",
    [
      Answer("Not during the past month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ]
  ));
   
  list.add(PSQI_SubQuestion(
    "During the past month, how often have you had trouble sleeping because you...",
    "Cannot breath comfortably",
    [
      Answer("Not during the past month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ]
  ));
   

  list.add(PSQI_SubQuestion(
    "During the past month, how often have you had trouble sleeping because you...",
    "Cough or snore loudly",
    [
      Answer("Not during the past month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ]
  ));
   

  list.add(PSQI_SubQuestion(
    "During the past month, how often have you had trouble sleeping because you...",
    "Feel too cold",
    [
      Answer("Not during the past month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ]
  ));
   

  list.add(PSQI_SubQuestion(
    "During the past month, how often have you had trouble sleeping because you...",
    "Feel too hot",
    [
      Answer("Not during the past month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ]
  ));
   

   list.add(PSQI_SubQuestion(
    "During the past month, how often have you had trouble sleeping because you...",
    "Have bad dreams",
    [
      Answer("Not during the past month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ]
  ));
   

   list.add(PSQI_SubQuestion(
    "During the past month, how often have you had trouble sleeping because you...",
    "Have pain",
    [
      Answer("Not during the past month", 0),
      Answer("Less than once a week", 1),
      Answer("Once or twice a week", 2),
      Answer("Three or more times a week", 3),
    ]
  ));
  
  return list;
}