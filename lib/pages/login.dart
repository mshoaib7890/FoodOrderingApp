import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/widget_support_style.dart';
import 'package:food_delivery_app/pages/bottomNavBar.dart';
import 'package:food_delivery_app/pages/firebaseservices.dart';
import 'package:food_delivery_app/pages/forgetpassword.dart';
import 'package:food_delivery_app/pages/signup.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final auth = AuthServices();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFff5c30), Color(0xFFe74b1a)])),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Text(''),
              ),
              Container(
                margin: EdgeInsets.only(top: 55.0, right: 20.0, left: 20.0),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'images/logo.png',
                        width: MediaQuery.of(context).size.width / 1.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5.0,
                      child: Container(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Login",
                              style: AppWidget.boldHeadlineTextStyle(),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: AppWidget.boldTextStyle(),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: AppWidget.boldTextStyle(),
                                  prefixIcon: Icon(
                                    Icons.password,
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Forgetpage()));
                              },
                              child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Forget Password?",
                                    style: AppWidget.boldTextStyle(),
                                  )),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            GestureDetector(
                              onTap: () {
                                login();
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Color(0Xffff5722),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'LOGIN IN',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        "Don't have account ? Signup",
                        style: AppWidget.boldTextStyle(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    final user = await auth.loginWithEmailAndPassword(
        emailController.text, passwordController.text);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text("login Successfully")));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavState()));
    } else if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Center(child: Text("No Account Founded"))));
    }
  }
}
