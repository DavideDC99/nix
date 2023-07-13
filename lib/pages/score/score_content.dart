import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        width: 250,
        height: 250,
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
    if (score == null) {
      severity = 'This test has not been done';
    } else if (score >= 0 && score <= 9) {
      severity = "This score corresponds to a normal range level";
    } else if (score >= 10 && score <= 12) {
      severity = 'This score corresponds to a borderline level';
    } else {
      severity = 'This score corresponds to an abnormal level';
    }
    return Column(children: [
      Text('Range',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
      SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: Container(
              height: 25,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(15)),
                color: Colors.green,
              ),
              child: const Center(
                  child: Text('Normal  \n0 - 10',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            child: Container(
              height: 25,
              color: Colors.orange,
              child: const Center(
                  child: Text('Borderline \n10 - 12',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            child: Container(
              height: 25,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(15)),
                color: Colors.red,
              ),
              child: const Center(
                  child: Text('Abnormal \n12 - 24',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                      textAlign: TextAlign.center)),
            ),
          ),
        ],
      ),
      SizedBox(height: 20),
      Text(
        "$severity",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      )
    ]);
  }
}
