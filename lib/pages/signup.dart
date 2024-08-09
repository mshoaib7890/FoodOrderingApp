import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/widget_support_style.dart';
import 'package:food_delivery_app/pages/bottomNavBar.dart';
import 'package:food_delivery_app/pages/login.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/shared_pref.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String name = "", password = "", email = "";

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Registered Sucessfully",
                style: TextStyle(fontSize: 20.0))));

        ///using Firebase storage to store Data of the User
        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> addUserInfo = {
          "Name": nameController.text,
          "Email": emailController.text,
          "Wallet": '0',
          "id": Id,
        };
        await DatabaseMethods().addUserDetails(addUserInfo, Id);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserName(nameController.text);
        await SharedPreferenceHelper().saveUserEmail(emailController.text);
        await SharedPreferenceHelper().saveUserWallet('0');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavState()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Provided Password is to weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already Exits",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
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
                      elevation: 6.0,
                      child: Container(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "Sign up",
                                style: AppWidget.boldHeadlineTextStyle(),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter  Name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: AppWidget.boldTextStyle(),
                                    prefixIcon: Icon(
                                      Icons.person,
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter  Email";
                                  }
                                  return null;
                                },
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
                              TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter  password";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: AppWidget.boldTextStyle(),
                                    prefixIcon: Icon(
                                      Icons.password,
                                    )),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              SizedBox(
                                height: 65,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      name = nameController.text;
                                      email = emailController.text;
                                      password = passwordController.text;
                                    });
                                  }
                                  registration();
                                },
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Color(0Xffff5722),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text(
                                        'SIGN UP',
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
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loginpage()));
                      },
                      child: Text(
                        "Already have an account? Login",
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
}
