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
                  height: 600.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 151, 63, 116),
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('How is the monthly score calculated?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(10.0)),
                      Text('Our score is between 0 and 100 and is assigned monthly based on your test results and lifestyle. The higher the score, the more at-risk your situation is: if it is very close to 100 we recommend that you adopt significant changes in your lifestyle. Remember that you can also find interesting insights in the tips and checklist sections of our app! In the case of a very high score, we also suggest you talk to a specialist.\nBelow is the procedure used to calculate the score:\n',
                      style: const TextStyle(
                          color: Colors.white,
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