// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_reciepy/screens/myhome.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network("https://i.pinimg.com/564x/e4/6b/e6/e46be6459dc4d30cc535b68331d8b6e7.jpg"),
                // // Center(
                //   child: Container(
                //     alignment: Alignment.center,
                //     child: Text("welcome to recipy\n world",style: TextStyle(
                //       fontSize: 30,color: Colors.black,
                //       fontFamily:"monument",
                      
                //     ),),
                //   ),
                // ),
        
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
