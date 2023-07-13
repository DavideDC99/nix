import 'dart:math';
import 'package:nix/database/entities/stats.dart';
import 'package:nix/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:nix/services/impact.dart';
import 'package:nix/database/database.dart';
import 'package:nix/providers/home_provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
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
                          builder: (context) => HomePage(),
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
                                      DateTime day = Provider.of<HomeProvider>(
                                              context,
                                              listen: false)
                                          .showDate;
                                      DateTime previousMonth = DateTime(
                                          day.year, day.month - 1, day.day);
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .getScoreTest(previousMonth);
                                    }),
                                Consumer<HomeProvider>(
                                    builder: (context, value, child) => Text(
                                          DateFormat('MMMM yy')
                                              .format(value.showDate),
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
                                      DateTime day = Provider.of<HomeProvider>(
                                              context,
                                              listen: false)
                                          .showDate;
                                      DateTime nextMonth = DateTime(
                                          day.year, day.month + 1, day.day);
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .getScoreTest(nextMonth);
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
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      //crossAxisAlignment:
                                          //CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          
                                          children: [
                                            SizedBox(height:20),
                                            SizedBox(
                                              
                                              width: 120,
                                              height: 50,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Color.fromARGB(255, 150, 1, 48),
                                                  shape: const StadiumBorder(),
                                                ),
                                                onPressed: !Provider.of<
                                                                HomeProvider>(
                                                            context,
                                                            listen: false)
                                                        .showDate
                                                        .isBefore(DateTime(
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days: 1))
                                                                .year,
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days: 1))
                                                                .month))
                                                    ? () async {
                                                        final scorePSQI =
                                                            await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const PSQITest()));
                                                        Stats stats = Stats(
                                                            DateTime(
                                                                DateTime.now()
                                                                    .subtract(
                                                                        const Duration(
                                                                            days:
                                                                                1))
                                                                    .year,
                                                                DateTime.now()
                                                                    .subtract(
                                                                        const Duration(
                                                                            days:
                                                                                1))
                                                                    .month),
                                                            1,
                                                            scorePSQI);
                                                        Provider.of<HomeProvider>(
                                                                context,
                                                                listen: false)
                                                            .insertScoreTest(stats);
                                                        Provider.of<HomeProvider>(
                                                                context,
                                                                listen: false)
                                                            .getScoreTest(DateTime(
                                                                DateTime.now()
                                                                    .subtract(
                                                                        const Duration(
                                                                            days:
                                                                                1))
                                                                    .year,
                                                                DateTime.now()
                                                                    .subtract(
                                                                        const Duration(
                                                                            days:
                                                                                1))
                                                                    .month));
                                                      }
                                                    : null,
                                                child: const Text(
                                                  "Do the test",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            const SizedBox(
                                      height: 30,
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
                                                  startingAngle: pi / 2,
                                                  arcSize: pi,
                                                  totalSteps: 21,
                                                  currentStep:
                                                      provider.scorePSQI == null
                                                          ? 0
                                                          : provider.scorePSQI!,
                                                  stepSize: 20,
                                                  selectedColor:Color.fromARGB(255, 150, 1, 48),
                                                  unselectedColor: Colors.indigo.shade100,
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
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Consumer<HomeProvider>(
                                      builder: (context, provider, child) =>
                                          MessagePSQI(provider.scorePSQI),
                                    )
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
                                color: Color.fromARGB(255, 240, 161, 58),
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
                                                  Color.fromARGB(255, 131, 46, 0),
                                              shape: const StadiumBorder(),
                                            ),
                                             onPressed: !Provider.of<
                                                            HomeProvider>(
                                                        context,
                                                        listen: false)
                                                    .showDate
                                                    .isBefore(DateTime(
                                                        DateTime.now()
                                                            .subtract(
                                                                const Duration(
                                                                    days: 1))
                                                            .year,
                                                        DateTime.now()
                                                            .subtract(
                                                                const Duration(
                                                                    days: 1))
                                                            .month))
                                                ? () async {
                                                    final scoreESS =
                                                        await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const ESSTest()));
                                                    Stats stats = Stats(
                                                        DateTime(
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            1))
                                                                .year,
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            1))
                                                                .month),
                                                        2,
                                                        scoreESS);
                                                    Provider.of<HomeProvider>(
                                                            context,
                                                            listen: false)
                                                        .insertScoreTest(stats);
                                                    Provider.of<HomeProvider>(
                                                            context,
                                                            listen: false)
                                                        .getScoreTest(DateTime(
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            1))
                                                                .year,
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            1))
                                                                .month));
                                                  }
                                                : null,
                                            child: const Text("Do the test",
                                                style: TextStyle(
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
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.transparent,
                                          ),
                                          child: Container(
                                              child: Consumer<HomeProvider>(
                                            builder: (context, provider,
                                                    child) =>
                                                CircularStepProgressIndicator(
                                              startingAngle: pi / 2,
                                              arcSize: pi,
                                              totalSteps: 24,
                                              currentStep:
                                                  provider.scoreESS == null
                                                      ? 0
                                                      : provider.scoreESS!,
                                              stepSize: 20,
                                              selectedColor: Color.fromARGB(255, 131, 46, 0),
                                              unselectedColor: Colors.indigo.shade100,
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
                                          MessageESS(provider.scoreESS),
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
                                color: Color.fromARGB(183, 43, 120, 1),
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
                                                  Color.fromARGB(255, 52, 87, 34),
                                              shape: const StadiumBorder(),
                                            ),
                                              onPressed: !Provider.of<
                                                            HomeProvider>(
                                                        context,
                                                        listen: false)
                                                    .showDate
                                                    .isBefore(DateTime(
                                                        DateTime.now()
                                                            .subtract(
                                                                const Duration(
                                                                    days: 1))
                                                            .year,
                                                        DateTime.now()
                                                            .subtract(
                                                                const Duration(
                                                                    days: 1))
                                                            .month))
                                                ? () async {
                                                    final scorePHQ =
                                                        await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const PHQTest()));
                                                    Stats stats = Stats(
                                                        DateTime(
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            1))
                                                                .year,
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            1))
                                                                .month),
                                                        3,
                                                        scorePHQ);
                                                    Provider.of<HomeProvider>(
                                                            context,
                                                            listen: false)
                                                        .insertScoreTest(stats);
                                                    Provider.of<HomeProvider>(
                                                            context,
                                                            listen: false)
                                                        .getScoreTest(DateTime(
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            1))
                                                                .year,
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            1))
                                                                .month));
                                                  }
                                                : null,
                                            child: const Text("Do the test",
                                                style: TextStyle(
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
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.transparent,
                                          ),
                                          child: Container(
                                              child: Consumer<HomeProvider>(
                                            builder: (context, provider,
                                                    child) =>
                                                CircularStepProgressIndicator(
                                              startingAngle: pi / 2,
                                              arcSize: pi,
                                              totalSteps: 27,
                                              currentStep:
                                                  provider.scorePHQ == null
                                                      ? 0
                                                      : provider.scorePHQ!,
                                              stepSize: 20,
                                              selectedColor: Color.fromARGB(255, 52, 87, 34),
                                              unselectedColor: Colors.indigo.shade100,
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
                                          MessagePHQ(provider.scorePHQ),
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
    if (score == null) {
      severity = 'This test has not been done';
    } else if (score >= 1 && score <= 7) {
      severity = "This score corresponds to a mild sleep difficulty";
    } else if (score >= 8 && score <= 14) {
      severity = 'This score corresponds to a moderate sleep difficulty';
    } else if (score == 0) {
      severity = 'This score corresponds to no sleep difficulty';
    } else {
      severity = 'This score corresponds to a severe sleep difficulty';
    }

    return Text(
      "$severity",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.0, color: Colors.white),
    );
  }

  MessageESS(score) {
    String severity = '';
    if (score == null) {
      severity = 'This test has not been done';
    }  else if (score >= 0 && score <= 9) {
      severity = "This score corresponds to a normal range level";
    } else if (score >= 10 && score <= 12) {
      severity = 'This score corresponds to a borderline level';
    } else {
      severity = 'This score corresponds to an abnormal level';
    }

    return Text(
      "$severity",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.0, color: Colors.white),
    );
  }

  MessagePHQ(score) {
    String severity = '';
    if (score == null) {
      severity = 'This test has not been done';
    }  else if (score >= 1 && score <= 4) {
      severity = "This score corresponds to a minimal depression level";
    } else if (score >= 5 && score <= 9) {
      severity = 'This score corresponds to a mild depression level';
    } else if (score >= 10 && score <= 14) {
      severity = 'This score corresponds to a moderate depression level';
    } else if (score >= 15 && score <= 19) {
      severity = 'This score corresponds to a moderately severe depression level';
    } else if (score >= 20) {
      severity = 'This score corresponds to a severe depression level';
    } else {
      severity = 'This score corresponds to a null depression level';
    }

    return Text(
      "$severity",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.0, color: Colors.white),
    );
  }
}
