import 'package:flutter/material.dart';
import 'package:nix/pages/homepage.dart';
import 'package:nix/pages/login/login_impact.dart';
import 'package:nix/services/impact.dart';
import 'package:nix/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class LoginUser extends StatefulWidget {
  LoginUser({Key? key}) : super(key: key);

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  static bool _passwordVisible = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var prefs = Provider.of<Preferences>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 42, 106, 1),
      /*
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFE4DFD4),
        title: const Text('Nix',
            style: TextStyle(
                color: Color(0xFF83AA99),
                fontSize: 28,
                fontWeight: FontWeight.bold)),
      ), */
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30,),
              Image.asset('images/others/logo1.png', height: 190, width: 200,),
              const Text('Login',
                  style: TextStyle(
                      color: Color.fromARGB(239, 44, 146, 223),
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              prefs.usernameUser == null || prefs.passwordUser == null ? 
              Text('Choose e-mail and password', style: TextStyle(fontSize: 18, color: Color.fromARGB(239, 44, 146, 223))) : 
              Text('Please login to use our app', style: TextStyle(fontSize: 18, color: Color.fromARGB(239, 44, 146, 223))),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('E-mail',
                    style:
                        TextStyle(fontSize: 18, color:Color.fromARGB(239, 44, 146, 223), fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: userController,
                cursorColor: Color.fromARGB(255, 131, 170, 153),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(239, 44, 146, 223),
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: 'E-mail',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Password',
                    style:
                        TextStyle(fontSize: 18, color:Color.fromARGB(239, 44, 146, 223), fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: passwordController,
                cursorColor: Color.fromARGB(255, 131, 170, 153),
                style: TextStyle(color: Colors.white),
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(239, 44, 146, 223),
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showPassword();
                    },
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (userController.text.isEmpty || passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(8),
                          content: Text('Credentials not inserted'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                      else if (prefs.usernameUser == null || prefs.passwordUser == null) {
                        //new access
                        prefs.usernameUser = userController.text;
                        prefs.passwordUser = passwordController.text;
                        Future.delayed(
                            const Duration(milliseconds: 300),
                            () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginImpact())));
                      } else if (userController.text != prefs.usernameUser ||
                          passwordController.text != prefs.passwordUser) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(8),
                          content: Text('Wrong Credentials'),
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        prefs.logOut = false;
                        ImpactService service =
                            Provider.of<ImpactService>(context, listen: false);
                        bool responseAccessToken = service.checkSavedToken();
                        bool refreshAccessToken = service.checkSavedToken(refresh: true);
                        if (refreshAccessToken && responseAccessToken) {
                          Future.delayed(
                              const Duration(milliseconds: 300),
                              () => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage())));
                        } else if (refreshAccessToken && responseAccessToken == false) {
                          service.refreshTokens();
                          Future.delayed(
                              const Duration(milliseconds: 300),
                              () => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage())));
                        } else {
                          Future.delayed(
                              const Duration(milliseconds: 300),
                              () => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginImpact())));
                        }
                      }
                    },
                    style: ButtonStyle(
                        //maximumSize: const MaterialStatePropertyAll(Size(50, 20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 12)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(239, 44, 146, 223))),
                    child: const Text('Log In'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
