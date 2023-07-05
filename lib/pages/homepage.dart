import 'package:flutter/material.dart';
import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:fluttermoji/fluttermoji.dart';

int currentsteps = (6000 / 10000 * 100).round();
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

    return Scaffold(
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

      //changed
      drawer: Drawer(
          backgroundColor: Colors.blue.shade100,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/drawer_background.jpg'),
                          fit: BoxFit.cover)),
                  accountName: const Text('User name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  accountEmail: const Text('email'),
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
                      builder: (context) => const Profile(),
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
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.black),
                title: const Text('Sign out',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () {},
              ),
            ],
          )),

      //changed (home)
      body: SingleChildScrollView(
        child: Column(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 110),
                        Text(
                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(187, 222, 251, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Good day,...!', //name
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(187, 222, 251, 1)),
                            ),
                            //Text("🔥", style: TextStyle(fontSize: 30))
                            const SizedBox(width: 160),
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
                      color: const Color.fromRGBO(187, 222, 251, 1),
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
                            builder: (context) => MainScorePage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 69, 155, 75),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 15, 41, 17)
                                  .withOpacity(0.8),
                              spreadRadius: 5,
                              blurRadius: 4,
                              offset: const Offset(4, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipPolygon(
                                sides: 6,
                                borderRadius: 10.0,
                                rotate: 90.0,
                                boxShadows: [
                                  PolygonBoxShadow(
                                      color: Colors.black, elevation: 10.0),
                                ],
                                child: Container(
                                  color: const Color.fromARGB(255, 245, 190, 190),
                                  child: Center(
                                    child: Text(
                                      "$score",
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 15, 41, 17),
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
                                    color: Color.fromARGB(255, 15, 41, 17)),
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
            Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      height: 300.0,
                      width: 200.0,
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
                            color: const Color.fromARGB(255, 143, 111, 202),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.shade800.withOpacity(0.8),
                                spreadRadius: 5,
                                blurRadius: 4,
                                offset: const Offset(4, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Steps 👣",
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Color.fromRGBO(66, 18, 95, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CircularStepProgressIndicator(
                                  totalSteps: 100,
                                  currentStep: currentsteps,
                                  stepSize: 20,
                                  selectedColor:
                                      const Color.fromARGB(230, 247, 156, 37),
                                  unselectedColor: Colors.grey[200],
                                  padding: 0,
                                  width: 175,
                                  height: 175,
                                  selectedStepSize: 20,
                                  roundedCap: (_, __) => true,
                                  child: Center(
                                    child: Text(
                                      "${currentsteps * 100}",
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(66, 18, 95, 1),
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
                    const Spacer(),
                    Column(
                      children: [
                        Container(
                          height: 120.0,
                          width: 170.0,
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SleepPage(),
                                ),
                              );
                            },
                            child: Container(
                              //sleep
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 64, 99, 180),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 92, 1, 33)
                                        .withOpacity(0.8),
                                    spreadRadius: 5,
                                    blurRadius: 4,
                                    offset: const Offset(4, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Sleep 💤 ",
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Color.fromARGB(255, 92, 1, 33),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 80,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(187, 222, 251, 1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Text(
                                        "$hoursSleep h",
                                        style: const TextStyle(
                                            fontSize: 30,
                                            color:
                                                Color.fromARGB(255, 92, 1, 33),
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
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
                          height: 140.0,
                          width: 170.0,
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SleepPage(), //da cambiare
                                ),
                              );
                            },
                            child: Container(
                              //sleep
                              decoration: BoxDecoration(
                                color: Colors.purple.shade300,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 96, 39, 106)
                                        .withOpacity(0.8),
                                    spreadRadius: 5,
                                    blurRadius: 4,
                                    offset: const Offset(4, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Tests 📝",
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Color.fromARGB(255, 92, 1, 33),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 60,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(203, 0, 64, 1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: const Text(
                                        "PSQI",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 60,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(247, 157, 37, 1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: const Text(
                                        "ESS",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 60,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(118, 195, 76, 1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: const Text(
                                        "PHQ-9",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*
                          child: FittedBox(
                              child: FloatingActionButton(
                                  child: const Text(
                                    'Daily Quote',
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    
                                    final materialBanner = MaterialBanner(
                                      elevation: 100,
                                      backgroundColor: Colors.transparent,
                                      forceActionsBelow: false,
                                      content: AwesomeSnackbarContent(
                                        title: 'Hey!!',
                                        message: randomQuote,
                                        //message: quotes[9], //use this to test the length of the quote
                                        messageFontSize: 14,
                                        contentType: ContentType.success,
                                        inMaterialBanner: true,
                                        color: Colors.blue,
                                      ),
                                      actions: const [SizedBox.shrink()],
                                    );

                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentMaterialBanner()
                                      ..showMaterialBanner(materialBanner);
                                  }) 
                              /*
                                  final snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    //forceActionsBelow: true,
                                    content: AwesomeSnackbarContent(
                                      title: 'Hey!!',
                                      message: randomQuote,
                                      //message: quotes[9], //use this to test the length of the quote
                                      messageFontSize: 14,
                                      contentType: ContentType.success,
                                      inMaterialBanner: true,
                                      color: Colors.blue,
                                    ),
                                    action: SnackBarAction(label: 'X', onPressed: SizedBox.shrink),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                }),
                                */
                              ), */
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 125.0,
                  width: 380.0,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProgressPage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade700,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 4, 104, 113)
                                .withOpacity(0.8),
                            spreadRadius: 5,
                            blurRadius: 4,
                            offset: const Offset(4, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Monthly Progress 🥇",
                              style: TextStyle(
                                fontSize: 30,
                                color: Color.fromRGBO(2, 65, 68, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50.0,
                              width: 100.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '🏆 $goalsAchieved ',
                                    style: const TextStyle(
                                        fontSize: 30,
                                        color: Color.fromRGBO(2, 65, 68, 1),
                                        fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dailyQuote(String quote) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.blue.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              title: const Text(
                'Daily quote:',
                style: TextStyle(
                    color: Color.fromRGBO(13, 42, 106, 1),
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                quote,
                style: const TextStyle(
                    color: Color.fromRGBO(13, 42, 106, 1),
                    fontStyle: FontStyle.italic),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(13, 42, 106, 1),
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
      icon: const Icon(Icons.lightbulb_outlined),
      iconSize: 30,
      color: const Color.fromARGB(230, 247, 156, 37),
      hoverColor: const Color.fromARGB(230, 208, 131, 31),
    );
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
