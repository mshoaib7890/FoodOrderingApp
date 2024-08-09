import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/Widgets/stripe_key.dart';
import 'package:food_delivery_app/Widgets/widget_support_style.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int? add;
  TextEditingController amountcontroller = TextEditingController();

  getthesharedpref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    if (wallet == null) {
      print('Error: Failed to retrieve wallet from shared preferences');
    }
    if (id == null) {
      print('Error: Failed to retrieve user ID from shared preferences');
    }
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                      elevation: 2.0,
                      child: Container(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                              child: Text(
                            "Wallet",
                            style: AppWidget.boldHeadlineTextStyle(),
                          )))),
                  SizedBox(
                    height: 30.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/wallet.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Wallet",
                                style: AppWidget.boldTextStyle(),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "\$" + wallet!,
                                style: AppWidget.lightsemiTextStyle(),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Add money",
                      style: AppWidget.lightBoldTextStyle(),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          makePayment('100');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE9E2E2)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "\$" + "100",
                            style: AppWidget.lightBoldTextStyle(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          makePayment('500');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE9E2E2)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "\$" + "500",
                            style: AppWidget.lightBoldTextStyle(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          makePayment('1000');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE9E2E2)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "\$" + "1000",
                            style: AppWidget.lightBoldTextStyle(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          makePayment('2000');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE9E2E2)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "\$" + "2000",
                            style: AppWidget.lightBoldTextStyle(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      openEdit();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFF008080),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          "Add Money",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      // Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      // Now finally display payment sheet
      displayPaymentSheet(amount);
    } catch (e, s) {
      print('Exception: $e $s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        add = int.parse(wallet!) + int.parse(amount);

        // Save to shared preferences
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        // Update in Firebase
        await DatabaseMethods().UpdateUserWallet(id!, add.toString());

        // Show success dialog
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Text("Payment Successful"),
                  ],
                ),
              ],
            ),
          ),
        );

        // Refresh shared preferences
        await getthesharedpref();
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error presenting payment sheet: $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('StripeException: $e');
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Payment cancelled"),
        ),
      );
    } catch (e) {
      print('General error: $e');
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('Error creating payment intent: $err');
      return null;
    }
  }

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  openEdit() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 200,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Amount",
                    style: AppWidget.boldTextStyle(),
                  ),
                  TextField(
                    controller: amountcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter amount",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      makePayment(amountcontroller.text);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        "Add Money",
                        style: AppWidget.boldTextStyle()
                            .copyWith(color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
