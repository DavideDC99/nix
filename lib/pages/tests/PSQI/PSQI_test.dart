import 'package:flutter/material.dart';
import 'package:nix/pages/tests/PSQI/PSQI_db.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class PSQITest extends StatefulWidget {
  const PSQITest({super.key});

  @override
  State<PSQITest> createState() => _PSQITestState();
}

class _PSQITestState extends State<PSQITest> {
  List<PSQIQuestion> questionList = getQuestions();
  List<PSQI_SubQuestion> sub_questionList = get_SubQuestions();
  int currentQuestionIndex = 0;
  // variables used in the calculation of the final score
  int score = 0;
  var scores = [0, 0, 0, 0, 0, 0, 0];
  Answer? selectedAnswer;
  String severity = '';
  bool answerGiven = false;
  var _tabTextIndexSelected = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  int c1 = 0; 
  int c2 = 0;
  int c3 = 0;
  int partial_score = 0;
  int p3 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 92, 0, 29),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "Pittsburgh Sleep Quality Index (PSQI)",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
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
            "Question ${currentQuestionIndex + 1}/8",
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
                color: const Color.fromARGB(243, 203, 0, 64),
                borderRadius: BorderRadius.circular(16),
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                if (currentQuestionIndex >= 0 && currentQuestionIndex <= 6) {
                  return Text(questionList[currentQuestionIndex].questionText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ));
                } else {
                  return Text(
                    sub_questionList[0].mainQuestion,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
              })),
        ]);
  }

  _answerList() {
    if (currentQuestionIndex >= 0 && currentQuestionIndex <= 6) {
      return Column(
        children: questionList[currentQuestionIndex]
            .answersList
            .map(
              (e) => _answerButton(e),
            )
            .toList(),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromARGB(174, 203, 0, 64),
        ),
        height: 400,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            const Text("Select one of the four options",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )),
            const Text("0:Not during the last month",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                )),
            const Text("1:Less than once a week",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                )),
            const Text("2:Once or twice a week",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                )),
            const Text("3:Three or more times a week",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                )),
            for (int i = 0; i < 9; i++)
              Container(
                  margin: const EdgeInsets.all(10),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color.fromARGB(255, 92, 0, 29),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(),
                        Container(
                          margin: const EdgeInsets.all(20),
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(243, 203, 0, 64),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            sub_questionList[i].questionText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        _subAnswer(i)
                      ])),
          ]),
        ),
      );
    }
  }

  _subAnswer(i) {
    var listTextTabToggle = ['0', '1', '2', '3'];

    return FlutterToggleTab(
      width: 70,
      borderRadius: 30,
      height: 30,
      selectedIndex: _tabTextIndexSelected[i],
      selectedBackgroundColors: const [
        Color.fromARGB(174, 203, 0, 64),
        Color.fromARGB(255, 92, 0, 29),
      ],
      selectedTextStyle: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      unSelectedTextStyle: const TextStyle(
          color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w500),
      labels: listTextTabToggle,
      selectedLabelIndex: (index) {
        setState(() {
          _tabTextIndexSelected[i] = index;
        });
      },
      marginSelected: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                ? const Color.fromARGB(174, 203, 0, 64)
                : Colors.white,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            if (selectedAnswer == null) {
              scores[currentQuestionIndex] = answer.answerScore;
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
    if (currentQuestionIndex == 8 - 1) {
      return SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 48,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(243, 203, 0, 64),
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                _calculatingScore();
                Navigator.pop(context, score);
              },
              child: const Text("Submit")));
    } else {
      if (answerGiven == true) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 48,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(243, 203, 0, 64),
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                setState(() {
                  selectedAnswer = null;
                  currentQuestionIndex++;
                  answerGiven = false;
                });
              },
              child: const Text("Next")),
        );
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(243, 203, 0, 64),
              shape: const StadiumBorder(),
            ),
            onPressed: null,
            child: const Text("Answer the question"),
          ),
        );
      }
    }
  }

  _calculatingScore() {
    for (var i = 1; i < 5; i++) {
      partial_score += scores[i];
    }

    int p1 = scores[5] + scores[6];
    if (p1 == 0) {
      c1 = 0;
    } else if (p1 >= 1 && p1 <= 2) {
      c1 = 1;
    } else if (p1 >= 3 && p1 <= 4) {
      c1 = 2;
    } else {
      c1 = 3;
    }

    int p2 = scores[0] + _tabTextIndexSelected[0];
    if (p2 == 0) {
      c2 = 0;
    } else if (p2 >= 1 && p2 <= 2) {
      c2 = 1;
    } else if (p2 >= 3 && p2 <= 4) {
      c2 = 2;
    } else {
      c2 = 3;
    }

    for (var y = 1; y < 9; y++) {
      p3 += _tabTextIndexSelected[y];
    }
    if (p3 == 0) {
      c3 = 0;
    } else if (p3 >= 1 && p3 <= 9) {
      c3 = 1;
    } else if (p3 >= 10 && p3 <= 18) {
      c3 = 2;
    } else {
      c3 = 3;
    }

    score = partial_score + c1 + c2 + c3; //calculation of the final score

  }

}
