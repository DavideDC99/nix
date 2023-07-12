import 'package:flutter/material.dart';
import 'package:nix/pages/tests/PHQ/PHQ_db.dart';

class PHQTest extends StatefulWidget {
  const PHQTest({super.key});

  @override
  State<PHQTest> createState() => _PHQTestState();
}

class _PHQTestState extends State<PHQTest> {
  //define the datas
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;
  String severity = '';
  bool answerGiven = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 52, 87, 34),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "Patient Health Questionnaire",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const Text(
            "Over the last month, how often have you been bothered by any of the following problems?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          _questionWidget(),
          _answerList(),
          _nextButton(),
        ]),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Question ${currentQuestionIndex + 1}/${questionList.length.toString()}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color.fromARGB(158, 118, 195, 76),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (e) => _answerButton(e),
          )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: isSelected ? Colors.white : Colors.black,
            backgroundColor: isSelected
                ? const Color.fromARGB(158, 118, 195, 76)
                : Colors.white,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            if (selectedAnswer == null) {
              score = score + answer.answerScore;
            }
            setState(() {
              selectedAnswer = answer;
              answerGiven = true;
            });
          },
          child: Text(answer.answerText)),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    if (answerGiven == true) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(158, 118, 195, 76),
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            if (isLastQuestion) {
              Navigator.pop(context, score);
            } else {
              //next question
              setState(() {
                selectedAnswer = null;
                currentQuestionIndex++;
                answerGiven = false;
              });
            }
          },
          child: Text(isLastQuestion ? "Submit" : "Next"),
        ),
      );
    } else {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(158, 118, 195, 76),
            shape: const StadiumBorder(),
          ),
          onPressed: null,
          child: const Text("Answer the question"),
        ),
      );
    }
  }
}
