import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:nix/pages/graphs/score_graph.dart';

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

class ScoreResults extends StatefulWidget {
  @override
  _ScoreResultsState createState() => _ScoreResultsState();
}

class _ScoreResultsState extends State<ScoreResults> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CupertinoMonthPicker(),
            /*
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child:
                Container(
                  width: 320.0,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.shade700,
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Discover your score!',
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
            */
            SizedBox(height: 20),
            _ScoreWidget(75),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16.0),
                //height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 151, 63, 116),
                ),
                child: Column(children: const [
                  Text('Your monthly statistics',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  BarChartScore(),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

//mio widget
  Widget _ScoreWidget(int score) {
    return Container(
      width: 370.0,
      height: 230.0,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 35, 95, 38), 
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Column(
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
            SizedBox(height: 15),
            Container(
              width: 150,
              height: 150,
              child: CircularStepProgressIndicator(
                totalSteps: 100,
                currentStep: score,
                stepSize: 20,
                selectedColor: Color.fromARGB(255, 151, 63, 116),
                unselectedColor: Color.fromARGB(255, 245, 190, 190),
                padding: 0,
                width: 120,
                height: 120,
                selectedStepSize: 20,
                roundedCap: (_, __) => true,
                child: Center(
                  child: Text(
                    "${score}",
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
        const Text('Selected month: ', style: TextStyle(color: Colors.white)),
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
              children: List<Widget>.generate(_monthNames.length, (int index) {
                return Center(child: Text(_monthNames[index]));
              }),
            ),
          ),
          child: Text(
            _monthNames[_selectedMonth],
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
