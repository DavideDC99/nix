import 'package:flutter/material.dart';

class ScoreDescription extends StatefulWidget {
  @override
  _ScoreDescriptionState createState() => _ScoreDescriptionState();
}

class _ScoreDescriptionState extends State<ScoreDescription> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
             Align(
              alignment: Alignment.bottomCenter,
              child:
                Container(
                  margin: EdgeInsets.all(16),
                  width: 500.0,
                  height: 575.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 151, 63, 116),
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 16,),
                      Text('How is the monthly score calculated?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(10.0)),
                      Text('Our wellbeing score is determined by six factors: daily step count, sleep duration, sleep quality and the three tests. These factors are added together to obtain the final score, which ranges from 0 to 100.',      
                      style: const TextStyle(
                          color:  Color.fromARGB(255, 89, 214, 97),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('- Daily Step Count: Up to 30 points are awarded if the person achieves at least 10,000 steps. Otherwise, points are proportionally distributed based on the actual step count.',
                      style: const TextStyle(
                          color:  Color.fromARGB(255, 89, 214, 97),
                          fontSize: 16,
                        ),
                      ),
                       SizedBox(height: 5,),
                       Text('- Sleep Duration: Up to 20 points are given if the person sleeps for at least 8 hours. Points are proportionally adjusted for shorter sleep durations.',
                      style: const TextStyle(
                          color:  Color.fromARGB(255, 89, 214, 97),
                          fontSize: 16,
                        ),
                      ),
                       SizedBox(height: 5,),
                       Text('- Sleep Quality: Scores range from 0 to 100, and up to 20 points are assigned proportionally based on the sleep quality score.',
                      style: const TextStyle(
                          color:  Color.fromARGB(255, 89, 214, 97),
                          fontSize: 16,
                        ),
                      ),
                       SizedBox(height: 5,),
                      Text('- The remaining 30 points are allocated through the completion of three tests. Each test has a total of 10 points, which are inversely proportional to the score obtained. By default, if a test has not been taken, the individual receives 3 points for that particular test as a normalization parameter',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 89, 214, 97),
                          fontSize: 16,
                        ),
                      ),
                    ], 
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