// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task2/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'task2',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          return SplashScreen();
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        }
                      } else if (snapshot.connectionState ==ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue
                          ),
                        );
                      }
                      return SplashScreen();
                    }),
    );
  }
}
