import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:nix/pages/graphs/sleep_graph.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';


class SleepPage extends StatefulWidget {
  SleepPage({Key? key}) : super(key: key);

  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  ClockTimeFormat _clockTimeFormat = ClockTimeFormat.twentyFourHours;
  ClockIncrementTimeFormat _clockIncrementTimeFormat =
      ClockIncrementTimeFormat.fiveMin;

  PickedTime _inBedTime = PickedTime(h: 0, m: 0);
  PickedTime _outBedTime = PickedTime(h: 8, m: 0);
  PickedTime _intervalBedTime = PickedTime(h: 0, m: 0);

  double _sleepGoal = 8.0;
  bool _isSleepGoal = false;

  bool? validRange = true;
  DateTime day = DateTime.now();
 

  @override
  void initState() {
    super.initState();
    _isSleepGoal = (_sleepGoal >= 8.0) ? true : false;
    _intervalBedTime = formatIntervalTime(
      init: _inBedTime,
      end: _outBedTime,
      clockTimeFormat: _clockTimeFormat,
      clockIncrementTimeFormat: _clockIncrementTimeFormat,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 64, 99, 180),
      appBar: AppBar(
        title: const Text('Sleep data'),
        backgroundColor: Color.fromARGB(255, 24, 38, 69),
        elevation:20,
        iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(onPressed:() {
           Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined)),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        width: double.infinity,
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20),
            Container(  //data
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
                      icon: const Icon(Icons.navigate_before),
                      onPressed: () { 
                        day = day.subtract(const Duration(days: 1));
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
                      Text('dd MMMM yyyy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),),
                  IconButton(
                      icon: const Icon(Icons.navigate_next),
                      onPressed: () {day = day.add(const Duration(days: 1));})/*
                        final provider =
                            Provider.of<HomeProvider>(context, listen: false);
                        DateTime day = provider.showDate;
                        provider.getDataOfDay(day.add(const Duration(days: 1)));
                      })*/
                ],
              ),
            ),
            // obiettivo raggiunto
            SizedBox(height: 20),

           
            // fine domanda
      
            Container( //parte centrale 
              width: MediaQuery.of(context).size.width,
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                  Column(
                    children: [
                      Container(  //goal
                        width: MediaQuery.of(context).size.width * 0.6,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 24, 38, 69),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _isSleepGoal
                                ? "Daily goal achieved!"
                                : 'Daily goal not achieved!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TimePicker( //orologio
                        initTime: _inBedTime,
                        endTime: _outBedTime,
                        height: MediaQuery.of(context).size.width * 0.6,
                        width: MediaQuery.of(context).size.width * 0.6,
                        onSelectionChange: _updateLabels,
                        onSelectionEnd: (start, end, isDisableRange) => print(
                            'onSelectionEnd => init : ${start.h}:${start.m}, end : ${end.h}:${end.m}, isDisableRange: $isDisableRange'),
                        primarySectors: _clockTimeFormat.value,
                        secondarySectors: _clockTimeFormat.value * 2,
                        decoration: TimePickerDecoration(
                          baseColor: Color.fromARGB(255, 24, 38, 69),
                          pickerBaseCirclePadding: 15.0,
                          sweepDecoration: TimePickerSweepDecoration(
                            pickerStrokeWidth: 30.0,
                            pickerColor: _isSleepGoal ? Color(0xFF3CDAF7) : Colors.white,
                            showConnector: true,
                          ),
                          initHandlerDecoration: TimePickerHandlerDecoration(
                            color: Color.fromARGB(255, 24, 38, 69),
                            shape: BoxShape.circle,
                            radius: 12.0,
                            icon: Icon(
                              Icons.power_settings_new_outlined,
                              size: 20.0,
                              color: Color(0xFF3CDAF7),
                            ),
                          ),
                          endHandlerDecoration: TimePickerHandlerDecoration(
                            color: Color.fromARGB(255, 24, 38, 69),
                            shape: BoxShape.circle,
                            radius: 12.0,
                            icon: Icon(
                              Icons.notifications_active_outlined,
                              size: 20.0,
                              color: Color(0xFF3CDAF7),
                            ),
                          ),
                          primarySectorsDecoration: TimePickerSectorDecoration(
                            color: Colors.white,
                            width: 1.0,
                            size: 4.0,
                            radiusPadding: 25.0,
                          ),
                          secondarySectorsDecoration: TimePickerSectorDecoration(
                            color: Color(0xFF3CDAF7),
                            width: 1.0,
                            size: 2.0,
                            radiusPadding: 25.0,
                          ),
                          clockNumberDecoration: TimePickerClockNumberDecoration(
                            defaultTextColor: Colors.white,
                            defaultFontSize: 8.0,
                            scaleFactor: 2.0,
                            showNumberIndicators: true,
                            clockTimeFormat: _clockTimeFormat,
                            clockIncrementTimeFormat: _clockIncrementTimeFormat,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(62.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${intl.NumberFormat('00').format(_intervalBedTime.h)}Hr ${intl.NumberFormat('00').format(_intervalBedTime.m)}Min',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: _isSleepGoal ? Color(0xFF3CDAF7) : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),               
                
              //SizedBox(width: 10),
                          
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //SizedBox(height: 15),
                    _sleepTimeWidget(_inBedTime,_outBedTime),
                    SizedBox(height: 10),
                    _EfficiencyWidget(75)
                  ],
                ),
              ),   
              
            
                ],
              ),
            ),
            // fine row

            SizedBox(height: 10),
            //grafico
            Container( 
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  //color: Colors.amber.shade900,
                  color: Color.fromARGB(255,123,0,44),
                ),
                child: 
                Column(
                  children : const [
                  Text('Your average monthly statistics',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  )),
                  BarChartSleep(),
                  SizedBox(
                    height: 20,
                  ), 
                  
                  ]
                ),
              ),



            
            
            
          ],
        ),

        )
      ),
    );
  }
  
