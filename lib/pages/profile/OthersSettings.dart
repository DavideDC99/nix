import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'dart:math';


class OthersSettings extends StatefulWidget {
  @override
  _OthersSettingsState createState() => _OthersSettingsState();
}

class _OthersSettingsState extends State<OthersSettings> {

final _formKey = GlobalKey<FormState>();
final _listSmokeText = ["Yes", "No"];
final _listSportText = ['Very much', 'A lot', 'Quite a lot', 'A little', 'Very little'];
var _tabTextIndexSmokeSelected = 1;
var _tabTextIndexSportSelected = 1;
final TextEditingController _heightController = TextEditingController();
final TextEditingController _weightController = TextEditingController();

double? bmi;
String errorText = '';
String status = '';

void calculateBMI() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    if (height == null || weight == null) {
      setState(() {
        errorText = "Please enter your Height and Weight";
      });
      return;
    }

    if (height <= 0 || weight <= 0) {
      setState(() {
        errorText = "Your Height and Weight must be positive numbers";
      });
      return;
    }

    setState(() {
      bmi = weight / pow((height / 100), 2);
      if (bmi! < 18.5) {
        status = "Underweight";
      } else if (bmi! > 18.5 && bmi! < 25) {
        status = 'Normal weight';
      } else if (bmi! > 25 && bmi! < 30) {
        status = 'Pre-Obesity';
      } else if (bmi! > 30 && bmi! < 35) {
        status = 'Obesity class 1';
      } else if (bmi! > 35 && bmi! < 40) {
        status = 'Obesity class 2';
      } else {
        status = 'Obesity class 3';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     return Column(
      children: [
        Expanded (
        child:Container( 
          margin: const EdgeInsets.all(8),
          height: double.infinity,
          child: SingleChildScrollView(
            child:
            Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text("Do you smoke? : ", style: TextStyle(fontSize: 20)),
          FlutterToggleTab(
            width: 60,
            borderRadius: 20,
            selectedIndex: _tabTextIndexSmokeSelected,
            selectedBackgroundColors: const [Color.fromRGBO(13, 42, 106, 1), Colors.greenAccent],
            selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600),
            unSelectedTextStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400),
            labels: _listSmokeText,
            selectedLabelIndex: (index) {
              setState(() {
                _tabTextIndexSmokeSelected = index;
              });
            },
            marginSelected:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          ),
          
           const SizedBox(
                height: 30,
              ),

          const Text("Are you a sporty person? : ", style: TextStyle(fontSize: 20)),
            FlutterToggleTab(
              width: 90,
              borderRadius: 20,
              selectedIndex: _tabTextIndexSportSelected,
              selectedBackgroundColors: const [Color.fromRGBO(13, 42, 106, 1), Colors.greenAccent],
              selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300),
              unSelectedTextStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w200),
              labels: _listSportText,
              selectedLabelIndex: (index) {
                setState(() {
                _tabTextIndexSportSelected = index;
                });
              },
              marginSelected:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            ),
            const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _heightController,
                keyboardType:TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                  labelText: 'Height (cm)',
                  suffixText: 'centimeters'
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                  suffixText: 'kilograms',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: calculateBMI,
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(13, 42, 106, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0), 
                          ),
                        ), ),
                    child: const Text('Calculate'),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                errorText,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade400,
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            bmi == null ? '00.00' : bmi!.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 60,
                                color:
                                status == 'Underweight' ? Colors.blue
                                    : status == 'Normal weight' ? Colors.green
                                    : status == 'Pre-Obesity' ? Colors.yellow.shade700
                                    : status == 'Obesity class 1' ? Colors.orange
                                    : status == 'Obesity class 2' ? Colors.deepOrangeAccent
                                    : status == 'Obesity class 3' ? Colors.red
                                    : null
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(status,
                                  style: TextStyle(
                                    color:
                                      status == 'Underweight' ? Colors.blue
                                    : status == 'Normal weight' ? Colors.green
                                    : status == 'Pre-Obesity' ? Colors.yellow.shade700
                                    : status == 'Obesity class 1' ? Colors.orange
                                    : status == 'Obesity class 2' ? Colors.deepOrangeAccent
                                    : status == 'Obesity class 3' ? Colors.red
                                    : null
                                  ),
                              ),
                              const Text('BMI',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Container(
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),

                      const SizedBox(height: 30,),
                      const Text('Nutritional Status',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10,),
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
                              child: const Center(child: Text('Underweight', style: TextStyle( fontSize: 8, color: Colors.white))),

                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              color: Colors.green,
                              child: const Center(child: Text('Normal \nweight', style: TextStyle(fontSize: 8, color: Colors.white))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              color: Colors.yellow.shade700,
                              child: const Center(child: Text('Pre-Obesity', style: TextStyle(fontSize: 8, color: Colors.white))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              color: Colors.orange,
                              child: const Center(child: Text('Obesity \nclass 1', style: TextStyle(fontSize: 8, color: Colors.white))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              color: Colors.deepOrangeAccent,
                              child: const Center(child: Text('Obesity \nclass 2', style: TextStyle(fontSize: 8, color: Colors.white))),

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
                              child: const Center(child: Text('Obesity \nclass 3', style: TextStyle(fontSize: 8, color: Colors.white))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('00', style: TextStyle(color: Colors.transparent,)),
                          Text('18.5'),
                          Text('25.0'),
                          Text('30.0'),
                          Text('35.0'),
                          Text('40.0'),
                          Text('00', style: TextStyle(color: Colors.transparent,)),
                        ],
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        )





          )
        )
        )
      ] 
    );
    
  }
}