import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/widget_support_style.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> fooditem = ['Ice-cream', 'Burger', 'Pizza', 'Salad'];
  String? value;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(image!.path);
    });
  }

  uploadItem() async {
    if (selectedImage != null &&
        namecontroller.text != "" &&
        pricecontroller.text != "" &&
        detailcontroller.text != "") {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "Name": namecontroller.text,
        "Price": pricecontroller.text,
        "Detail": detailcontroller.text
      };
      await DatabaseMethods().addFoodImage(addItem, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Food Item has been added Successfully",
              style: TextStyle(fontSize: 18.0),
            )));
      });
    }
    namecontroller.clear();
    pricecontroller.clear();
    detailcontroller.clear();
    setState(() {
      selectedImage = null;
      value = null;
    });
  }

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
          "Add Items",
          style: AppWidget.boldHeadlineTextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Item Picture",
                style: AppWidget.lightBoldTextStyle(),
              ),
              SizedBox(height: 20),
              selectedImage == null
                  ? GestureDetector(
                      onTap: getImage,
                      child: Center(
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black38, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black38, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 30),
              Text("Item Name", style: AppWidget.lightBoldTextStyle()),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Name",
                    hintStyle: AppWidget.lightsemiTextStyle(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Item Price", style: AppWidget.lightBoldTextStyle()),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: pricecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item price",
                    hintStyle: AppWidget.lightsemiTextStyle(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Item Detail", style: AppWidget.lightBoldTextStyle()),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: detailcontroller,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Detail",
                    hintStyle: AppWidget.lightsemiTextStyle(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Add Category", style: AppWidget.lightBoldTextStyle()),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: fooditem
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    dropdownColor: Colors.white,
                    hint: Text("Select Category"),
                    iconSize: 36,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  print("Add button pressed");
                  uploadItem();
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
