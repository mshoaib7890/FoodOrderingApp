import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/Widgets/stripe_key.dart';
import 'package:food_delivery_app/admin/add_food.dart';
import 'package:food_delivery_app/admin/admin_login.dart';
import 'package:food_delivery_app/admin/home_admin.dart';
import 'package:food_delivery_app/pages/bottomNavBar.dart';
import 'package:food_delivery_app/pages/home.dart';
import 'package:food_delivery_app/pages/login.dart';
import 'package:food_delivery_app/pages/onboard.dart';
import 'package:food_delivery_app/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the Stripe publishable key
  Stripe.publishableKey = publishableKey;

  // Ensure Firebase is initialized only once
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBuVHgRAsgBjnp4ibRO--wtCVFeg_dWubA",
        appId: "1:298628364274:android:d61fc747f8da4b2cd11d6b",
        messagingSenderId: "298628364274",
        storageBucket: "gs://fooddeliveryapp-c1b5f.appspot.com",
        projectId: "fooddeliveryapp-c1b5f",
      ),
    );
  } catch (e) {
    if (e is FirebaseException && e.code == 'duplicate-app') {
      // If the app is already initialized, do nothing
    } else {
      // Handle other errors
      rethrow;
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? BottomNavState() : Loginpage(),
    );
  }
}
