import 'package:flutter/material.dart';
import 'package:nix/pages/tests/PHQ/PHQ_db.dart';
import 'package:nix/pages/maintests_page.dart';

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
  String severity='';
  bool answerGiven=false;
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(158, 118, 195, 76),
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
          foregroundColor: isSelected ? Colors.white : Colors.black, backgroundColor: isSelected ? const Color.fromARGB(158, 118, 195, 76) : Colors.white, shape: const StadiumBorder(),
        ),
        onPressed: () {
          if (selectedAnswer == null) {
              score=score + answer.answerScore ;
            }
            setState(() {
              selectedAnswer = answer;
              answerGiven=true;
            });
          },
        child: Text(answer.answerText)
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    if (answerGiven==true) {
      return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(158, 118, 195, 76), shape: const StadiumBorder(),
        ),
        onPressed: () {
          if (isLastQuestion) {

            showDialog(context: context, builder: (_) => _showScoreDialog());
          } else {
            //next question
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
              answerGiven=false;
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
          foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(158, 118, 195, 76), shape: const StadiumBorder(),
        ),
        onPressed:null,
        child: const Text("Answer the question"),
      ),
    );
    }
  }

  _showScoreDialog() {
    if (score >= 1 && score <= 4) {
      severity = "minimal depression";
    } else if (score >= 5 && score <= 9) {
      severity = 'mild depression';
    } else if (score >= 10 && score <= 14) {
      severity = 'moderate depression';
    } else if (score >= 15 && score <= 19) {
      severity = 'moderately severe depression';
    } else if (score >= 20) {
      severity = 'severe depression';
    } else {
      severity = 'null depression';
    }

   return AlertDialog(
    shape: RoundedRectangleBorder(
		borderRadius: BorderRadius.circular(14)),
      title: Text(
        "You achieved a final score of: '$score'",
        style: const TextStyle(color: Colors.black),
      ),
      content:Text (
        "This score corresponds to a $severity level",
         style: const TextStyle(color: Colors.black),
        ),
      actions: <Widget> [
       ElevatedButton(
        style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(158, 118, 195, 76), shape: const StadiumBorder(),
        ),
        child: const Text("Finish"),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;
            score = 0;
            selectedAnswer = null;
             Navigator.push(context, MaterialPageRoute(builder: (context) => const MainTestPage()));
          });
        },
      ),
  ]);
  }
}
