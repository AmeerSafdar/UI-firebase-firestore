// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task2/resources/firebase_methods.dart';
import 'package:task2/screens/login_screen.dart';
import 'package:task2/screens/main_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
 
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async{
   
       if (FirebaseMethods().userId == null || FirebaseMethods().userId=='') {
           Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const LoginScreen()));
       } else {
         Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const HomeScreen()));
       }
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/img.jpg"),
      ),
    );
  }
}