import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/home.dart';
import 'package:food_delivery_app/pages/order.dart';
import 'package:food_delivery_app/pages/profile.dart';
import 'package:food_delivery_app/pages/wallet.dart';

class BottomNavState extends StatefulWidget {
  const BottomNavState({super.key});

  @override
  State<BottomNavState> createState() => _BottomNavStateState();
}

class _BottomNavStateState extends State<BottomNavState> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late homepage home;
  late Widget currentPage;
  late Wallet wallet;
  late Order order;
  late Profile profile;

  @override
  void initState() {
    home = homepage();
    order = Order();
    wallet = Wallet();
    profile = Profile();
    pages = [home, order, wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.wallet_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              color: Colors.white,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}
