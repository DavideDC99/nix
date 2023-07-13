import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nix/database/database.dart';
import 'package:nix/pages/login/login_user.dart';
import 'package:nix/pages/maintests_page.dart';
import 'package:nix/pages/profile/ProfileSettings.dart';
import 'package:nix/pages/score_page.dart';
import 'package:nix/pages/sh_page.dart';
import 'package:nix/pages/sleep_page.dart';
import 'package:nix/pages/step_page.dart';
import 'package:nix/pages/tips_page.dart';
import 'package:nix/providers/home_provider.dart';
import 'package:nix/services/impact.dart';
import 'package:nix/utils/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:provider/provider.dart';
import 'package:nix/database/entities/entities.dart' as database;

//int currentsteps = (6000 / 10000 * 100).round();

double hoursSleep = 9;
int score = 65;
int goalsAchieved = 5;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String randomQuote = getRandomQuote();
    var prefs = Provider.of<Preferences>(context, listen: false);

    return ChangeNotifierProvider<HomeProvider>(
        create: (context) => HomeProvider(
            Provider.of<ImpactService>(context, listen: false),
            Provider.of<AppDatabase>(context, listen: false)),
        lazy: false,
        builder: (context, child) => Scaffold(
              backgroundColor: Colors.blue.shade100,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                iconTheme: const IconThemeData(
                    color: Color.fromRGBO(187, 222, 251, 1), size: 40),
                title: Row(
                  children: [
                    const SizedBox(
                      width: 90,
                    ),
                    Text(
                      'NiX',
                      style: GoogleFonts.cinzelDecorative(
                          textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(187, 222, 251, 1),
                      )),
                    ),
                    const SizedBox(
                      width: 110,
                    ),
                    FluttermojiCircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      radius: 20,
                    ),
                  ],
                ),
                centerTitle: true,
                backgroundColor: Color.fromRGBO(13, 42, 106, 1),
                elevation: 0,
              ),
              drawer: Drawer(
                  backgroundColor: Colors.blue.shade100,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'images/others/background.jpg'),
                                  fit: BoxFit.cover)),
                          accountName: Text('${prefs.usernameUser}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          accountEmail: Text(''),
                          currentAccountPicture: FluttermojiCircleAvatar(
                              backgroundColor: Colors.blue.shade100)),
                      ListTile(
                        leading: const Icon(
                          Icons.account_circle,
                          color: Color.fromRGBO(13, 42, 106, 1),
                        ),
                        title: const Text('Profile',
                            style: TextStyle(
                                color: Color.fromRGBO(13, 42, 106, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          //da modificare
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileSettings(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.check_box,
                            color: Color.fromRGBO(32, 76, 170, 1)),
                        title: const Text('Sleep Hygiene',
                            style: TextStyle(
                                color: Color.fromRGBO(32, 76, 170, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SHpage(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.tips_and_updates,
                          color: Color.fromRGBO(2, 119, 189, 1),
                        ),
                        title: const Text('Some tips',
                            style: TextStyle(
                                color: Color.fromRGBO(2, 119, 189, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => tipsPage(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.ballot_outlined,
                            color: Color.fromRGBO(0, 176, 255, 1)),
                        title: const Text('Tests',
                            style: TextStyle(
                                color: Color.fromRGBO(0, 176, 255, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MainTestPage(),
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.black),
                        title: const Text('Sign out',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onTap: () async {
                          var prefs = await Provider.of<Preferences>(context,
                              listen: false);
                          prefs.logOut = true;
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginUser(),
                            ),
                          );
                        },
                      ),
                    ],
                  )),
              body: Provider.of<HomeProvider>(context).doneInit
                  ? SingleChildScrollView(
                      child: Consumer<HomeProvider>(
                        builder: (context, provider, child) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    height: 390,
                                    width: 800,
                                    color: const Color.fromRGBO(13, 42, 106, 1),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 100),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  DateFormat(
                                                          'EEE, dd MMMM yyyy')
                                                      .format(DateTime.now()
                                                          .subtract(
                                                              const Duration(
                                                                  days: 1))),
                                                  //"${DateTime.now().subtract(const Duration(days: 1)).day}/${DateTime.now().subtract(const Duration(days: 1)).month}/${DateTime.now().subtract(const Duration(days: 1)).year}",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        187, 222, 251, 1),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                 Text('Good day!!!', //name
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          187, 222, 251, 1)),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 170,
                                            ),
                                            _dailyQuote(randomQuote),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 275,
                                    child: Container(
                                      height: 400,
                                      width: 1000,
                                      color: const Color.fromRGBO(
                                          187, 222, 251, 1),
                                    )),
                                Positioned(
                                  top: 200,
                                  child: Container(
                                    height: 150.0,
                                    width: 300.0,
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MainScorePage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(213, 63, 151, 69),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(255, 35, 95, 38),
                                              spreadRadius: 5,
                                              blurRadius: 4,
                                              offset: const Offset(4, 8),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipPolygon(
                                                sides: 6,
                                                borderRadius: 10.0,
                                                rotate: 90.0,
                                                child: Container(
                                                  color: _polygonColor(provider.wellbeingscore),
                                                  child: Center(
                                                    child: Text(
                                                      "${provider.wellbeingscore}",
                                                      style: const TextStyle(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(0, 65, 68, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                "Wellbeing\n    Score\n       💯",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(0, 65, 68, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(
                              margin: EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Container(
                                        height: 350.0,
                                        width: 170.0,
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => StepPage(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            //steps
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 143, 111, 202),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.purple.shade800
                                                      .withOpacity(0.8),
                                                  spreadRadius: 5,
                                                  blurRadius: 4,
                                                  offset: const Offset(4, 8),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Steps 👣",
                                                    style: TextStyle(
                                                        fontSize: 35,
                                                        color: Color.fromRGBO(
                                                            66, 18, 95, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 50,
                                                  ),
                                                  CircularStepProgressIndicator(
                                                    totalSteps: 100,
                                                    currentStep:
                                                        (provider.dailysteps! /
                                                                100)
                                                            .round(),
                                                    stepSize: 20,
                                                    selectedColor:
                                                        const Color.fromARGB(
                                                            230, 247, 156, 37),
                                                    unselectedColor:
                                                        Colors.grey[200],
                                                    padding: 0,
                                                    width: 150,
                                                    height: 150,
                                                    selectedStepSize: 20,
                                                    roundedCap: (_, __) => true,
                                                    child: Center(
                                                      child: Text(
                                                        "${provider.dailysteps!}",
                                                        style: const TextStyle(
                                                          fontSize: 32,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              66, 18, 95, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Column(
                                        children: [
                                          Container(
                                            height: 145.0,
                                            width: 170.0,
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SleepPage(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                //sleep
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 64, 99, 180),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(255, 29, 45, 81),
                                                      spreadRadius: 5,
                                                      blurRadius: 4,
                                                      offset: const Offset(4, 8),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      const Text(
                                                        "Sleep 💤 ",
                                                        style: TextStyle(
                                                            fontSize: 35,
                                                            color: Color.fromARGB(
                                                                255, 92, 1, 33),
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        width: 80,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              187, 222, 251, 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "${provider.duration} h",
                                                          style: const TextStyle(
                                                              fontSize: 30,
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      92,
                                                                      1,
                                                                      33),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          Container(
                                            height: 170.0,
                                            width: 170.0,
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainTestPage(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.purple.shade300,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color.fromARGB(
                                                              255, 96, 39, 106)
                                                          .withOpacity(0.8),
                                                      spreadRadius: 5,
                                                      blurRadius: 4,
                                                      offset: const Offset(4, 8),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      const Text(
                                                        "Tests 📝",
                                                        style: TextStyle(
                                                            fontSize: 35,
                                                            color: Color.fromARGB(
                                                                255, 92, 1, 33),
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 25,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              203, 0, 64, 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          "PSQI",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 25,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              247, 157, 37, 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          "ESS",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 25,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              118, 195, 76, 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          "PHQ-9",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const SizedBox(
                                    height: 40,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ));
  }

  Widget _dailyQuote(String quote) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Ink(
          decoration: const ShapeDecoration(
            color: Color.fromRGBO(187, 222, 251, 0.721),
            shape: CircleBorder(),
          ),
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.blue.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    title: const Text(
                      'Daily quote',
                      style: const TextStyle(
                          color: Color.fromRGBO(13, 42, 106, 1),
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      '$quote',
                      style: const TextStyle(
                          color: Color.fromRGBO(13, 42, 106, 1),
                          fontStyle: FontStyle.italic),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(13, 42, 106, 1),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Go back"),
                      )
                    ],
                  );
                },
              );
            },
            icon: Image.asset(
              'images/others/lightbulb.png',
            ),
            iconSize: 10,
          ),
        ),
      ),
    );
  }

   _polygonColor(score) {
    Color color=Colors.black;
    if (score >= 0 && score <= 20) {
      color = Colors.red;
    } else if (score >= 21 && score <= 40) {
      color = Colors.deepOrange;
    } else if (score >= 41 && score <= 60) {
      color = Colors.orange;
    } else if (score >= 61 && score <= 80) {
      color =  Color.fromARGB(255, 106, 216, 109);
    } else {
      color = Color.fromARGB(255, 33, 199, 39);
    }
    return color;
  }


  final List<String> quotes = [
    "'Always remember that you are stronger than you think.'",
    "'Happiness is not something to find, but to create.'",
    "'Nobody queues for a flat roller coaster.'",
    "'Happiness can be found, even in the darkest of times, if one only remembers to turn on the light.'",
    "'Don't wait for opportunity, create it.'",
    "'Believe you can, and you're halfway there.'",
    "'Challenges are what make life interesting. Face them with courage.'",
    "'Work hard and dream big, the results will come.'",
    "'Every day is a chance to learn and grow.'",
    "'Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.'",
    "'The future belongs to those who believe in the beauty of their dreams.'",
    "'Obstacles are the stepping stones to success. Embrace them and keep moving forward.'",
    "'Don't watch the clock; do what it does. Keep going.'",
    "'You are never too old to set another goal or to dream a new dream.'",
    "'Don't be afraid to fail. Be afraid not to try.'",
  ];

  String getRandomQuote() {
    Random random = Random();
    int randomIndex = random.nextInt(quotes.length);
    return quotes[randomIndex];
  }
}
