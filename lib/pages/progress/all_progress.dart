import 'package:flutter/material.dart';
import 'package:nix/widgets/medal.dart';

class AllProgress extends StatelessWidget {
  const AllProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade700,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                'All time Progress',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 400,
              height: 400,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: const [
                  Medal(
                      imageUnlock: 'images/medal.jpg',
                      imageLock: 'images/medallock.jpg',
                      change: true,
                      description: 'For reaching 300,000 steps in this month'),
                  Medal(
                      imageUnlock: 'images/medal.jpg',
                      imageLock: 'images/medallock.jpg',
                      change: false,
                      description: 'For sleeping 210 hours this month'),
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
    );
  }
}
