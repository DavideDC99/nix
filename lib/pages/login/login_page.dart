import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:nix/pages/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

const users = const {
  'test@gmail.com': '12345',
  'test2@gmail.com': '00000',
};
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<String?> _loginUser(LoginData data) async {
    if(!users.containsKey(data.name)){
      return 'User not exists';
    } if (users[data.name] != data.password) {
        return 'Password does not match';
    } else {
      return null;
    }
  } // _loginUser
 
 //FARE (dovrebbe mandare alla profilepage al primo accesso)
  Future<String> _signUpUser(SignupData data) async {
    return 'To be implemented';
  } // _signUpUser


  //FARE
  Future<String> _recoverPassword(String email) async {
    return 'Recover password functionality needs to be implemented';
  } // _recoverPassword

  @override
  Widget build(BuildContext context) {
  final inputBorder = BorderRadius.vertical(
    bottom: Radius.circular(10.0),
    top: Radius.circular(20.0),
  ); 
    return FlutterLogin(
      title: 'NiX',
      logo:  AssetImage('images/logo_login.png'),
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      },
      theme: 
      LoginTheme(
        primaryColor: Color.fromRGBO(13, 42, 106, 1), //background
        accentColor: Color.fromARGB(255, 5, 187, 5),
        errorColor: Colors.deepOrange,
        titleStyle: GoogleFonts.cinzelDecorative(  //titolo
          textStyle: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 138, 167, 217),
                )
      ),
        bodyStyle: TextStyle( //Forgot Password?
          fontStyle: FontStyle.italic,
          //decoration: TextDecoration.overline,
          color: Colors.white,
        ),

        textFieldStyle: TextStyle(
          color: Color.fromRGBO(13, 42, 106, 1), //email/password
         // shadows: [Shadow(color: Color.fromARGB(255, 22, 152, 192), blurRadius: 2)],
        ),

        buttonStyle: TextStyle(  //login e signup
          fontWeight: FontWeight.w800, 
          color: Colors.white, //scritta
        ),

         cardTheme: CardTheme(  //container
          color: Color.fromARGB(240, 25, 117, 187),
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          //shape: ContinuousRectangleBorder(
             // borderRadius: BorderRadius.circular(24.0)),
        ),

        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,  //sfondo input form
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.deepOrange, //scritta
            color: Colors.white,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(  //icone
            borderSide: BorderSide(color: Color.fromRGBO(13, 42, 106, 1), width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(13, 42, 106, 1), width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),

        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: Color.fromRGBO(13, 42, 106, 1),
          highlightColor: Colors.lightGreen,
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),  ),


    ))
    ;
  } // build
} // LoginScreen
