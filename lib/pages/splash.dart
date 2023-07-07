import 'package:flutter/material.dart';
import 'package:nix/pages/homepage.dart';
import 'package:nix/pages/introduction.dart';
import 'package:nix/pages/login/login_impact.dart';
import 'package:nix/pages/login/login_user.dart';
import 'package:nix/services/impact.dart';
import 'package:nix/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  // Method for navigation SplashPage -> IntroScreen
  void _toIntroPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => IntroScreen())));
  }

  // Method for navigation SplashPage -> LoginImpact
  void _toLoginImpact(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginImpact())));
  } //_toLoginImpact

  // Method for navigation SplashPage -> LoginUser
  void _toLoginUser(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginUser())));
  } //_toLoginUser

  // Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => HomePage())));
  } //_toHomePage

  void _checkAuth(BuildContext context) async {
    var prefs = Provider.of<Preferences>(context, listen: false);
    String? username = prefs.usernameUser;
    String? password = prefs.passwordUser;
    bool logOut = prefs.logOut;

    // the user never logged in the app
    if (username == null || password == null) {
      Future.delayed(const Duration(seconds: 1), () => _toIntroPage(context));
    } else {
      if (logOut) {
        Future.delayed(const Duration(seconds: 1), () => _toLoginUser(context));
      } else {
        ImpactService service =
            Provider.of<ImpactService>(context, listen: false);
        bool responseAccessToken = service.checkSavedToken();
        bool refreshAccessToken = service.checkSavedToken(refresh: true);
        // check impact tokens
        if (refreshAccessToken && responseAccessToken) {
          Future.delayed(
              const Duration(seconds: 1), () => _toHomePage(context));
        } else if (refreshAccessToken && responseAccessToken == false) {
          service.refreshTokens();
          Future.delayed(
              const Duration(seconds: 1), () => _toHomePage(context));
        } else {
          Future.delayed(
              const Duration(seconds: 1), () => _toLoginImpact(context));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () => _checkAuth(context));
    return Material(
      child: Container(
        color: Colors.blue.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text(
              'NiX',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 49, 185),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 30, 171, 157)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
