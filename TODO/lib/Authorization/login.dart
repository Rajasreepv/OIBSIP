// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:todo/Authorization/signup.dart';
import 'package:todo/global/global.dart';
import 'package:todo/main.dart';

_normalProgress(context) async {
  ProgressDialog pd = ProgressDialog(context: context);
  pd.show(
      msg: 'Processing please wait...',
      progressBgColor: Colors.transparent,
      backgroundColor: Colors.white,
      msgColor: Color.fromARGB(255, 5, 71, 65),
      progressValueColor: Colors.purple);
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController EmailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  loginvalidation() {
    if (!EmailEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email format wrong!!");
    } else if (passwordEditingController.text.length < 5) {
      Fluttertoast.showToast(msg: "password must be atleast 6 characters long");
    } else {
      loginCheck();
      // Navigator.push(context, MaterialPageRoute(builder: (c) => Home()));
    }
  }

  loginCheck() async {
    _normalProgress(context);
    try {
      final User? firebaseUser = (await fAuth.signInWithEmailAndPassword(
              email: EmailEditingController.text,
              password: passwordEditingController.text))
          .user;
      if (firebaseUser != null) {
        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Login Successfull");

        Navigator.push(context, MaterialPageRoute(builder: (c) => Home()));
      } else {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "Error Login!",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error Login!");
      ;
    }
  }

// Color.fromRGBO(208, 191, 255, 1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(208, 191, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Login  ",
                  style: TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 5, 71, 65),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: EmailEditingController,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintStyle: TextStyle(color: Colors.white, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.white, fontSize: 14)),
                ),
                TextFormField(
                  controller: passwordEditingController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintStyle: TextStyle(color: Colors.white, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.white, fontSize: 14)),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                      onPressed: () {
                        loginvalidation();
                      },
                      child: const Text("Login")),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => signupscreen()));
                    },
                    child: const Text(
                      "Dont have an Account ? Register Here",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
