import 'package:firebase/Home.dart';
import 'package:firebase/login.dart';
import 'package:firebase/register.dart';
import 'package:flutter/material.dart';


class Navigation extends StatefulWidget {
  const Navigation({ Key? key }) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'Named Routes Demo',
            // Start the app with the "/" named route. In this case, the app starts
            // on the FirstScreen widget.
            initialRoute: '/',
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/': (context) => Login(),
              // When navigating to the "/second" route, build the SecondScreen widget.
              '/Registration': (context) => Registration(),
              '/Home': (context) => Home(),
            },
          );
  }
}