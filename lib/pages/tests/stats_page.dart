import 'package:flutter/material.dart';
import 'package:nix/pages/graphs/ESS_graph.dart';
import 'package:nix/pages/graphs/PHQ_graph.dart';
import 'package:nix/pages/graphs/PSQI_graph.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
 
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container( 
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color.fromARGB(203, 203, 0, 64),
                ),
                child: 
                Column(
                  children : const [
                  Text('PSQI',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  )),
                  BarChartPSQI(),
                  SizedBox(
                    height: 20,
                  ), 
                  RangePSQI()
                  ]
                ),
              ),

              const SizedBox(
                width: 20,
                ),
              
               Container( 
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color.fromARGB(187, 247, 156, 37),
                ),
                child: 
                Column(
                  children : const [
                  Text('ESS',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  )),
                  BarChartESS(),
                  SizedBox(
                    height: 20,
                  ),
                  RangeESS()
                  ]
                ),
              ),

              const SizedBox(
                width: 20,
              ),
              
               Container( 
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color.fromARGB(158, 118, 195, 76),
                ),
                child: 
                Column(
                  children : const [
                  Text('PHQ-9',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  )),
                  BarChartPHQ(),
                  SizedBox(
                    height: 20,
                  ),
                  RangePHQ()
                  ]
                ),
              )
            ]
          )
        )
    );
  } 
}


