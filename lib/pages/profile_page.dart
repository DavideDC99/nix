
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:nix/pages/profile/OthersSettings.dart';;
import 'package:nix/pages/profile/ProfileSettings.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({Key? key}) : super(key: key);


  @override
    State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  
  final _pageController = PageController(initialPage: 0);

  int maxCount = 2;

  /// widget list
  final List<Widget> bottomBarPages = [
    ProfileSettings(),
    OthersSettings(),

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
        backgroundColor: Color.fromRGBO(13, 42, 106, 1),
        title: const Text('Profile settings', style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(onPressed:() {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height*0.8,
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
              color: Color.fromRGBO(13, 42, 106, 1),
              showLabel: true,
              itemLabelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0
                              ),
              notchColor: Color.fromRGBO(21, 78, 199, 1),
              bottomBarItems: [
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.manage_accounts_rounded,
                    color: Color.fromARGB(255, 196, 11, 61),
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Color.fromARGB(255, 5, 187, 5),
                  ),
                  itemLabel: 'Settings',
                ),
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.settings,
                    color:Color.fromARGB(255, 196, 11, 61),
                  ),
                  activeItem: Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 5, 187, 5),
                  ),
                  itemLabel: 'Others',
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