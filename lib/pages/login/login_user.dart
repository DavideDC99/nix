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

  Future<bool> _loginUser(
      String name, String password, BuildContext context) async {
    var prefs = Provider.of<Preferences>(context, listen: false);
    String? userName = await prefs.usernameUser;
    String? userPassword = await prefs.passwordUser;
    if (userName == null || userPassword == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var prefs = Provider.of<Preferences>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xFFE4DFD4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFE4DFD4),
        title: const Text('Nix',
            style: TextStyle(
                color: Color(0xFF83AA99),
                fontSize: 28,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text('Login',
                  style: TextStyle(
                      color: Color(0xFF89453C),
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              const Text('Please login to use our app',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Username',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
                controller: userController,
                cursorColor: const Color(0xFF83AA99),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF89453C),
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xFF89453C),
                  ),
                  hintText: 'Username',
                  hintStyle: const TextStyle(color: Color(0xFF89453C)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Password',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                controller: passwordController,
                cursorColor: const Color(0xFF83AA99),
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF89453C),
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Color(0xFF89453C),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _showPassword();
                    },
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Color(0xFF89453C)),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? validation = await _loginUser(userController.text,
                          passwordController.text, context);
                      if (!validation) {
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
                        bool refreshAccessToken =
                            service.checkSavedToken(refresh: true);
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
                            const Color(0xFF89453C))),
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
