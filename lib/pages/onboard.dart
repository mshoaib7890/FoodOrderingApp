import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/content_model.dart';
import 'package:food_delivery_app/Widgets/widget_support_style.dart';
import 'package:food_delivery_app/pages/signup.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: EdgeInsets.only(top: 65, left: 20, right: 20),
                      child: Column(
                        children: [
                          Image.asset(
                            contents[i].image,
                            width: MediaQuery.of(context).size.width,
                            height: 450,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            contents[i].title,
                            style: AppWidget.boldHeadlineTextStyle(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            contents[i].description,
                            style: AppWidget.lightsemiTextStyle(),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    contents.length, (index) => buildDot(index, context)),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                }
                _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                height: 60,
                width: double.infinity,
                margin: EdgeInsets.all(40),
                child: Center(
                    child: Text(
                        currentIndex == contents.length - 1 ? 'Start' : "Next",
                        style: TextStyle(color: Colors.white, fontSize: 20.0))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.0,
      width: currentIndex == index ? 18 : 7,
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.black38),
    );
  }
}
