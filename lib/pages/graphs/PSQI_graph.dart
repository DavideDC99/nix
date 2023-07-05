import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class BarChartPSQI extends StatefulWidget {
  const BarChartPSQI({super.key});

  @override
  State<StatefulWidget> createState() => BarChartPSQIState();
}

class BarChartPSQIState extends State<BarChartPSQI> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.6,
      child: _BarChartPSQI(),
    );
  }
}

class _BarChartPSQI extends StatelessWidget {
  const _BarChartPSQI();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData:  FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(  // MODIFICARE IMPORTANDO I DATI DAL DATABSE
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,  //colore score
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white, //colore mesi
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'June';
        break;    
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sept';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;      
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.white,   //gradiente
          Colors.blue,   //gradiente
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 8,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 14,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 15,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 13,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),

        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class RangePSQI extends StatelessWidget {
  const RangePSQI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 25,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(15)
                  ),
                  color: Colors.blue,
                ),
                child: const Center(child: Text('Normal \n0 - 1',
                 style: TextStyle( fontSize: 10, color: Colors.white),
                 textAlign:TextAlign.center)),

              ),
            ),
            Expanded(
              child: Container(
                height: 25,
                color: Colors.green,
                child: const Center(child: Text('Mild \n1 - 7', 
                style: TextStyle(fontSize: 10, color: Colors.white),
                textAlign:TextAlign.center)),
              ),
            ),
           
            Expanded(
              child: Container(
                height: 25,
                color: Colors.orange,
                child: const Center(child: Text('Moderate \n8 - 14', 
                style: TextStyle(fontSize:10, color: Colors.white),
                textAlign:TextAlign.center
                )),
              ),
            ),
            
            Expanded(
              child: Container(
                height: 25,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(15)
                  ),
                  color: Colors.red,
                ),
                child: const Center(child: Text('Severe \n15 - 21', 
                style: TextStyle(fontSize: 10, color: Colors.white),
                textAlign:TextAlign.center)),
              ),
            ),
          ],
        ),
    ]
    );
  }
}


ScorePlotPSQI() {
  double score=15; //output from database
  return AnimatedRadialGauge(
    duration: const Duration(seconds: 3),
    curve: Curves.elasticOut,        
    value: score,
    progressBar: const GaugeRoundedProgressBar(
      color: Color.fromARGB(255, 5, 26, 74),
    ),
    axis: const GaugeAxis(
      min: 0,
      max: 21,
      degrees: 240,
      style: GaugeAxisStyle(
        thickness: 20,
        background: Color.fromARGB(255, 197, 202, 233),
      ),),
      /*pointer: NeedlePointer(
        size: Size(16, 100),
        borderRadius: 16,
        backgroundColor: Color(0xFF193663),
      ),*/
    builder: (context, child, score) =>  RadialGaugeLabel(
        value: score,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
}

MessagePSQI() {
  double score=15;
  String severity='';
   if (score >= 1 && score <= 7) {
      severity = "mild sleep difficulty";
    } else if (score >= 8 && score <= 14) {
      severity = 'moderate sleep difficulty';
    } else if (score==0) {
      severity = 'no sleep difficulty';
    } else {
      severity = 'severe sleep difficulty';
    }
    
  return
  Text (
    "This score corresponds to $severity level",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.white),
    );
}
   