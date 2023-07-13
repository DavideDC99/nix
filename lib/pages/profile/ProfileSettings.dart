import 'package:flutter/material.dart';
import 'package:nix/pages/profile/ProfileEdit.dart';
import 'package:nix/utils/shared_preferences.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  double? bmi;
  String errorText = '';
  String status = '';

  @override
  Widget build(BuildContext context) {
    var prefs = Provider.of<Preferences>(context, listen: false);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Text _sportLevel(int level) {
      if (prefs.sporty == 0) {
        return Text('Very much', style: TextStyle(fontSize: 20));
      } else if (prefs.sporty == 1) {
        return Text('A lot', style: TextStyle(fontSize: 20));
      } else if (prefs.sporty == 2) {
        return Text('Quite a lot', style: TextStyle(fontSize: 20));
      } else if (prefs.sporty == 3) {
        return Text('A little', style: TextStyle(fontSize: 20));
      } else {
        return Text('Very little', style: TextStyle(fontSize: 20));
      }
    } //_sportLevel

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(13, 42, 106, 1),
          title: const Text('Profile settings',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_circle_left_outlined)
          ),
        ),
        body: Column(
          children: [
            Container(
              height: screenHeight * 0.3,
              child: Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.2,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/others/background.jpg'),
                          fit: BoxFit.cover,
                        )
                      )
                    ),
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
                    )
                  ),
                ],
              ),
            ),

          // Settings
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              'Name: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            prefs.name == null
                              ? Text('')
                              : Text('${prefs.name}', style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              'Surname: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            prefs.surname == null
                              ? Text('')
                              : Text('${prefs.surname}', style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              'Nickname: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            prefs.nickname == null
                              ? Text('')
                              : Text('${prefs.nickname}', style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              'Birthday: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            prefs.birthdate == null
                              ? Text('')
                              : Text('${prefs.birthdate}', style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              'Sex: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            prefs.sex == 0
                              ? Text('Male', style: TextStyle(fontSize: 20))
                              : Text('Female', style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              'Smoking: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            prefs.smoke == 1
                              ? Text('No smoker', style: TextStyle(fontSize: 20))
                              : Text('Smoker', style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(children: [
                          Text(
                            'Sport level: ',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          _sportLevel(prefs.sporty)
                        ])
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(children: [
                          Text(
                            'Height: ',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          prefs.height == null
                            ? Text('')
                            : Text('${prefs.height} cm', style: TextStyle(fontSize: 20),),
                        ])
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(children: [
                          Text(
                            'Weight: ',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          prefs.weight == null
                            ? Text('')
                            : Text('${prefs.weight} kg', style: TextStyle(fontSize: 20))
                        ])
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(children: [
                          Text(
                            'BMI: ',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          prefs.bmi == null
                            ? Text('00.00', style: TextStyle(fontSize: 20))
                            : Text('${prefs.bmi!.toStringAsFixed(2)}', style: TextStyle(fontSize: 20))
                          ])
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade200.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(children: [
                          Text(
                            'BMI status: ',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          prefs.status == null
                            ? Text('')
                            : Text('${prefs.status}', style: TextStyle(fontSize: 20),),
                        ])
                      )
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                    'Nutritional Status',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
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
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(15)),
                                color: Colors.blue,
                              ),
                            child: const Center(
                              child: Text('Underweight',
                                style: TextStyle(fontSize: 8, color: Colors.white)
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 25,
                            color: Colors.green,
                            child: const Center(
                              child: Text('Normal \nweight',
                                style: TextStyle(fontSize: 8, color: Colors.white)
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 25,
                            color: Colors.yellow.shade700,
                            child: const Center(
                              child: Text('Pre-Obesity',
                                style: TextStyle(fontSize: 8, color: Colors.white)
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 25,
                            color: Colors.orange,
                            child: const Center(
                              child: Text('Obesity \nclass 1',
                                style: TextStyle(fontSize: 8, color: Colors.white)
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 25,
                            color: Colors.deepOrangeAccent,
                            child: const Center(
                              child: Text('Obesity \nclass 2',
                                style: TextStyle(fontSize: 8, color: Colors.white)
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 25,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(15)),
                              color: Colors.red,
                            ),
                            child: const Center(
                              child: Text('Obesity \nclass 3',
                                style: TextStyle(fontSize: 8, color: Colors.white)
                              )
                            ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(13, 42, 106, 1)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => ProfileEdit(),),
                          );
                        },
                        child: const Text(
                          'Edit profile',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          )
        ]
      )
    );
  }
}
