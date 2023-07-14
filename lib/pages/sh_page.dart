import 'package:flutter/material.dart';

class SHpage extends StatelessWidget {
  const SHpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFF141925),
          appBar: AppBar(
            title: const Text('Sleep hygiene'),
            backgroundColor: Color.fromRGBO(247, 157, 37, 1),
            iconTheme: const IconThemeData(color: Colors.white),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_circle_left_outlined)),
          ),
          body: const Center(
            child: SHScreen(),
          ),
        ));
  }
}

class SHScreen extends StatefulWidget {
  const SHScreen({super.key});

  @override
  State<SHScreen> createState() => _SHScreenState();
}

class _SHScreenState extends State<SHScreen> {
  int _index = 0;
  final List<bool> _stepActive = List.generate(10, (index) => false);

  final ThemeData _stepperTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color.fromRGBO(247, 157, 37, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _stepperTheme,
      child: Stepper(
        currentStep: _index,

        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
              _stepActive[_index] = false;
            });
          }
        },
        onStepContinue: () {
          if (_index < 9) {
            setState(() {
              _stepActive[_index] = true;
              _index += 1;
            });
          } else if (_index == 9) {
            setState(() {
              _stepActive[_index] = true;
            });
          }
          if (_stepActive.every((element) => element == true)) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  title: const Text(
                    'All step checked',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  content: const Text(
                    'You have completed all the steps of the process!!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(247, 157, 37, 1),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Go back'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },

        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: details.onStepContinue,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(247, 157, 37, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    child: const Text('NEXT',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: details.onStepCancel,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(247, 183, 99, 0.892)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    child: const Text('CANCEL',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ],
              ),
            ],
          );
        },

        steps: <Step>[
          Step(
            title: const Text(
              'Set a consistent sleep schedule',
              style: TextStyle(
                color: Color.fromRGBO(198, 40, 40, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[0],
            state: _stepActive[0] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 200, 
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(198, 40, 40, 1),
                ),
                child: Column(children: const [
                  Text(
                    "Your body thrives on routine. Going to bed and waking up at roughly the same time every day, including weekends, creates a sleep framework. This will heighten your sleep drive, so you'll sleep better the next night.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,
                    ),
                  ),
                ])),
          ),

          Step(
            title: const Text(
              'Create a relaxing pre-bedtime routine',
              style: TextStyle(
                color: Color.fromRGBO(173, 20, 87, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[1],
            state: _stepActive[1] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 200, 
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(173, 20, 87, 1),
                ), 
                child: Column(children: const [
                  Text(
                    "Adopting a soothing activity—for example reading a book, listening to calming music or taking a hot shower or bath for as little as 10 minutes—about an hour before bed helps your body transition from wakefulness to rest.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,
                    ),
                  ),
                ])),
          ),

          Step(
            title: const Text(
              'Keep your bedroom cool',
              style: TextStyle(
                color: Color.fromRGBO(106, 27, 154, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[2],
            state: _stepActive[2] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 200, 
                width: MediaQuery.of(context).size.width * 0.8, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(106, 27, 154, 1),
                ), 
                child: Column(children: const [
                  Text(
                    "The ideal setting for sleep is cool, quiet, and dark. A bedroom temperature of between 60 and 67 degrees F can be conducive to healthy, restful sleep.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,
                    ),
                  ),
                ])),
          ),

          Step(
            title: const Text(
              'Get early morning sunlight',
              style: TextStyle(
                color: Color.fromRGBO(69, 39, 160, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold, 
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[3],
            state: _stepActive[3] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 200, 
                width: MediaQuery.of(context).size.width * 0.8, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(69, 39, 160, 1),
                ), 
                child: Column(children: const [
                  Text(
                    "An important thing for setting your biological clock is to get at least a few minutes of sunlight in your eyes within 30-60 minutes of waking up, without sunglasses and not through a tinted window.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,
                    ),
                  ),
                ])),
          ),

          Step(
            title: const Text(
              'Dim the lights after dark',
              style: TextStyle(
                color: Color.fromRGBO(40, 53, 147, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold, 
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[4],
            state: _stepActive[4] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 220, 
                width: MediaQuery.of(context).size.width *  0.8, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(40, 53, 147, 1),
                ), 
                child: Column(children: const [
                  Text(
                    "Exposing yourself to too much bright light from streetlights, lamps, and electronic devices has been linked to circadian-rhythm sleep-wake disorders. In fact,  bright light at night can disrupt your natural rhythms by tricking your brain into thinking it's still daytime.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,
                    ),
                  ),
                ])),
          ),

          Step(
            title: const Text(
              'Unplug an hour before bed',
              style: TextStyle(
                color: Color.fromRGBO(21, 101, 192, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[5],
            state: _stepActive[5] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 200, 
                width: MediaQuery.of(context).size.width * 0.8, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(21, 101, 192, 1),
                ), 
                child: Column(children: const [
                  Text(
                    "Blue light from your computer and smartphone can interfere with the release of melatonin, which cues your body that it's time to wind down. Put “Power off electronics at least an hour before bed” in a prime spot on your sleep hygiene checklist. ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,

                    ),
                  ),
                ])),
          ),

          Step(
            title: const Text(
              'Cut out afternoon caffeine',
              style: TextStyle(
                color: Color.fromRGBO(2, 119, 189, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold, 
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[6],
            state: _stepActive[6] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 200, 
                width: MediaQuery.of(context).size.width *  0.8, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(2, 119, 189, 1),
                ),
                child: Column(children: const [
                  Text(
                    "Caffeine is a stimulant with a half-life of 4 to 6 hours. If you're a fitful sleeper, avoid beverages like coffee, tea, or colas at least 6 hours before bedtime.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,
                    ),
                  ),
                ])),
          ),

          Step(
            title: const Text(
              "Don't eat meals late at night",
              style: TextStyle(
                color: Color.fromRGBO(0, 131, 143, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold, 
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[7],
            state: _stepActive[7] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 200, 
                width: MediaQuery.of(context).size.width * 0.8, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(0, 131, 143, 1),
                ), 
                child: Column(children: const [
                  Text(
                    "Many experts say it's better not to go to bed hungry or stuffed. When you eat a heavy meal within hours of bedtime, your discomfort may keep you awake. It's not conducive to sleep, especially if you're prone to heartburn.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,
                    ),
                  ),
                ])),
          ),

          Step(
            title: const Text(
              'Eliminate the nightcaps',
              style: TextStyle(
                color: Color.fromRGBO(0, 105, 92, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[8],
            state: _stepActive[8] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 200, 
                width: MediaQuery.of(context).size.width * 0.8, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(0, 105, 92, 1),
                ), 
                child: Column(children: const [
                  Text(
                    "Even a single glass of wine close to bedtime may impact your sleep. You'll have a lighter, more fitful sleep, which may cause you to wake feeling fatigued.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,
                    ),
                  ),
                ])),
          ),

          Step(
            title: const Text(
              'Use your bed for only sleep and sex',
              style: TextStyle(
                color: Color.fromRGBO(46, 125, 50, 1),
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            isActive: _stepActive[9],
            state: _stepActive[9] ? StepState.complete : StepState.indexed,
            content: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                height: 220, 
                width: MediaQuery.of(context).size.width * 0.8, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(46, 125, 50, 1),
                ), 
                child: Column(children: const [
                  Text(
                    "If you struggle with sleep issues experts say to use your bedroom only for sleep and sex. That means no TV, no internet browsing, no answering emails. This trains your mind to see your bed only as a place rest, conductive to sleep.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.2,
                    ),
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
