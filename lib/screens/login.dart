// ignore_for_file: prefer_const_constructors

import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_app/screens/dashboard.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _globalKey = GlobalKey();
  // ignore: prefer_final_fields
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  final db = FirebaseFirestore.instance;

  void signIn() async {
    if (_globalKey.currentState!.validate()) {
      String? email = controller1.text;
      String? password = controller2.text;
      db.collection('users').add({"email": email, "password": password}).then(
          (value) => print(value.id));
      var response = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(email),
        ),
      );
      print(response);
    }
  }

  String? _validateUserName(String? value) {
    return value!.isEmpty ? 'Username is Invaild' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: double.infinity,
              height: 40.0,
            ),
            Image(
              width: 40.0,
              image: AssetImage('resources/images/loginlogo.png'),
            ),
            Text(
              "Sign In",
              style: TextStyle(fontSize: 24.0),
            ),
            Form(
              key: _globalKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: controller1,
                      validator: (value) => _validateUserName(value),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: "Enter Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: controller2,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: signIn,
                  child: Text("Sign in"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Sign up"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 20.0,
            ),
            TextButton(
              onPressed: () {},
              child: Text("Forget Password?"),
            )
          ],
        )),
      ),
    );
  }
}
