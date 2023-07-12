import 'dart:math';
import 'package:nix/database/entities/stats.dart';
import 'package:nix/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:nix/services/impact.dart';
import 'package:nix/database/database.dart';
import 'package:nix/providers/home_provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart'; //cerchietto
import 'package:nix/pages/tests/ESS/ESS_test.dart';
import 'package:nix/pages/tests/PHQ/PHQ_test.dart';
import 'package:nix/pages/tests/PSQI/PSQI_test.dart';

class MainTestPage extends StatefulWidget {
  const MainTestPage({super.key});

  @override
  State<MainTestPage> createState() => _MainTestPageState();
}

class _MainTestPageState extends State<MainTestPage> {
  int scoreESS = 15;
  int scorePHQ = 15;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
        create: (context) => HomeProvider(
              Provider.of<ImpactService>(context, listen: false),
              Provider.of<AppDatabase>(context, listen: false),
            ),
        lazy: false,
        builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.indigo.shade100,
              appBar: AppBar(
                title: const Text('Test Page'),
                backgroundColor: Color.fromARGB(255, 4, 37, 113),
                elevation: 20,
                iconTheme: const IconThemeData(color: Colors.white),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(), //non ritorna nel drawer, direttamente sull'HomePage
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_circle_left_outlined)),
              ),
              body: Provider.of<HomeProvider>(context).doneInit
                  ? SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          SizedBox(height: 40),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 4, 37, 113),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: const Icon(
                                      Icons.navigate_before,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      // here we use the access method to retrieve the Provider and use its values and methods
                                      DateTime day = Provider.of<HomeProvider>(context, listen: false).showDate;
                                      DateTime previousMonth = DateTime(day.year, day.month - 1, day.day);
                                      //da cambiare
                                      Provider.of<HomeProvider>(context, listen: false).getScoreTest(previousMonth);
                                    }),
                                Consumer<HomeProvider>(
                                    builder: (context, value, child) => Text(DateFormat('MMMM').format(value.showDate),
                                          style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                IconButton(
                                    icon: const Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    onPressed: () { 
                                    
                                      DateTime day = Provider.of<HomeProvider>(context, listen: false).showDate;
                                      DateTime nextMonth = DateTime(day.year, day.month + 1, day.day);
                                          //cambiare
                                      Provider.of<HomeProvider>(context, listen: false).getScoreTest(nextMonth);
                                    })
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                              // Container 1
                              margin: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: const Color.fromARGB(203, 203, 0, 64),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  children: [
                                    const Text(
                                        'The Pittsburgh Sleep Quality Index (PSQI) is a self-report questionnaire that assesses sleep quality over a 1-month time interval.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          //Button container
                                          width: 120,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 203, 0, 64),
                                              shape: const StadiumBorder(),
                                            ),
                                            onPressed: ! Provider.of<HomeProvider>(context, listen: false).showDate.isBefore(DateTime(DateTime.now().subtract(const Duration(days: 1)).year, DateTime.now().subtract(const Duration(days: 1)).month)) ?
                                              () async {
                                              final scorePSQI = await Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PSQITest()));
                                            Stats stats = Stats(DateTime(DateTime.now().subtract(const Duration(days: 1)).year, DateTime.now().subtract(const Duration(days: 1)).month), 1, scorePSQI);
                                            Provider.of<HomeProvider>(context, listen: false).insertScoreTest(stats);
                                            Provider.of<HomeProvider>(context, listen: false).getScoreTest(DateTime(DateTime.now().subtract(const Duration(days: 1)).year, DateTime.now().subtract(const Duration(days: 1)).month));
                                            } : null,
                                            child: const Text("Do the test", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          //results
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.transparent,
                                          ),
                                          child: Consumer<HomeProvider>(
                                            builder: (context, provider,
                                                child) =>
                                            CircularStepProgressIndicator(
                                              startingAngle: pi/2,
                                             arcSize: pi, 
                                          totalSteps: 21,
                                          currentStep: provider.scorePSQI == null ? 0 : provider.scorePSQI!,
                                          stepSize: 20,
                                          selectedColor: Color.fromARGB(
                                              230, 247, 156, 37),
                                          unselectedColor: Color.fromARGB(
                                              255, 194, 221, 225),
                                          padding: 0,
                                          width: 20,
                                          height: 20,
                                          selectedStepSize: 20,
                                          roundedCap: (_, __) => true,
                                          child: Center(
                                            child: Text(
                                              "${provider.scorePSQI}",
                                              style: const TextStyle(
                                                  fontSize: 35,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                            ),
                                          ), //inserire score
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    /*
                                    Consumer<HomeProvider>(
                                      builder: (context, provider, child) =>
                                          MessagePSQI(),
                                    )*/
                                  ],
                                ),
                              )),
                          Container(
                              // container 2
                              margin: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: const Color.fromARGB(187, 247, 156, 37),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  children: [
                                    const Text(
                                        'The Epworth Sleepiness Scale (ESS) is a scale intended to measure daytime sleepiness.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          //Button container
                                          width: 120,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 247, 157, 37),
                                              shape: const StadiumBorder(),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ESSTest()));
                                            },
                                            child: const Text("Do the test",style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          )),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 175,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromARGB(255, 80, 48, 6),
                                          ),
                                          child: Container(
                                              child: Consumer<HomeProvider>(
                                            builder: (context, provider,
                                                    child) =>
                                                CircularStepProgressIndicator(
                                              totalSteps: 24,
                                              currentStep: provider.scoreESS == null ? 0 : provider.scoreESS!,
                                              arcSize: pi,
                                              stepSize: 20,
                                              selectedColor: Color.fromARGB(
                                                  230, 247, 156, 37),
                                              unselectedColor: Color.fromARGB(
                                                  255, 194, 221, 225),
                                              padding: 0,
                                              width: 150,
                                              height: 150,
                                              selectedStepSize: 20,
                                              roundedCap: (_, __) => true,
                                              child: Center(
                                                child: Text(
                                                  "${provider.scoreESS}",
                                                  style: const TextStyle(
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Consumer<HomeProvider>(
                                      builder: (context, provider, child) =>
                                          MessageESS(scoreESS),
                                      //MessagePSQI(provider.score),
                                    )
                                  ],
                                ),
                              )),        
                          Container(
                              // container 3
                              margin: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: const Color.fromARGB(158, 118, 195, 76),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  children: [
                                    const Text(
                                        'The 9-question Patient Health Questionnaire (PHQ-9) is a diagnostic tool to screen adult for the presence and severity of depression.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      252, 118, 195, 76),
                                              shape: const StadiumBorder(),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PHQTest())); //mandare a fare il test
                                            },
                                            child: const Text("Do the test",style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          )),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 175,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                158, 118, 195, 76),
                                          ),
                                          child: Container(
                                              child: Consumer<HomeProvider>(
                                            builder: (context, provider,
                                                    child) =>
                                                CircularStepProgressIndicator(
                                              totalSteps: 27,
                                              currentStep: provider.scorePHQ == null ? 0 : provider.scorePHQ!,
                                              stepSize: 20,
                                              selectedColor: Color.fromARGB(
                                                  230, 247, 156, 37),
                                              unselectedColor: Color.fromARGB(
                                                  255, 194, 221, 225),
                                              padding: 0,
                                              width: 150,
                                              height: 150,
                                              selectedStepSize: 20,
                                              roundedCap: (_, __) => true,
                                              child: Center(
                                                child: Text(
                                                  "${provider.scorePHQ}",
                                                  style: const TextStyle(
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Consumer<HomeProvider>(
                                      builder: (context, provider, child) =>
                                          MessageESS(scorePHQ),
                                      //MessagePSQI(provider.score),
                                    )
                                  ],
                                ),
                              ))
                        ]))
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            )));
  }

  MessagePSQI(score) {
    String severity = '';
    if (score >= 1 && score <= 7) {
      severity = "mild sleep difficulty";
    } else if (score >= 8 && score <= 14) {
      severity = 'moderate sleep difficulty';
    } else if (score == 0) {
      severity = 'no sleep difficulty';
    } else if (score == null) {
      severity = 'this test has not been done';
    } else {
      severity = 'severe sleep difficulty';
    }

    return Text(
      "$severity",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.0, color: Colors.white),
    );
  }

  MessageESS(score) {
    String severity = '';
    if (score >= 0 && score <= 9) {
      severity = " normal range";
    } else if (score >= 10 && score <= 12) {
      severity = ' borderline';
    } else {
      severity = 'n abnormal';
    }

    return Text(
      "This score corresponds to a$severity level",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.0, color: Colors.white),
    );
  }

  MessagePHQ(score) {
    String severity = '';
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

    return Text(
      "This score corresponds to a $severity level",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.0, color: Colors.white),
    );
  }

}
