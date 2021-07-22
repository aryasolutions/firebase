import 'dart:convert';

import 'package:firebase/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FacebookLogin facebookSignIn = new FacebookLogin();

facebook_auth(context) async {
  final FacebookLoginResult result =
      await facebookSignIn.logInWithReadPermissions(['email']);

  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final FacebookAccessToken accessToken = result.accessToken;
      print('''
         Logged in!===========================================================================================>
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
      final String token = result.accessToken.token;
      final response = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${token}');
      final profile = jsonDecode(response.body);
      //       print('==========================================================================');
      // print(profile);
      // print('==========================================================================');
      var userData = {
        'username': profile["name"],
        'provider': 'Facebook',
        'email': profile["email"],
        'User id': accessToken.userId,
        'Token': accessToken.token,
        'photoUrl': profile["picture"],
      };
      print(
          '=================================facekook Data=========================================');
      // print(profile['picture.data.url']);
      // print(userData['photoUrl']['data']['url']);
      // var photoUrlR = userData['photoUrl'];
      // print(photoUrlR['data']['url']);

      print(
          '==========================================================================');
      // final FirebaseAuth auth = FirebaseAuth.instance;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(accessToken.userId).get().then((doc) {
        if (doc.exists) {
          doc.reference.update(userData);
        } else {
          users.doc(accessToken.userId).set(userData);
        }
      });
      Navigator.pushReplacementNamed(context, '/Home', arguments: {
        'Name': userData["username"],
        'Email': userData["email"],
        'Profile': userData['photoUrl']['data']['url']
      });

      //       Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Home(),
      //   ),
      // );
      // Navigator.pushNamed(context, '/Home');

      break;
    case FacebookLoginStatus.cancelledByUser:
      print(
          'Error=====================================>Login cancelled by the user.');
      break;
    case FacebookLoginStatus.error:
      // print(
      //     'Error=====================================>Something went wrong with the login process.\n'
      //     'Here\'s the error Facebook gave us:====> ${result.errorMessage}');
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
      );
      AlertDialog alert = AlertDialog(
        title: Center(child: Text("Error")),
        content: Text("${result.errorMessage}"),
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
      break;
  }
}
