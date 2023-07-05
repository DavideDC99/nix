import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:app_nostra/pages/Datas/ScoreDescription.dart';
import 'package:app_nostra/pages/Datas/ScoreResults.dart';


class MainScorePage extends StatefulWidget {
  const MainScorePage({Key? key}) : super(key: key);

  @override
  State<MainScorePage> createState() => _MainScorePageState();
}

class _MainScorePageState extends State<MainScorePage> {

  final _pageController = PageController(initialPage: 0);

  int maxCount = 2;

  /// widget list
  final List<Widget> bottomBarPages = [
    ScoreResults(),
    ScoreDescription(),

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
      backgroundColor: Color.fromARGB(255, 63, 151, 69),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(63, 101, 151, 1),
        title: const Text('Score', style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(onPressed:() {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined)),
      ),
      body: Container(
        height: 800,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              showBlurBottomBar: false,
              
              pageController: _pageController,
              color: Color.fromRGBO(63, 101, 151, 1),
              showLabel: true,
              itemLabelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0
                              ),
              notchColor: Color.fromARGB(255, 151, 63, 116),
              bottomBarItems: [
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.fact_check,
                    color: Color.fromARGB(255, 239, 74, 83),
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Color.fromARGB(255, 63, 151, 69),
                  ),
                  itemLabel: 'Results',
                ),
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.info,
                    color:Color.fromARGB(255, 239, 74, 83),
                  ),
                  activeItem: Icon(
                    Icons.info,
                    color: Color.fromARGB(255, 63, 151, 69),
                  ),
                  itemLabel: 'Info',
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