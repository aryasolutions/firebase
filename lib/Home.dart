import 'package:firebase/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(208.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Home",
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                FlatButton(
                  child: Text(
                    'Log Out',
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
                    // Navigator.pushNamed(context, '/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
