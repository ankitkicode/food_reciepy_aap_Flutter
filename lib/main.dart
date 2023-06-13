// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_label
import 'package:flutter/material.dart';
import 'package:food_reciepy/screens/splash.dart';
// import 'screens/myhome.dart';

void main() {
 
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: splashScreen(),
    );
  }
}