//widget standard
  Widget _timeWidget(String title, PickedTime time, Icon icon) {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 24, 38, 69),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              '${intl.NumberFormat('00').format(time.h)}:${intl.NumberFormat('00').format(time.m)}',
              style: TextStyle(
                color: Color(0xFF3CDAF7),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              '$title',
              style: TextStyle(
                color: Color(0xFF3CDAF7),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            icon,
          ],
        ),
      ),
    );
  }

//mio widget
  Widget _sleepTimeWidget(PickedTime time1,PickedTime time2) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 24, 38, 69),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Text(
              'Bed time',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${intl.NumberFormat('00').format(time1.h)}:${intl.NumberFormat('00').format(time1.m)}',
              style: TextStyle(
                color: Color(0xFF3CDAF7),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'WakeUp time',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${intl.NumberFormat('00').format(time2.h)}:${intl.NumberFormat('00').format(time2.m)}',
              style: TextStyle(
                color: Color(0xFF3CDAF7),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            
          ],
        ),
      ),
    );
  }


  //mio widget
  Widget _EfficiencyWidget(int score) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 24, 38, 69),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Text(
              'Sleep Efficiency',
              textAlign: TextAlign.center ,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Container( 
              //width: MediaQuery.of(context).size.width * 0.25,
              //height: 120,
              /*decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(213, 203, 0, 64),
              ),*/
              /*child:AnimatedRadialGauge(
                duration: const Duration(seconds: 3),
                curve: Curves.elasticOut,        
                value: score,
                progressBar: const GaugeRoundedProgressBar(
                  color: Colors.teal,
                ),
                axis: const GaugeAxis(
                  min: 0,
                  max:100 ,
                  degrees: 350,
                  style: GaugeAxisStyle(
                    thickness: 20,
                    background: Colors.white,
                  ),),
                builder: (context, child, score) =>  RadialGaugeLabel(
                    value: score,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) */
              child: CircularStepProgressIndicator(
                totalSteps: 100,
                currentStep: score,
                stepSize: 20,
                selectedColor: Color.fromARGB(255,123,0,44),
                unselectedColor: Color.fromARGB(255, 194, 221, 225),
                padding: 0,
                width: 100,
                height: 100,
                selectedStepSize: 20,
                roundedCap: (_, __) => true,
                child: Center(
                  child: Text(
                    "${score}",
                    style: const TextStyle(
                      fontSize: 22,
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

  void _updateLabels(PickedTime init, PickedTime end, bool? isDisableRange) {
    _inBedTime = init;
    _outBedTime = end;
    _intervalBedTime = formatIntervalTime(
      init: _inBedTime,
      end: _outBedTime,
      clockTimeFormat: _clockTimeFormat,
      clockIncrementTimeFormat: _clockIncrementTimeFormat,
    );
    _isSleepGoal = validateSleepGoal(
      inTime: init,
      outTime: end,
      sleepGoal: _sleepGoal,
      clockTimeFormat: _clockTimeFormat,
      clockIncrementTimeFormat: _clockIncrementTimeFormat,
    );
    setState(() {
      validRange = isDisableRange;
    });
  }
}
