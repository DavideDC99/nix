import 'package:nix/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:nix/pages/tests/tests_page.dart';
import 'package:nix/pages/tests/stats_page.dart';

class MainTestPage extends StatefulWidget {
  const MainTestPage({super.key});

  @override
  State<MainTestPage> createState() => _MainTestPageState();
}

class _MainTestPageState extends State<MainTestPage> {

  final _pageController = PageController(initialPage: 0);

  int maxCount = 2;

  final List<Widget> bottomBarPages = [
    const TestScreen(),
    StatisticPage(),
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
      backgroundColor: Colors.indigo.shade100,
      appBar: AppBar(
        title: const Text('Test Page'),
        backgroundColor: Color.fromARGB(255, 4, 37, 113),
        elevation:20,
        iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(onPressed:() {
           Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),  //non ritorna nel drawer, direttamente sull'HomePage
                  ),
                );
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined)),
      ),

      body: Container(
        margin: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height*0.78, //per modificare le dimensioni del container che contiene le 2 pagine  
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
      ),
      extendBody:true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              showBlurBottomBar: false,
              //blurOpacity: 0.8, 
              pageController: _pageController,
              color: Color.fromARGB(255, 5, 26, 74),
              showShadow: true,
              showLabel: true,
              itemLabelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16.0
              ),
              notchColor: Color.fromRGBO(21, 78, 199, 1),
              bottomBarItems: const [
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.ballot_outlined,
                    color: Color.fromARGB(255, 196, 11, 61),
                  ),
                  activeItem: Icon(
                    Icons.ballot_rounded,
                    color: Color.fromARGB(255, 5, 187, 5),
                  ),
                  itemLabel: 'Tests',
                ),
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.bar_chart_rounded,
                    color: Color.fromRGBO(167, 6, 17, 0.832),
                  ),
                  activeItem: Icon(
                    Icons.stacked_bar_chart_outlined,
                    color: Color.fromARGB(255, 5, 187, 5,)
                  ),
                  itemLabel: 'Stats',
                ),
 
              ],
              onTap: (index) {
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

