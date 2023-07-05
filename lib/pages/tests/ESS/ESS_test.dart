
import 'package:flutter/material.dart';
import 'package:nix/pages/tests/ESS/ESS_db.dart';
import 'package:nix/pages/maintests_page.dart';

class ESSTest extends StatefulWidget {
  const ESSTest({super.key});

  @override
  State<ESSTest> createState() => _ESSTestState();
}

class _ESSTestState extends State<ESSTest> {

  List<ESSQuestion> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;
  String severity='';
  bool answerGiven=false;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(187, 247, 156, 37),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "Epworth Sleepiness Scale",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const Text(
            "How likely are you to doze off or fall asleep in the situation described below, in contrast to feeling tired?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),const Text(
            "Even if you have not done this thing recently, try to understand how it would affect you",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
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
            color: const Color.fromARGB(255, 247, 157, 37),
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
          foregroundColor: isSelected ? Colors.white : Colors.black, backgroundColor: isSelected ? const Color.fromARGB(255, 247, 157, 37) : Colors.white, shape: const StadiumBorder(),
        ),
        onPressed: () {
          if (selectedAnswer == null) {
              score=score + answer.answerScore;
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
          foregroundColor: Colors.white, backgroundColor: const  Color.fromARGB(255, 247, 157, 37), shape: const StadiumBorder(),
        ),
        onPressed: () {
          if (isLastQuestion) {

            showDialog(context: context, builder: (_) => _showScoreDialog());
          } else {
            
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
          foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 247, 157, 37), shape: const StadiumBorder(),
        ),
        onPressed:null,
        child: const Text("Answer the question"),
      ),
    );
    }   
  } 

  _showScoreDialog() {
    if (score >= 0 && score <= 9) {
      severity = " normal range";
    } else if (score >= 10 && score <= 12) {
      severity = ' borderline';
    } else {
      severity = 'n abnormal';
    }

   return AlertDialog(
    shape: RoundedRectangleBorder(
		borderRadius: BorderRadius.circular(14)),
      title: Text(
        "You achieved a final score of: '$score'",
        style: const TextStyle(color: Colors.black),
      ),
      content:Text (
        "This score corresponds to a$severity level",
         style: const TextStyle(color: Colors.black),
        ),
      actions: <Widget> [
       ElevatedButton(
        style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 247, 157, 37), shape: const StadiumBorder(),
        ),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;
            score = 0;
            selectedAnswer = null;
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainTestPage()));
          });
        },
        child: const Text("Finish"),
      ),
  ]);
  }
}
