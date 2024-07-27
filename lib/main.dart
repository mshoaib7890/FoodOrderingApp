import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/Widgets/stripe_key.dart';
import 'package:food_delivery_app/pages/onboard.dart';

void main() async {
  Stripe.publishableKey = publishableKey;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBuVHgRAsgBjnp4ibRO--wtCVFeg_dWubA",
          appId: "1:298628364274:android:d61fc747f8da4b2cd11d6b",
          messagingSenderId: "298628364274",
          projectId: "fooddeliveryapp-c1b5f"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnboardPage(),
    );
  }
}
