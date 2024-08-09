import "package:flutter/material.dart";
import "package:food_delivery_app/Widgets/widget_support_style.dart";
import "package:food_delivery_app/admin/add_food.dart";

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Color(0xFF373866),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Home Admin",
          style: AppWidget.boldHeadlineTextStyle(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFood()));
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.all(5)),
                      Image.asset(
                        "images/food.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Add Food Items",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
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
