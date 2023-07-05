import 'package:flutter/material.dart';

import '../widgets/medal.dart';

class MonthProgress extends StatelessWidget {
  const MonthProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade700,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 155, 103, 198),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'January',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 203, 0, 63),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'February',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 157, 37),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'March',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 101, 85, 197),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'April',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 117, 195, 76),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'June',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 64, 126, 194),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'July',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 64, 99, 180),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'August',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 155, 103, 198),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'September',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 203, 0, 63),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'October',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 157, 37),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'November',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 101, 85, 197),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'December',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For reaching 300,000 steps in this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: false,
                                description:
                                    'For sleeping 210 hours this month'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For going to bed 10 times before 11 p.m. this month.'),
                            Medal(
                                imageUnlock: 'images/medal.jpg',
                                imageLock: 'images/medallock.jpg',
                                change: true,
                                description:
                                    'For completing all the tests in this month'),
                          ],
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
