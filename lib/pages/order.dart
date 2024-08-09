import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/widget_support_style.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/shared_pref.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? foodItemStream;
  String? id, wallet;
  int total = 0, amount2 = 0;

  void StartTimer() {
    Timer(Duration(seconds: 3), () {
      amount2 = total;
      setState(() {});
    });
  }

  getTheSharedPref() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    setState(() {});
  }

  ontheLoad() async {
    await getTheSharedPref();
    foodItemStream = await DatabaseMethods().getFoodCart(id!);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheLoad();
    StartTimer();
  }

  Widget allFoodItemCart() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  total = total + int.parse(ds["Total"]);
                  return Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              height: 90,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text(ds["Quantity"])),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(45),
                              child: Image.network(
                                ds["Image"],
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  ds["Name"],
                                  style: AppWidget.lightBoldTextStyle(),
                                ),
                                Text(
                                  "\$" + ds["Total"],
                                  style: AppWidget.lightBoldTextStyle(),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Center(
                        child: Text(
                      "Food Cart",
                      style: AppWidget.boldHeadlineTextStyle(),
                    )))),
            SizedBox(
              height: 20,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                child: allFoodItemCart()),
            Spacer(),
            Divider(),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.boldTextStyle(),
                  ),
                  Text(
                    "\$" + total.toString(),
                    style: AppWidget.lightBoldTextStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                int amount = int.parse(wallet!) - amount2;
                await DatabaseMethods()
                    .UpdateUserWallet(id!, amount.toString());
                await SharedPreferenceHelper()
                    .saveUserWallet(amount.toString());

                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: Text(
                        "Amount \$${amount2.toStringAsFixed(2)} is Successfully cut From Wallet",
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "CheckOut",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
