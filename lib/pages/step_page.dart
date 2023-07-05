import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:nix/pages/graphs/step_graph.dart';


class StepPage extends StatefulWidget {
  const StepPage({Key? key}) : super(key: key);

  @override
  State<StepPage> createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  int currentsteps = (6000 / 10000 * 100).round();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple.shade200,
        appBar: AppBar(
          title: const Text('Step data'),
          backgroundColor: Colors.purple.shade800,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(onPressed:() {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined)),
        ),
        body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.navigate_before),
                    onPressed: () {
                      /*
                      // here we use the access method to retrieve the Provider and use its values and methods
                      final provider =
                          Provider.of<HomeProvider>(context, listen: false);
                      DateTime day = provider.showDate;
                      provider
                          .getDataOfDay(day.subtract(const Duration(days: 1))); */
                    }),
                /*Consumer<HomeProvider>(
                    builder: (context, value, child) => */
                    //Text(DateFormat('dd MMMM yyyy').format(value.showDate))),
                    Text('dd MMMM yyyy'),
                IconButton(
                    icon: const Icon(Icons.navigate_next),
                    onPressed: () {})/*
                      final provider =
                          Provider.of<HomeProvider>(context, listen: false);
                      DateTime day = provider.showDate;
                      provider.getDataOfDay(day.add(const Duration(days: 1)));
                    })*/
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child:
                Container(
                  width: 320.0,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade800,
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${currentsteps * 100} out of 10000 👣',
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
            SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomCenter,
              child:
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 100),
                      Text('You have walked ${currentsteps} % of your goal!',
                        style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CircularStepProgressIndicator(
                    totalSteps: 100,
                    currentStep: currentsteps,
                    stepSize: 20,
                    selectedColor: Color.fromARGB(230, 247, 156, 37),
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 180,
                    height: 180,
                    selectedStepSize: 20,
                    roundedCap: (_, __) => true,
                    child: Center(
                      child: Text(
                        "${currentsteps * 100}",
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 106, 27, 154),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container( 
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16.0),
                //height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Color.fromARGB(230, 247, 156, 37),
                ),
                child: 
                Column(
                  children : const [
                  Text('Your average monthly statistics',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
                  BarChartSleep(),
                  SizedBox(
                    height: 20,
                  ), 
                  ]
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
  } }//MyApp