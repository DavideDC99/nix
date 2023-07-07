import 'package:flutter/material.dart';
import 'package:nix/pages/splash.dart';
import 'package:nix/services/impact.dart';
import 'package:nix/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

bool show = true;
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Preferences()..init(), lazy:false),
        Provider(create: (context) => ImpactService(Provider.of<Preferences>(context, listen: false),)),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),  
    ),
    );
  } //build
}//MyApp