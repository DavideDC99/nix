import 'package:flutter/material.dart';
import 'package:nix/database/database.dart';
import 'package:nix/providers/home_provider.dart';
import 'package:nix/services/impact.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:provider/provider.dart';

class ScoreResults extends StatefulWidget {
  @override
  _ScoreResultsState createState() => _ScoreResultsState();
}

class _ScoreResultsState extends State<ScoreResults> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(
        Provider.of<ImpactService>(context, listen: false),
        Provider.of<AppDatabase>(context, listen: false),
      ),
      lazy: false,
      builder: (context, child) => Provider.of<HomeProvider>(context).doneInit
          ? SingleChildScrollView(
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 320.0,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 35, 95, 38),
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Discover your score!',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _ScoreWidget(provider.wellbeingscore),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(16.0),
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromARGB(255, 35, 95, 38),
                        ),
                        child: _summary(provider.wellbeingscore),
                      ),
                    )
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _ScoreWidget(int score) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: CircularStepProgressIndicator(
        totalSteps: 100,
        currentStep: score,
        stepSize: 20,
        selectedColor: Color.fromARGB(255, 151, 63, 116),
        unselectedColor: Color.fromARGB(255, 245, 190, 190),
        padding: 0,
        width: 220,
        height: 220,
        selectedStepSize: 20,
        roundedCap: (_, __) => true,
        child: Center(
          child: Text(
            "${score}",
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _summary(int score) {
    String severity = '';
    if (score >= 0 && score <= 20) {
      severity = "You reached a very low score!";
    } else if (score >= 21 && score <= 40) {
      severity = "You reached a low score!";
    } else if (score >= 41 && score <= 60) {
      severity = "You reached a medium score!";
    } else if (score >= 61 && score <= 80) {
      severity = "You reached a high score!";
    } else {
      severity = 'You reached a very high score!';
    }

    String message = '';
    if (score >= 0 && score <= 20) {
      message =
          "Make an effort to take more steps and improve your sleep quality to feel more energetic and fit!";
    } else if (score >= 21 && score <= 40) {
      message =
          "Work on incorporating more physical activity and establishing a more regular sleep routine to improve your overall health!";
    } else if (score >= 41 && score <= 60) {
      message =
          "You can do better! Try to increase your daily step count and aim for more rejuvenating sleep to reach higher levels of well-being!";
    } else if (score >= 61 && score <= 80) {
      message =
          "Keep engaging in physical activity and maintaining good sleep habits to sustain this optimal level of health!";
    } else {
      message =
          'Congratulations! Keep taking steps forward and prioritize your rest to enjoy a healthy and fulfilling life!';
    }
    return Column(children: [
      Text(
        "$severity",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: Container(
              height: 25,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(15)),
                color: Colors.red,
              ),
              child: const Center(
                  child: Text('Very low',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            child: Container(
              height: 25,
              color: Colors.deepOrangeAccent,
              child: const Center(
                  child: Text('Low',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            child: Container(
              height: 25,
              color: Colors.orange,
              child: const Center(
                  child: Text('Medium',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            child: Container(
              height: 25,
              color: Color.fromARGB(255, 106, 216, 109),
              child: const Center(
                  child: Text('High',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            child: Container(
              height: 25,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(15)),
                color: Colors.green,
              ),
              child: const Center(
                  child: Text('Very High',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('00',
              style: TextStyle(
                color: Colors.transparent,
              )),
          Text('20',
              style: TextStyle(
                color: Colors.white,
              )),
          Text('40',
              style: TextStyle(
                color: Colors.white,
              )),
          Text('60',
              style: TextStyle(
                color: Colors.white,
              )),
          Text('80',
              style: TextStyle(
                color: Colors.white,
              )),
          Text('00',
              style: TextStyle(
                color: Colors.transparent,
              )),
        ],
      ),
      SizedBox(height: 20),
      Text(
        "$message",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    ]);
  }
}
