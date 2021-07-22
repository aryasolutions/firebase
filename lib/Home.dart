import 'package:firebase/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String Name = "Null";
  String Email = "Null";
  String photoUrl = "https://via.placeholder.com/150C/O https://placeholder.com/";
  String PhneNo = "Null";
  String Gander = "Null";
  String Adress = "Null";
  String DateofBirth = "Null";

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    print('========================+=Home=+============================');
    print(data);
    print('======================================================');
    // Add item to a Map in Dart/Flutter
    // var threeValue = data.putIfAbsent(3, () => 'THREE');
    // print('Length =====> ${data.length}'); // 2

    // print('isEmpty =====> ${data.isEmpty}'); // false
    // print('isNotEmpty =====> ${data.isNotEmpty}'); // true

    // print('keys =====> ${data.keys}'); // (1, 2)
    // print('values =====> ${data.values}'); // (one, two)

    // print('1st Index =====> ${data['Name']}'); // two
    // print('2nd Index =====> ${data['Email']}');
    setState(() {
      if (data['Name'] != null) {
        Name = data['Name'];
      }
      if (data['Email'] != null) {
        Email = data['Email'];
      }
      if (data['Profile'] != null) {
        photoUrl = data['Profile'];
        print("===================================$photoUrl");
      }
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              // Padding(padding: EdgeInsets.all(10)),
              Row(
                children: [
                  Container(
                    height: 122,
                    width: 122,
                    // width: MediaQuery.of(context).size.width / 3,
                    //  child: Image.network('https://picsum.photos/250?image=9'),
                    // color: Colors.black38,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("$photoUrl"), fit: BoxFit.cover),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          Name,
                          textAlign: TextAlign.left,
                          // textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          Email,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.3),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                data.remove('Name'); 
                                data.remove('Email'); 
                                data.remove('Profile'); 
                                Name = "";
                                Email = "";
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Text(
                              "Logout",
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.purple),
                            )),
                      )
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 15,
              ),
              Text(
                "ACCOUNT INFORMATION",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Name,
                    style: TextStyle(fontSize: 20, color: Colors.black45),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 140),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Update Name"),
                                content: TextField(
                                  decoration: InputDecoration(
                                      // border: OutlineInputBorder(),
                                      hintText: Name),
                                  onChanged: (value) {
                                    Name = value;
                                  },
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                      child: Center(child: Text("Update")))
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 15,
              ),
              Text(
                "Email",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Email,
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),

              SizedBox(
                height: 15,
              ),
              Text(
                "Phone",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                PhneNo,
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),

              SizedBox(
                height: 15,
              ),
              Text(
                "Adress",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Adress,
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),

              SizedBox(
                height: 15,
              ),
              Text(
                'Gander',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Gander,
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),

              SizedBox(
                height: 15,
              ),
              Text(
                "Date of Birth",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateofBirth,
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),
            ],
          ),
        ),
      ),
      //   body: Padding(
      //     padding: const EdgeInsets.only(top: 200),
      //     child: Center(
      //       child: Column(
      //         children: [
      //           // Text(
      //           //   "Home",
      //           //   style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
      //           // ),
      //           SizedBox(height: 50),
      //           Text(
      //             Name,
      //             style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      //           ),
      //           SizedBox(height: 50),
      //           Text(
      //             Email,
      //             style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      //           ),
      //           SizedBox(height: 50),
      //           FlatButton(
      //             child: Text(
      //               'Log Out',
      //             ),
      //             color: Colors.blueAccent,
      //             textColor: Colors.white,
      //             onPressed: () {
      //               setState(() {
      //                 data = {};
      //                 Name = "";
      //                 Email = "";
      //               });
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => Login(),
      //                 ),
      //               );
      //               // Navigator.pushNamed(context, '/');
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
