import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/widget_support_style.dart';
import 'package:food_delivery_app/pages/detail.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/shared_pref.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  bool pizza = false, icecream = false, salad = false, burger = false;

  Stream? foodItemStream;
  String? name;

  sharedPrefs() async {
    name = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }

  onload() async {
    foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
    sharedPrefs();
    setState(() {});
  }

  @override
  void initState() {
    onload();
    super.initState();
  }

  Widget allItem() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    detail: ds['Detail'],
                                    name: ds["Name"],
                                    price: ds["Price"],
                                    image: ds["Image"],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds["Image"],
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(ds["Name"],
                                  style: AppWidget.lightBoldTextStyle()),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("Fresh and Healthy ",
                                  style: AppWidget.lightsemiTextStyle()),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("\$" + ds["Price"],
                                  style: AppWidget.lightBoldTextStyle()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  ///vertical
  ///
  Widget allItemVertically() {
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    detail: ds['Detail'],
                                    name: ds["Name"],
                                    price: ds["Price"],
                                    image: ds["Image"],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10, bottom: 20),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds["Image"],
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ds["Name"],
                                      style: AppWidget.lightBoldTextStyle(),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Honey Goot Cheese",
                                      style: AppWidget.lightsemiTextStyle(),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "\$" + ds["Price"],
                                      style: AppWidget.lightBoldTextStyle(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
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
        margin: EdgeInsets.only(top: 60, left: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello, ${name!}", style: AppWidget.boldTextStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("Delicious Food ", style: AppWidget.boldHeadlineTextStyle()),
              Text("Discover and Get Great Food ",
                  style: AppWidget.lightTextStyle()),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  margin: EdgeInsets.only(right: 20.0), child: showItem()),
              SizedBox(
                height: 20.0,
              ),

              ///calling the Image and other data from firebaSe
              Container(height: 300, child: allItem()),

              SizedBox(
                height: 20,
              ),

              ///third section code
              ///
              ///
              ///
              allItemVertically(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = true;
            pizza = false;
            burger = false;
            salad = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'images/ice-cream.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = true;
            burger = false;
            salad = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Pizza");

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'images/pizza.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            burger = true;
            salad = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Burger");

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'images/burger.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            burger = false;
            salad = true;
            foodItemStream = await DatabaseMethods().getFoodItem("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'images/salad.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
