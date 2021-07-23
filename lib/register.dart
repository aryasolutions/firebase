import 'package:firebase/control/facebook_auth.dart';
import 'package:firebase/control/googleauth.dart';
import 'package:firebase/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernamecontroller = TextEditingController();
    final TextEditingController useremailcontroller = TextEditingController();
    final TextEditingController userpasswordcontroller =
        TextEditingController();
    void register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // print("objectobjectobjectobjectobjectobjectobjectobjectobject");
      final String username = usernamecontroller.text;
      final String useremail = useremailcontroller.text;
      final String userpassword = userpasswordcontroller.text;
      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: useremail, password: userpassword);
        await firestore.collection("users").doc(user.user.uid).set({
          "username": username,
          "email": useremail,
          "password": userpassword
        });
      Navigator.pushReplacementNamed(context, '/Home',
          arguments: {
            'Name': username,
            'Email': useremail
            });      } catch (e) {
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
      // print([username, useremail, userpassword]);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup',
      title: 'Arya Solutions',
      home: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text('Welcome to Arya Solutions'),
        // ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top:68.0,left: 20,right: 20),
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
              padding: const EdgeInsets.only(top:10.0,left: 15,right: 15),
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Text(
                                'Welcome to Arya Solutions',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30),
                              TextField(
                                controller: usernamecontroller,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Username"),
                              ),
                              SizedBox(height: 15),
                              TextField(
                                controller: useremailcontroller,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Email"),
                              ),
                              SizedBox(height: 15),
                              TextField(
                                controller: userpasswordcontroller,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Password"),
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
                                onPressed: register,
                                child: Text(
                                  'Registration',
                                  // style: TextStyle(fontSize: 10.0),
                                ),
                                color: Colors.blueAccent,
                                textColor: Colors.white,
                              ),
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
                              // SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
                                        // Navigator.pushNamed(context, '/');
                                      },
                                      child: Text(
                                        "I have an account? Login",
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
