import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nix/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {

  IntroScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    PageViewModel(
      title: 'Welcome to the app that cares about your sleep and mental wellbeing!',
      body: 'Here you will find the tools and support you need to improve your wellbeing and promote your mental health. Find out how we can make a difference together and start your journey to wellness today!',
      image: Center(
        child: Image.asset('images/starter_img/starter1.jpg'),
      ),
      decoration: const PageDecoration(
        pageColor: Color.fromARGB(255, 3, 63, 54),
        contentMargin : EdgeInsets.all(20),
        titleTextStyle: TextStyle(
          color:Color.fromARGB(255,228, 84, 84),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20
        )
      ),
    ),
    PageViewModel(
      title: 'Monitor your sleep!',
      body: 'Quality sleep is the key to a peaceful mind. Find out how our sleep monitoring can help you achieve wellness!',
      image: Center(
        child: Image.asset('images/starter_img/starter2.jpg'),
      ),
      decoration: const PageDecoration(
        pageColor: Color.fromARGB(255, 36, 81, 224),
        titleTextStyle: TextStyle(
          color:Color.fromARGB(255, 235, 91, 136),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      )
    ),
    PageViewModel(
      title: 'Do useful monthly tests!',
      body: 'Improve your awareness with monthly tests that help you detect changes and trends!',
      image: Center(
        child: Image.asset('images/starter_img/starter3.jpg'),
      ),
      decoration: const PageDecoration(
        pageColor: Color.fromARGB(255, 5, 226, 215),
        titleTextStyle: TextStyle(
          color:Color.fromARGB(255, 226, 142, 15),
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      )
    ),
    PageViewModel(
      title: 'Discover your health score!',
      body: 'Find out your personalized health score from 0 to 100 by analyzing your sleep, physical activity, and lifestyle!',
      image: Center(
        child: Image.asset('images/starter_img/starter4.png'),
      ),
      decoration: const PageDecoration(
        pageColor: Color.fromARGB(255, 67, 134, 169),
        titleTextStyle: TextStyle(
          color:Color.fromARGB(255, 173, 57, 57),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      )
    ),
    PageViewModel(
      title: 'Discover our tips!',
      body: 'Explore the tips and tricks section, where you will find practical suggestions for achieving restful sleep and cultivating your mental wellbeing!',
      image: Center(
        child: Image.asset('images/starter_img/starter5.jpg'),
      ),
      decoration: const PageDecoration(
      pageColor: Color.fromARGB(255, 26, 141, 186),
        titleTextStyle: TextStyle(
          color:Color.fromARGB(255, 255, 179, 3),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      )
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 150, 155),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 80, 12, 12),
        child: IntroductionScreen(
          globalBackgroundColor:Color.fromARGB(255, 35, 150, 155),
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(5,5),
            color: Colors.white,
            activeSize: Size.square(20),
            activeColor: Color.fromARGB(255, 231, 55, 132),
          ),
          showDoneButton: true,
          done: const Text('Done', style: TextStyle(color: Colors.white, fontSize: 20)),
          showSkipButton: true,
          skip: const Text('Skip', style: TextStyle(color: Colors.white, fontSize: 20)),
          showNextButton: true,
          next: const Icon(Icons.arrow_forward, size: 25, color: Colors.white),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}