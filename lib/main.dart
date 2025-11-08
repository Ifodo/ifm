import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspiration/pages/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: LandingPage()),
      ),
    );
  }
}
  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UpgradeAlert(
        upgrader: Upgrader(),
        child: Scaffold(
            body: Center(
                child: LandingPage()
            )
        ),
      )
    );
  }*/

