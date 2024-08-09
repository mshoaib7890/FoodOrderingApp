import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:food_delivery_app/Widgets/widget_support_style.dart";
import "package:food_delivery_app/admin/home_admin.dart";

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formkey = GlobalKey<FormState>();
  final usernamecontroller = TextEditingController();
  final _pwdcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    usernamecontroller.dispose();
    _pwdcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.only(top: 45, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.black,
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110.0))),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 60, left: 30, right: 30),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const Text(
                          "Lets start with \nAdmin!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 10, bottom: 5),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      controller: usernamecontroller,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter your Name";
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Username",
                                          border: InputBorder.none,
                                          hintStyle:
                                              AppWidget.lightsemiTextStyle()),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 10, bottom: 5),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      controller: _pwdcontroller,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter The Password";
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintText: "password",
                                          border: InputBorder.none,
                                          hintStyle:
                                              AppWidget.lightsemiTextStyle()),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      LoginAdmin();
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                              backgroundColor: Colors.grey,
                                              content:
                                                  Text("Login SuccessFully"));
                                          // Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "LogIn",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  LoginAdmin() async {
    await FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("Your id is not Inccorect ",
                  style: TextStyle(fontSize: 20.0))));
        } else if (result.data()['password'] != _pwdcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("Your password is Incorrect ",
                  style: TextStyle(fontSize: 20.0))));
        } else {
          Route route = MaterialPageRoute(builder: (context) => HomeAdmin());
          Navigator.push(context, route);
        }
        usernamecontroller.clear();
        _pwdcontroller.clear();
      });
    });
    //pop the Loading circle
  }
}
