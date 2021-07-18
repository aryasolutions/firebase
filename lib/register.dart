import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        print("User is Registered");
        print("User is Registered");
        print("User is Registered");
        print("User is Registered");
      } catch (e) {
        print("Error ==============>$e");
      }
      // print([username, useremail, userpassword]);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arya Solutions',
      home: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text('Welcome to Arya Solutions'),
        // ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(68.0),
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
                  width: 360,
                  // height: 400,
                  child: Center(
                    child: Container(
                      width: 300,
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
                                hintText: "Useremail"),
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
                            child: Text(
                              'Registration',
                              // style: TextStyle(fontSize: 10.0),
                            ),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressed: register,
                          ),
                          // SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Don't have an account? Sign up",
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
