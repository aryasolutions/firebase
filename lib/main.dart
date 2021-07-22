import 'package:firebase/Home.dart';
import 'package:firebase/control/Navigation.dart';
import 'package:firebase/login.dart';
import 'package:firebase/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
              home: Container(
            child: Text("2nd"),
          ));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Navigation();
          // return MaterialApp(
          // debugShowCheckedModeBanner: false,
          //   title: 'Named Routes Demo',
          //   // Start the app with the "/" named route. In this case, the app starts
          //   // on the FirstScreen widget.
          //   initialRoute: '/',
          //   routes: {
          //     // When navigating to the "/" route, build the FirstScreen widget.
          //     '/': (context) => Login(),
          //     // When navigating to the "/second" route, build the SecondScreen widget.
          //     '/Registration': (context) => Registration(),
          //     '/Home': (context) => Home(),
          //   },
          // );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
            home: Container(
          child: Text("2nd"),
        ));
      },
    );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}
