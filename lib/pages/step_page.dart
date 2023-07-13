import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nix/database/database.dart';
import 'package:nix/providers/home_provider.dart';
import 'package:nix/services/impact.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:provider/provider.dart';

class StepPage extends StatefulWidget {
  const StepPage({Key? key}) : super(key: key);

  @override
  State<StepPage> createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {

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
                backgroundColor: Colors.deepPurple.shade200,
                appBar: AppBar(
                  title: const Text('Step data'),
                  backgroundColor: Colors.purple.shade800,
                  iconTheme: const IconThemeData(color: Colors.white),
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_circle_left_outlined)),
                ),
                body:  Provider.of<HomeProvider>(context).doneInit
                  ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade800,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.navigate_before, color: Colors.white, size: 24,),
                                onPressed: () {
                                DateTime day = Provider.of<HomeProvider>(context, listen: false).showDate;
                                Provider.of<HomeProvider>(context, listen: false).downloadSteps(day.subtract(const Duration(days: 1)));
                                }),
                                Consumer<HomeProvider>(
                                builder: (context, value, child) => Text(
                                    DateFormat('dd MMMM yyyy').format(value.showDate),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                            IconButton(
                                icon: const Icon(Icons.navigate_next, color: Colors.white, size: 24,),
                                onPressed: () {
                                  DateTime day = Provider.of<HomeProvider>(context, listen: false).showDate;
                                  Provider.of<HomeProvider>(context, listen: false).downloadSteps(day.add(const Duration(days: 1)));
                                })
                          ],
                        ),
                      ),
                     SizedBox(height: 40),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 320.0,
                          decoration: BoxDecoration(
                              color: Colors.purple.shade800,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Consumer<HomeProvider>(
                                    builder: (context, provider, child) => Text(
                                          '${provider.dailysteps == null ? 0 : provider.dailysteps!} out of 10000 👣',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                              ],
                            ),
                          ),
                        ),
                      ), 
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 100),
                              Consumer<HomeProvider>(
                                builder: (context, provider, child) => Text(
                                  'You have walked ${provider.dailysteps == null ? 0 : (provider.dailysteps! / 100).round()}% of your goal!',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                   Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Consumer<HomeProvider>(
                              builder: (context, provider, child) =>
                                  CircularStepProgressIndicator(
                                totalSteps: 100,
                                currentStep: (provider.dailysteps! / 100).round(),
                                stepSize: 20,
                                selectedColor: Color.fromARGB(230, 247, 156, 37),
                                unselectedColor: Colors.grey[200],
                                padding: 0,
                                width: 250,
                                height: 250,
                                selectedStepSize: 20,
                                roundedCap: (_, __) => true,
                                child: Center(
                                  child: Text(
                                    "${provider.dailysteps == null ? 0 : provider.dailysteps!}",
                                    style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 106, 27, 154),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 5),
                    ],
                  ),
                ) : const Center(
                      child: CircularProgressIndicator(),
                    ),     
              ),
        ));
  }
}