import 'dart:ffi';

import 'package:firebase/Home.dart';
import 'package:firebase/control/facebook_auth.dart';
import 'package:firebase/control/googleauth.dart';
import 'package:firebase/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController useremailcontroller = TextEditingController();
  final TextEditingController userpasswordcontroller = TextEditingController();

  void register() async {
    Map UserData = {};
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // print("objectobjectobjectobjectobjectobjectobjectobjectobject");
    final String useremail = useremailcontroller.text;
    final String userpassword = userpasswordcontroller.text;
    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: useremail, password: userpassword);
      final DocumentSnapshot snapshot =
          await firestore.collection("users").doc(user.user.uid).get();
      final data = snapshot.data();
      setState(() {
        UserData = data;
        UserData['provider'] = 'Email';
      });
      print(
          '=========================User is Login...=============================');

      print("Name =====> ${UserData["username"]}");
      print("Email =====> ${UserData["email"]}");
      print("Email =====> ${UserData["provider"]}");

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Home(),
      //   ),
      // );
      Navigator.pushReplacementNamed(context, '/Home', arguments: {
        'Name': UserData["username"],
        'Email': UserData["email"],
        'provider': UserData["provider"],
      });
      // print([username, useremail, userpassword]);

    } catch (e) {
      print("Error ==============>$e");
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
      );
      AlertDialog alert = AlertDialog(
        title: Center(child: Text("Error")),
        content: Text("$e"),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Home(),
    //   ),
    // );
    // Navigator.pushReplacementNamed(context, '/Home',arguments:{
    //   'UserData' :
    // });
    // print([username, useremail, userpassword]);
  }

  // Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initstate() {
    super.initState();
    register();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arya Solutions',
      home: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text('Welcome to Arya Solutions'),
        // ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 68.0, left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                          bottomRight: const Radius.circular(40.0),
                          bottomLeft: const Radius.circular(40.0),
                        )),
                    // width: 360,
                    // height: 400,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 15, right: 15),
                        child: Container(
                          // width: 300,
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Text(
                                'Welcome to Arya Solutions',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30),
                              TextField(
                                controller: useremailcontroller,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    hintText: "Email"),
                              ),
                              SizedBox(height: 15),
                              TextField(
                                controller: userpasswordcontroller,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      // color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      print( "===================================================$_obscureText");
                                      _toggle();                                
                                      print( "===================================================$_obscureText");
                                    },
                                  ),
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Forget Password',
                                        style: TextStyle(fontSize: 10.0),
                                      )),
                                ],
                              ),
                              // SizedBox(height: 10),
                              FlatButton(
                                child: Text(
                                  'LogIn',
                                  // style: TextStyle(fontSize: 10.0),
                                ),
                                color: Colors.blueAccent,
                                textColor: Colors.white,
                                onPressed: register,
                              ),
                              // SizedBox(height: 5),
                              SignInButton(
                                Buttons.Google,
                                onPressed: () {
                                  signInWithGoogle(context);
                                },
                              ),
                              SignInButton(
                                Buttons.Facebook,
                                onPressed: () {
                                  facebook_auth(context);
                                },
                              ),
                              // SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Registration(),
                                          ),
                                        );
                                        // Navigator.pushNamed(
                                        //     context, '/Registration');
                                      },
                                      child: Text(
                                        "Don't have an account? Sign up",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
