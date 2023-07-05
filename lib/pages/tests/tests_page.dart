import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nix/pages/graphs/ESS_graph.dart';
import 'package:nix/pages/graphs/PHQ_graph.dart';
import 'package:nix/pages/graphs/PSQI_graph.dart';
import 'package:nix/pages/tests/ESS/ESS_test.dart';
import 'package:nix/pages/tests/PHQ/PHQ_test.dart';
import 'package:nix/pages/tests/PSQI/PSQI_test.dart';

const double _kItemExtent = 32.0;  
const List<String> _monthNames = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'Dicember'
];


class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        child: SingleChildScrollView(
          child: Column(
            children: [ 
              const CupertinoMonthPicker(),

              Container( // Container 1
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color.fromARGB(203, 203, 0, 64),
                ),
                child: Padding(
                  padding:const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      const Text('The Pittsburgh Sleep Quality Index (PSQI) is a self-report questionnaire that assesses sleep quality over a 1-month time interval.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      )
                      ),
                        const SizedBox(
                            height: 10,
                          ), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         SizedBox( //Button container
                            width: 100,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 203, 0, 64), shape: const StadiumBorder(),
                              ),
                              onPressed:() {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const PSQITest())); 
                              },
                              child: const Text( "Do the test"),
                              ),
                          ), 
                          const SizedBox(
                            width: 20,
                          ), 
                          Container( //results
                              width: 175,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(213, 203, 0, 64),
                              ),
                              child: 
                                 ScorePlotPSQI(),
                              ) 
                        ], ),
                        const SizedBox(
                            height: 30,
                          ), 
                        MessagePSQI()
                         ],),)
                ), 
              
              Container( // container 2
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color.fromARGB(187, 247, 156, 37),
                ),
                child: Padding(
                  padding:const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      const Text('The Epworth Sleepiness Scale (ESS) is a scale intended to measure daytime sleepiness.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      )),
                      const SizedBox(
                            height: 10,
                          ), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox( //Button container
                            width: 100,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 247, 157, 37), shape: const StadiumBorder(),
                              ),
                              onPressed:() { 
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => const ESSTest())); 

                              },
                              child: const Text( "do the test"),
                              ),
                          ), 
                          const SizedBox(
                            width: 20,
                          ), 
                          Container( 
                              width: 175,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 247, 157, 37),
                              ) ,
                              child: 
                                 ScorePlotESS(),
                              ) 
                        ], ),
                        const SizedBox(
                            height: 30,
                          ), 
                        MessageESS()
                         ],),)
                ), 
              
              Container( // container 3
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color:  const Color.fromARGB(158, 118, 195, 76),
                ),
                child: Padding(
                  padding:const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      const Text('The 9-question Patient Health Questionnaire (PHQ-9) is a diagnostic tool to screen adult for the presence and severity of depression.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      )),
                      const SizedBox(
                            height: 10,
                          ), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox( 
                            width: 100,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(252, 118, 195, 76), shape: const StadiumBorder(),
                              ),
                              onPressed:() {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => const PHQTest())); //mandare a fare il test
                              },
                              child: const Text( "do the test"),
                              ),
                          ), 
                          const SizedBox(
                            width: 20,
                          ), 
                          Container( 
                              width: 175,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(158, 118, 195, 76),
                              ),
                              child: 
                                 ScorePlotPHQ(),
                              ) 
                        ], ),
                        const SizedBox(
                            height: 30,
                          ), 
                        MessagePHQ()
                        ],),)
                ) 
          ]),
        ),
      ); 
  }
}

class CupertinoMonthPicker extends StatefulWidget {
  const CupertinoMonthPicker({super.key});

  @override
  State<CupertinoMonthPicker> createState() => _CupertinoMonthPickerState();
}

class _CupertinoMonthPickerState extends State<CupertinoMonthPicker> {
  int _selectedMonth = 0;
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Selected month: '),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showDialog(
            CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              itemExtent: _kItemExtent,
              scrollController: FixedExtentScrollController(
                initialItem: _selectedMonth,
              ),
              onSelectedItemChanged: (int selectedItem) {
                setState(() {
                  _selectedMonth = selectedItem;
                });
              },
              children:
                  List<Widget>.generate(_monthNames.length, (int index) {
                return Center(child: Text(_monthNames[index]));
              }),
            ),
          ),
          child: Text(
            _monthNames[_selectedMonth],
            style: const TextStyle(
              fontSize: 18.0,
              color: Color.fromARGB(255, 5, 26, 74),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

