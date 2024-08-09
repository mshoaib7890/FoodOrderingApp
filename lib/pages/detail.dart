import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/widget_support_style.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/shared_pref.dart';
import 'package:random_string/random_string.dart';

class Details extends StatefulWidget {
  String name, detail, price, image;
  Details(
      {required this.image,
      required this.name,
      required this.detail,
      required this.price});
  // const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1, total = 0;

  String? Id;

  getTheSharedpref() async {
    Id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheLoad() async {
    await getTheSharedpref();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total = int.parse(widget.price);
    ontheLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          margin: EdgeInsets.only(top: 55.0, left: 20.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                ),
              ),
              Image.network(
                widget.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: AppWidget.lightBoldTextStyle(),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      a++;
                      total = total + int.parse(widget.price);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    a.toString(),
                    style: AppWidget.boldTextStyle(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (a > 1 && total > 0) {
                        a--;
                        total = total - int.parse(widget.price);
                      }

                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                widget.detail,
                maxLines: 4,
                style: AppWidget.lightsemiTextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Delivery Time",
                    style: AppWidget.boldTextStyle(),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(
                    Icons.alarm,
                    color: Colors.black,
                    weight: 900,
                  ),
                  Text(
                    "30",
                    style: AppWidget.boldTextStyle(),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: AppWidget.boldTextStyle(),
                      ),
                      Text(
                        "\$" + total.toString(),
                        style: AppWidget.boldTextStyle(),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image
                      };
                      await DatabaseMethods().AddFoodToCart(addFoodCart, Id!);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text(
                            "Food Added to Cart",
                            style: TextStyle(fontSize: 18.0),
                          )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Add to cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(3),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
