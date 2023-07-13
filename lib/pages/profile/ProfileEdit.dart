import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:nix/pages/profile/ProfileSettings.dart';
import 'package:nix/utils/shared_preferences.dart';
import 'package:nix/widgets/avatar.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime(1920, 01, 01);
  final _listGenderText = ["Male", "Female"];
  final _listIconTabToggle = [Icons.man, Icons.woman];
  final _listSmokeText = ["Yes", "No"];
  final _listSportText = ['Very much', 'A lot', 'Quite a lot', 'A little', 'Very little'];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double? bmi;
  String errorText = '';
  String status = '';

  void calculateBMI() {
    final double? height = double.tryParse(heightController.value.text);
    final double? weight = double.tryParse(weightController.value.text);

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
    var prefs = Provider.of<Preferences>(context, listen: false);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(13, 42, 106, 1),
        title: const Text('Profile edit',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
              height: screenHeight * 0.3,
              child: Stack(children: [
                Container(
                    width: screenWidth,
                    height: screenHeight * 0.2,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/others/background.jpg'),
                            fit: BoxFit.cover),),),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 200,
                      height: 200,
                      margin: const EdgeInsets.all(2),
                      child: FluttermojiCircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 100,
                      ),
                    )),
                Align(
                    alignment: Alignment(0.7, 0.9),
                    child: Container(
                      height: 35,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.edit),
                        label: Text("Customize"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(13, 42, 106, 1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AvatarCustomization())),
                      ),
                    )),
              ])),

          // parte del form
          Expanded(
              child: Container(
                  margin: const EdgeInsets.all(8),
                  //width: double.infinity,
                  //height: screenHeight*0.3,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                      hintText: 'Name:',
                                      labelStyle: TextStyle(fontSize: 20.0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)))))),
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: TextFormField(
                                  controller: surnameController,
                                  decoration: InputDecoration(
                                    hintText: 'Surname:',
                                    labelStyle: TextStyle(fontSize: 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextFormField(
                              controller: nicknameController,
                              decoration: InputDecoration(
                                hintText: 'Nickname:',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromRGBO(13, 42, 106, 1)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                        'Press to select your date of birthday', style: TextStyle(fontSize: 18),),
                                    onPressed: () async {
                                      DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate: date,
                                        firstDate: DateTime(1920),
                                        lastDate: DateTime(2100),
                                      );
                                      if (newDate == null) return;
                                      setState(() => date = newDate);
                                      String dateStr =
                                          date.toString().substring(0, 10);
                                      prefs.birthdate = dateStr;
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("Select your sex : ",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5,),
                                    FlutterToggleTab(
                                      width: 60,
                                      borderRadius: 20,
                                      selectedIndex: prefs.sex,
                                      selectedBackgroundColors: const [
                                        Color.fromRGBO(13, 42, 106, 1),
                                        Colors.greenAccent
                                      ],
                                      selectedTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                      unSelectedTextStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      labels: _listGenderText,
                                      icons: _listIconTabToggle,
                                      selectedLabelIndex: (index) {
                                        setState(() {
                                          prefs.sex = index;
                                        });
                                      },
                                      marginSelected:
                                          const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 4),
                                    ),
                                  ])),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text("Do you smoke? : ",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5,),
                                FlutterToggleTab(
                                  width: 60,
                                  borderRadius: 20,
                                  selectedIndex: prefs.smoke,
                                  selectedBackgroundColors: const [
                                    Color.fromRGBO(13, 42, 106, 1),
                                    Colors.greenAccent
                                  ],
                                  selectedTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  unSelectedTextStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  labels: _listSmokeText,
                                  selectedLabelIndex: (index) {
                                    setState(() {
                                      prefs.smoke = index;
                                    });
                                  },
                                  marginSelected: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text("Are you a sporty person? : ",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5,),
                                FlutterToggleTab(
                                  width: 80,
                                  borderRadius: 20,
                                  selectedIndex: prefs.sporty,
                                  selectedBackgroundColors: const [
                                    Color.fromRGBO(13, 42, 106, 1),
                                    Colors.greenAccent
                                  ],
                                  selectedTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                  unSelectedTextStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w200),
                                  labels: _listSportText,
                                  selectedLabelIndex: (index) {
                                    setState(() {
                                      prefs.sporty = index;
                                    });
                                  },
                                  marginSelected: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                TextField(
                                  controller: heightController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      labelText: 'Height (cm)',
                                      suffixText: 'centimeters'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: weightController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Weight (kg)',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    suffixText: 'kilograms',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      onPressed: calculateBMI,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromRGBO(13, 42, 106, 1)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                      child: const Text('BMI Calculation'),
                                    ),
                                  ],
                                ),
                                Text(
                                  errorText,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              bmi == null
                                                  ? '00.00'
                                                  : bmi!.toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontSize: 60,
                                                  color: status == 'Underweight'
                                                      ? Colors.blue
                                                      : status ==
                                                              'Normal weight'
                                                          ? Colors.green
                                                          : status ==
                                                                  'Pre-Obesity'
                                                              ? Colors.yellow
                                                                  .shade700
                                                              : status ==
                                                                      'Obesity class 1'
                                                                  ? Colors
                                                                      .orange
                                                                  : status ==
                                                                          'Obesity class 2'
                                                                      ? Colors
                                                                          .deepOrangeAccent
                                                                      : status ==
                                                                              'Obesity class 3'
                                                                          ? Colors
                                                                              .red
                                                                          : null),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  status,
                                                  style: TextStyle(
                                                      color: status ==
                                                              'Underweight'
                                                          ? Colors.blue
                                                          : status ==
                                                                  'Normal weight'
                                                              ? Colors.green
                                                              : status ==
                                                                      'Pre-Obesity'
                                                                  ? Colors
                                                                      .yellow
                                                                      .shade700
                                                                  : status ==
                                                                          'Obesity class 1'
                                                                      ? Colors
                                                                          .orange
                                                                      : status ==
                                                                              'Obesity class 2'
                                                                          ? Colors
                                                                              .deepOrangeAccent
                                                                          : status == 'Obesity class 3'
                                                                              ? Colors.red
                                                                              : null),
                                                ),
                                                const Text(
                                                  'BMI',
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
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          'Nutritional Status',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 25,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                          left: Radius.circular(
                                                              15)),
                                                  color: Colors.blue,
                                                ),
                                                child: const Center(
                                                    child: Text('Underweight',
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            color:
                                                                Colors.white))),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 25,
                                                color: Colors.green,
                                                child: const Center(
                                                    child: Text(
                                                        'Normal \nweight',
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            color:
                                                                Colors.white))),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 25,
                                                color: Colors.yellow.shade700,
                                                child: const Center(
                                                    child: Text('Pre-Obesity',
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            color:
                                                                Colors.white))),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 25,
                                                color: Colors.orange,
                                                child: const Center(
                                                    child: Text(
                                                        'Obesity \nclass 1',
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            color:
                                                                Colors.white))),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 25,
                                                color: Colors.deepOrangeAccent,
                                                child: const Center(
                                                    child: Text(
                                                        'Obesity \nclass 2',
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            color:
                                                                Colors.white))),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 25,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                          right:
                                                              Radius.circular(
                                                                  15)),
                                                  color: Colors.red,
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                        'Obesity \nclass 3',
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            color:
                                                                Colors.white))),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text('00',
                                                style: TextStyle(
                                                  color: Colors.transparent,
                                                )),
                                            Text('18.5'),
                                            Text('25.0'),
                                            Text('30.0'),
                                            Text('35.0'),
                                            Text('40.0'),
                                            Text('00',
                                                style: TextStyle(
                                                  color: Colors.transparent,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(13, 42, 106, 1)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                prefs.name = nameController.text;
                                prefs.surname = surnameController.text;
                                prefs.nickname = nicknameController.text;
                                prefs.height = double.tryParse(heightController.value.text).toString();
                                prefs.weight = double.tryParse(weightController.value.text).toString();
                                prefs.bmi = bmi;
                                prefs.status = status;
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ProfileSettings(),
                                  ),
                                );
                              },
                              child: const Text('Save changes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
