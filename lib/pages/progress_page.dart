import 'package:nix/pages/progress/month_progress.dart';
import 'package:nix/pages/progress/all_progress.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPage();
}

class _ProgressPage extends State<ProgressPage> {
  final _pageController = PageController(initialPage: 0);

  int maxCount = 2;

  final List<Widget> bottomBarPages = [
    MonthProgress(),
    AllProgress(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Progress',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(13, 42, 106, 1),
        //centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_circle_left_outlined, color:Colors.white),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              showBlurBottomBar: false,
              pageController: _pageController,
              color: const Color.fromRGBO(13, 42, 106, 1),
              showLabel: true,
              itemLabelStyle:
                  const TextStyle(color: Colors.white, fontSize: 12.0),
              notchColor: const Color.fromRGBO(21, 78, 199, 1),
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.calendar_today,
                    color: Color.fromARGB(255, 196, 11, 61),
                  ),
                  activeItem: Icon(
                    Icons.calendar_today,
                    color: Color.fromARGB(255, 5, 187, 5),
                  ),
                  itemLabel: 'Month',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 196, 11, 61),
                  ),
                  activeItem: Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 5, 187, 5),
                  ),
                  itemLabel: 'All time',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
