import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nix/pages/graphs/sleep_graph.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:nix/database/database.dart';
import 'package:nix/providers/home_provider.dart';
import 'package:nix/services/impact.dart';
import 'package:gauge_indicator/gauge_indicator.dart';


class SleepPage extends StatefulWidget {
  SleepPage({Key? key}) : super(key: key);


  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
        create: (context) => HomeProvider(
              Provider.of<ImpactService>(context, listen: false),
              Provider.of<AppDatabase>(context, listen: false),
            ),
        lazy: false,
        builder: (context, child) => MaterialApp(
              home: Scaffold(
                backgroundColor: Color.fromARGB(255, 64, 99, 180),
                appBar: AppBar(
                  title: const Text('Sleep data'),
                  backgroundColor: Color.fromARGB(255, 24, 38, 69),
                  elevation: 20,
                  iconTheme: const IconThemeData(color: Colors.white),
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                                color: Color.fromARGB(255, 24, 38, 69),
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
                                        DateTime day =
                                            Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                .showDate;
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .downloadSleep(day.subtract(
                                                const Duration(days: 1)));
                                      }),
                                  Consumer<HomeProvider>(
                                      builder: (context, value, child) => Text(
                                            DateFormat('dd MMMM yyyy')
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
                                        DateTime day =
                                            Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                .showDate;
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .downloadSleep(day
                                                .add(const Duration(days: 1)));
                                      })
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(alignment: Alignment.center, margin: EdgeInsets.all(8),
                            padding:EdgeInsets.all(8),
                            width: 300,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 24, 38, 69),
                                borderRadius: BorderRadius.circular(25.0),
                                
                              ),
                              child: Text('Sleep efficiency', style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                            ))),
                            SizedBox(height: 15),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Consumer<HomeProvider>(
                                builder: (context, provider, child) =>
                                    CircularStepProgressIndicator(
                                  totalSteps: 100,
                                  currentStep: provider.eff!,
                                  stepSize: 20,
                                  selectedColor:
                                      Color.fromARGB(255, 123, 0, 44),
                                  unselectedColor:
                                      Color.fromARGB(255, 194, 221, 225),
                                  padding: 0,
                                  width: 200,
                                  height: 200,
                                  selectedStepSize: 20,
                                  roundedCap: (_, __) => true,
                                  child: Center(
                                    child: Text(
                                      "${provider.eff!}",
                                      style: const TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                       Container(alignment: Alignment.center,
                            padding:EdgeInsets.all(8),
                            width: 200,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 24, 38, 69),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Text('Sleep duration', style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                            ))),
                            SizedBox(height: 10,),
                                      Container(
                                          child: Consumer<HomeProvider>(
                                        builder: (context, provider, child) =>
                                           CircularStepProgressIndicator(
                                      totalSteps: 8,
                                      currentStep: provider.duration!.toInt(),
                                      stepSize: 20,
                                      selectedColor:
                                          Color.fromARGB(230, 247, 156, 37),
                                      unselectedColor:
                                          Color.fromARGB(255, 194, 221, 225),
                                      padding: 0,
                                      width: 150,
                                      height: 150,
                                      selectedStepSize: 20,
                                      roundedCap: (_, __) => true,
                                      child: Center(
                                        child: Text(
                                          "${provider.duration}h",
                                          style: const TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                ),
                                      )),
                                    ],
                                  ),
                                  //secondo elemento della riga
                                  SizedBox(width: 10,),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 24, 38, 69),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Consumer<HomeProvider>(
                                    builder: (context, provider, child) =>
                                     Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Bed time',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '${provider.startSleep!}', ///da sistemare
                                            style: TextStyle(
                                              color: Color(0xFF3CDAF7),
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 25),
                                          Text(
                                            'WakeUp time',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '${provider.endSleep}',
                                            style: TextStyle(
                                              color: Color(0xFF3CDAF7),
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    )
                                  )
                                ],
                              ),
                            )
                          ]))
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ));
  }
}

